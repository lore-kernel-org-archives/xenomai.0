MIME-Version: 1.0
Sender: alexis.berlemont@domain.hid
In-Reply-To: <4AE7EA79.5070904@domain.hid>
References: <4AE7EA79.5070904@domain.hid>
Date: Wed, 28 Oct 2009 09:33:12 +0100
Message-ID: <72cf3fb0910280133o23fbea12pe8c4e2e60b4ede91@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] analog output device with comedi/analogy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonas Buchli <jonas@domain.hid>
Cc: xenomai@xenomai.org

Hi,

On Wed, Oct 28, 2009 at 7:53 AM, Jonas Buchli <jonas@domain.hid> wrote:
> Dear all,
>
> we are trying to get a National Instruments DA/AD card (NI PCIe 6259,
> see link below) working with comedi/analogy.
>
> The drivers seem to be doing something, I can pull up the analog outputs
> to 10V (max voltage) using the example program cmd_write. So I think the
> issues I am having are stemming from not understanding and using the API
> correctly rather than driver issues (but I might be wrong).
>
> Thus, I am trying to understand how to actually write a waveform to the
> analog output and am so far not very successful and the comedi doc seems
> a bit cryptic and scarce to me in this respect.

You are right. There is not enough documentation.

You may already know but here are just a few lines to sum up:
1) Analogy is derivation of Comedi. So we get the same notions:
 - Driver attachment to comedi / analogy device
 - Synchronous acquisition: with instructions;
 - Asynchronous acquisitions: with commands, read, write, mmap, etc.;

Documentation on that point is clearly lacking. This issue will be
solved as soon as possible. In the meantime, you can have a look at
comedi.org documentations. These notions are detailed.

2) Analogy is not just a port, many things have been rewritten:
- We tried to adapt the driver API

- The User API provided by the library (the point in which you have
interest, I guess), has changed too. We have tried to clean-up the
layering, so you will find three layers:
- Level 0: Interface with the kernel side (not to be used);
- Level 1: Interface thanks to the "notions" above (*_snd_insn,
*_snd_cmd, *_cnd_cancel)
- Level 2: Easy access interface (*_sync_read, *_sync_write,
*_async_read, *_async_write + conversion functions)

So if you want to perform a synchronous acquisition,
-> you can just call *_sync_read() (level2), this function will be in
charge of managing the instructions

If you want to perform an asynchronous acquistion,
-> you have to call *_snd_command() (level1: it was difficult to
abstract this notion)
-> after you can call *_async_read() (level2), this function will be
in charge of calling, read(), poll(), etc.

Info on that point can be found in the Doxygen documentation in:
http://www.xenomai.org/documentation/xenomai-head/html/api/index.html

It is a snapshot anterior to the comedi -> analogy renaming; then you
still have to look for Comedi to get the doc.
Xenomai API
  -> Modules
    -> Comedi API
      -> Driver API (not interesting for you I suppose)
      -> Library API
        -> Level 0 API (Syscall API)
        -> Level 1 API
        -> Level 2 API

The "comedi_" prefixes have to be replaced by "a4l_" (that was why I
used "*_" as prefix in these few lines).

I will try to add more docs as soon as possible.

> - Does anyone have example code how this is done?

So far, the example code is located in our little test programs set
(cmd_read, cmd_write, insn_read). I tried to make them easy to read
(everything is linear).

Feel free to tell what you expect.

> - Is the correct procedure to issue first a command (comedi_snd_command)
> and then use the write command (comedi_sys_write) to achieve this?
>
> - Interestingly the write command (comedy_sys_write) is not the one
> responsible for pulling up the output, it seems to already happen in the
> comedi_snd_command.
>
> - My current approach was trying to modify the cmd_write example. Is
> this a good idea?

I think so.

> Any help and pointers would be greatly appreciated!
>
> Thanks a lot and best regards
> Jonas
>
>
> PS:
> Card being used NI PCIe 6259:
> http://sine.ni.com/nips/cds/view/p/lang/en/nid/14128
>
>

Alexis.

