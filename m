MIME-Version: 1.0
In-Reply-To: <55633A71.5090405@gatech.edu>
References: <245D3361-0412-466A-BFA1-22F2EDDC18B6@gatech.edu>
 <55617756.4080307@web.de> <5563280B.2040301@gatech.edu>
 <CAPRPZsB59=0nQfZ7pAa-f4g5sG-myA4Z99phWwdmE_XH0cOFUw@mail.gmail.com>
 <55633A71.5090405@gatech.edu>
Date: Mon, 25 May 2015 18:01:15 +0200
Message-ID: <CAPRPZsBu9r-6ZJe0Nuu-OngctajtRwx7YCpERaUH9ooQ9k-tWA@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] 3.14.17 patch initial ram disk hangup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: Jan Kiszka <jan.kiszka@web.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

> You are correct. It looks like if I blacklist the radeon module (which I
> compiled with the kernel as a module, not using a binary), the latencies
> drop to 8-10us. I
>
> Just some ideas; you don't seem to have provided a dmesg log.
>
> Sorry - dmesg log is attached. From just looking at the radeon specific
> messages, I don't quite see what the problem could be except for something
> internal to the radeon driver.

Well, at least we now know that you are running with a HD8xxx GPU, and
what I find intriguing is the date reported by the driver:

[drm] Initialized radeon 2.37.0 20080528 for 0000:01:00.0 on minor 0

I would definitely check your driver. especially verify that fglrx is
NOT running. Apart from that:

[    0.877121] video: module verification failed: signature and/or
required key missing - tainting kernel
[ 0.880890] drm: module has bad taint, not creating trace events
[ 0.884665] radeon: module has bad taint, not creating trace events
...

you have no less than 6 tainting warnings for a kernel you claim to
have built yourself. Are you sure you didn't turn the module
versioning check off ? To me it seems your modules (or not all of
them) and kernel do not match. If so, all bets are off and this setup
could only be running by coincidence. You could even be running
modules that aren't patched at all in a patched kernel.

I also see a 'vboxdrv' driver. I have absolutely no idea what its
impact on I-pipe would be, but it sounds bad to me (along with kvm).
This is the type of thing you would only enable / try when the system
is working properly. I wouldn't even allow it to initialize.

Apart from that, there is indeed not much that can be learnt from your
dmesg log...

Other suggestions include trying to use the on-CPU video (but you must
have the proper chipset for this), remove the Radeon and save some
energy in the process.

It is imperative that you do as Gilles said: minimize the .config
(you'd be amazed how much you can throw away and still keep the Ubuntu
desktop). It compiles much faster and at least you are more likely to
throw an eye on the compile log afterwards.


Jeroen.


>
> Jeroen.
>
>
>
> Yogi
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai
>
>
> --
>
> Yogi A. Patel
> @yapatel525
>

