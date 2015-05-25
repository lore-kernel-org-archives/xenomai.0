MIME-Version: 1.0
In-Reply-To: <5563280B.2040301@gatech.edu>
References: <245D3361-0412-466A-BFA1-22F2EDDC18B6@gatech.edu>
 <55617756.4080307@web.de> <5563280B.2040301@gatech.edu>
Date: Mon, 25 May 2015 16:23:42 +0200
Message-ID: <CAPRPZsB59=0nQfZ7pAa-f4g5sG-myA4Z99phWwdmE_XH0cOFUw@mail.gmail.com>
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

> I read around online about interrupt remapping - and I can't seem to find
> anything that hints at why this turning it off would cause the latencies to
> be all over the place.

It shouldn't. There may be other reasons. But beware, in our tests the
Core i5/i7 showed about 29 us max. latency (running dohell), but
depending on the load, that can go up to 70 us (running a handbrake
video encoding session). What you see might actually be the best you
can get.

> Any thoughts/guidance appreciated!

You seem to be running a desktop distribution. Try leaving desktop
mode (kill the window manager / X). Check you're not running binary
graphics drivers. Unload as many drivers as you can.

Just some ideas; you don't seem to have provided a dmesg log.


Jeroen.


>
>
> Yogi
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai

