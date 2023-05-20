I think this should maybe be restructured as a look at html fragments and templating options.

# HTML Templates

In my [opening blog post](./writing-a-blog.md), I mentioned that I wanted to have this be my own little craft area. I enjoy [simple toys](../stuff), and, lately, a lot of those have been about doing things using vanilla JavaScript. Modern JavaScript is really quite capable compared to when I first started using it about 15 years ago. I'm thrilled that it's (relatively) easy to do things like jQuery's `$('#id').click(cb)` (`document.querySelector('#id').onclick(cb)`), lodash's `_.fill(arr, 0)` (`arr.fill(0)`), CoffeeScript's^[0] `class` (`class`), etc.

Similarly, I am very glad that modern HTML has a whole slew of nice semantic tags, such as `<article>`, `<header>`, `<footer>`, etc.

!!! NOTE: I'm not sure about the above. I just want to set the scene for modern niceties. Should also include CSS stuff. !!!

My issue with HTML `<template>`s are that you need JavaScript to actually use them. I know, everyone uses JavaScript, nobody uses NoScript anymore, use the tools of the web, ... I agree. Except, for a simple static site, I truly don't need JavaScript. This is a marked up text document that is not interactive. There are also common elements to the pages here that I don't want to copy and paste.

One solution is to use one of thousands of static site generators, like Jekyll, Hugo, or Next.js. These are all great tools that do more than just templating, but, somtimes, templating is all I want. Why can't I have a file structure like this:

```
~/blog/
      - index.html
      - contact.html
      - about.html
      - fragments/
                 - header.html
                 - footer.html
      - post/
            - writing-a-blog.html
            - html-templates.html
            - ...
```

And then have any web server just host from `~/blog/`?

I was reading the [HTML spec](https://html.spec.whatwg.org), and playing with the [W3 Validator](https://validator.w3.org), and I think I almost can, with a perversion of what's allowed to be considered a conforming HTML document.

```
<!DOCTYPE html>
<title>title</title>
<template id="header"><link href="../fragments/header.html"></template>

<h1>HTML Templates</h1>

<p>In my [opening blog post](./writing-a-blog.md), I mentioned ...</p>

<!-- write rest of blog post here in HTML -->

<template id="footer"><link href="../fragments/footer.html"></template>
```

Things to note:

1. `<!DOCTYPE html>` (case-insensitive) is required, sort of.
2. `<title>` is required.
3. I get a warning not having a `lang` attribute in the (implicit) `html` start tag.

!!! Had some thoughts. !!!

So, here's something awful. I can achieve what I want with `<iframe srcdoc="{doc}"></iframe>`.

This isn't ideal for a number of reasons.

1. Bad accessibility
  - As far as I understand it, screen readers and the like will read the title of iframes before descending into the iframe document node tree, so without a title, it's not great. This can be alleviated by just adding `title="Header information"`, but for some headers/footers, the title information would have to basically be verbatim the same content as the iframe, so if a user wanted to access the header or footer after hearing the title, they'd have to hear it again to get to the content they want.
2. It's an `<iframe>`
  - `<iframe>`s defintely have their uses, but they're also notorious for being the source of tons of malicious work. With the `sandbox` attribute, it's a bit better, but there are still safety concerns.
  - An entire document is generated for each `<iframe>`. For a simple header with just some navigation and a title^[1], and a footer with a link to contact info, this isn't that big of a deal. Where it becomes an issue is in situations like the following. This is really where static site generators shine. However, if each of these are their own documents, there can be performance concerns.

```
<ul>
{#each post of posts}
<li><a href=post.url>post.title</a></li>
{/each}
```

3. It's a lot of HTML in a string
  - One of the nice things about something like Svelte is that it's (mostly) just HTML, so existing tooling mostly works. When everything is wrapped in a string, text editors just consider the whole thing a string, so you lose any sort of semantic awareness of what's happening without using specialized tooling.


## Other options

Ultimately, HTML templating either needs to be handled on the client with JavaScript, or by the server. There is a possible third option where a user agent handles it while parsing the HTML, but there's an issue of grabbing resources. The iframe solution using `src` instead of `srcdoc` is essentially this, but I want to avoid that since it causes more round trips.

I think where I land is having this be handled server-side. I could either have middleware that injects the contents of the files requested, utilizing some caching for performance, or just generate the complete file when publishing. But now I've just gone back to normal static site generators.

This all seems pointless.

[0]: I'm not sure if CoffeeScript was the first to introduce this, actually.
[1]: By title here I mean something like a hero banner of a blog name or company website. The "main" document still needs a `<title>` element, and a `<title>` element in a "iframe header fragment" can't be shared across pages.
