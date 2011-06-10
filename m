Message-ID: <4DF1A188.5050303@domain.hid>
Date: Fri, 10 Jun 2011 06:46:00 +0200
From: Uwe Fechner <u.fechner@domain.hid>
MIME-Version: 1.0
References: <BANLkTimhH=Tk9xERNHD0wh7ZbXzYaB3xrA@mail.gmail.com>
In-Reply-To: <BANLkTimhH=Tk9xERNHD0wh7ZbXzYaB3xrA@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------090404050408020303060202"
Subject: Re: [Xenomai-help] Need help to use Xenomai on Debian (even after
 reading the wesite tutorial)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Luis Rossi <luisf.rossi@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090404050408020303060202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

 Hello,

you could try to follow my way of doing it:
http://www.kieltech.de/uweswiki/Xenomai

I did it on Ubuntu, but it should work with Debian, too (the only thing
that I don't know
is, whether you need an additional step to update the initial ramdisk
after installing
the packages.
Please give feedback, if it works with Debian (and with which version of
Debian and
with which additional steps, if any), so that I can add this information
to my wiki-page.

I try to answer some of your other questions inline:

On 10.06.2011 03:45, Luis Rossi wrote:
> Hi, 
>
> I am trying to use Xenomai with Debian, but i am kind lost here. Even
> after reading
> this: http://www.xenomai.org/index.php/Building_Debian_packages, i
> could not figure out how to use Xenomai on a Debian with a x86. I am
> really not experienced with linux kernel. 
>
> First of all i have a few questions. If Xenomais is a patch, why
> should i build a patched kernel? Is it no suposed to patch an already
> built kernel?
Two possible reasons:
1. I would not try to patch a debian kernel, because it already has a
lot of other patches, that could cause conflicts.
I would only patch a native kernel from kernel.org.
2. The newest kernels (which are default on Ubunutu 10.10, I don't know
about debian) are not supported by xenomai.
>
> Why there isnt available already built kernels for every architecture?
>
Building a kernel for xenomai really depends on your hardware. You
really have to tweak the .config options, to make it work. A kernel,
that works well on one computer might not work well (with a low latency)
on another computer. Building generic kernels is hardly possible.
> On a final stage i need to use xenomai on a PC104 with an Atom, with
> no keyboard, Mouse or display, and a debian system with just the baisc
> packages, a ssh server and Xenomai. What wouldbe the most portable way
> to use Xenomai so i can replicate that system easily?
>
>
> On the Web page is said "For development, linux-patch-xenomai and
> libxenomai-dev are needed, for "production" systems, you should just
> need xenomai-runtime und libxenomai1 (together with the self built
> kernel as described in the next section)." What development means?
> Development of Xenomai itself?
>
> Can any one provide me an explanations for dummies on how to build a
> debian with xenomai, with a simple explanation on what is being made
> and why?
>
> Thank you!
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
----------------------------------------
Uwe Fechner, M.Sc.
Delft University of Technology
Faculty of Aerospace Engineering/ASSET
Kluyverweg 1,
2629 HS Delft, The Netherlands
Phone: +31-15-27-88902


--------------090404050408020303060202
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
    <title></title>
  </head>
  <body text="#000000" bgcolor="#ffffff">
    Hello,<br>
    <br>
    you could try to follow my way of doing it:<br>
    <a class="moz-txt-link-freetext" href="http://www.kieltech.de/uweswiki/Xenomai">http://www.kieltech.de/uweswiki/Xenomai</a><br>
    <br>
    I did it on Ubuntu, but it should work with Debian, too (the only
    thing that I don't know<br>
    is, whether you need an additional step to update the initial
    ramdisk after installing<br>
    the packages.<br>
    Please give feedback, if it works with Debian (and with which
    version of Debian and<br>
    with which additional steps, if any), so that I can add this
    information to my wiki-page.<br>
    <br>
    I try to answer some of your other questions inline:<br>
    <br>
    On 10.06.2011 03:45, Luis Rossi wrote:
    <blockquote
      cite="mid:BANLkTimhH=Tk9xERNHD0wh7ZbXzYaB3xrA@mail.gmail.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      Hi,&nbsp;
      <div><br>
      </div>
      <div>I am trying to use Xenomai with Debian, but i am kind lost
        here. Even after reading this:&nbsp;<a moz-do-not-send="true"
          href="http://www.xenomai.org/index.php/Building_Debian_packages">http://www.xenomai.org/index.php/Building_Debian_packages</a>,
        i could not figure out how to use Xenomai on a Debian with a
        x86. I am really not experienced with linux kernel.&nbsp;</div>
      <div><br>
      </div>
      <div>First of all i have a few questions. If Xenomais is a patch,
        why should i build a patched kernel? Is it no suposed to patch
        an already built kernel?</div>
    </blockquote>
    Two possible reasons:<br>
    1. I would not try to patch a debian kernel, because it already has
    a lot of other patches, that could cause conflicts.<br>
    I would only patch a native kernel from kernel.org.<br>
    2. The newest kernels (which are default on Ubunutu 10.10, I don't
    know about debian) are not supported by xenomai.<br>
    <blockquote
      cite="mid:BANLkTimhH=Tk9xERNHD0wh7ZbXzYaB3xrA@mail.gmail.com"
      type="cite">
      <div><br>
      </div>
      <div>Why there isnt available already built kernels for every
        architecture?</div>
      <div><br>
      </div>
    </blockquote>
    Building a kernel for xenomai really depends on your hardware. You
    really have to tweak the .config options, to make it work. A kernel,
    that works well on one computer might not work well (with a low
    latency) on another computer. Building generic kernels is hardly
    possible.<br>
    <blockquote
      cite="mid:BANLkTimhH=Tk9xERNHD0wh7ZbXzYaB3xrA@mail.gmail.com"
      type="cite">
      <div>On a final stage i need to use xenomai on a PC104 with an
        Atom, with no keyboard, Mouse or display, and a debian system
        with just the baisc packages, a ssh server and Xenomai. What
        wouldbe the most portable way to use Xenomai so i can replicate
        that system easily?</div>
      <div><br>
      </div>
      <div><br>
        On the Web page is said "<span class="Apple-style-span"
          style="font-family: sans-serif; font-size: 13px; line-height:
          19px;">For development, linux-patch-xenomai and libxenomai-dev
          are needed, for "production" systems, you should just need
          xenomai-runtime und libxenomai1 (together with the self built
          kernel as described in the next section)." What development
          means? Development of Xenomai itself?</span></div>
      <div><font class="Apple-style-span" face="sans-serif"><span
            class="Apple-style-span" style="line-height: 19px;"><br>
          </span></font></div>
      <div><font class="Apple-style-span" face="sans-serif"><span
            class="Apple-style-span" style="line-height: 19px;">Can any
            one provide me an explanations for dummies on how to build a
            debian with xenomai, with a simple explanation on what is
            being made and why?<br>
          </span></font></div>
      <div><font class="Apple-style-span" face="sans-serif"><span
            class="Apple-style-span" style="line-height: 19px;"><br>
          </span></font>
      </div>
      <div><font class="Apple-style-span" face="sans-serif"><span
            class="Apple-style-span" style="line-height: 19px;">Thank
            you!</span></font></div>
      <pre wrap="">
<fieldset class="mimeAttachmentHeader"></fieldset>
_______________________________________________
Xenomai-help mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a>
<a class="moz-txt-link-freetext" href="https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/listinfo/xenomai-help</a>
</pre>
    </blockquote>
    <br>
    <br>
    <pre class="moz-signature" cols="72">-- 
----------------------------------------
Uwe Fechner, M.Sc.
Delft University of Technology
Faculty of Aerospace Engineering/ASSET
Kluyverweg 1,
2629 HS Delft, The Netherlands
Phone: +31-15-27-88902</pre>
  </body>
</html>

--------------090404050408020303060202--

