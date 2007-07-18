Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Jul 2007 12:19:27 +0200
Message-ID: <760425846A1BC44B8BD24361EF2E3451010D9A40@domain.hid>
In-Reply-To: <18077.46993.931365.886132@domain.hid>
References: <760425846A1BC44B8BD24361EF2E3451A69749@domain.hid>
	<18077.46993.931365.886132@domain.hid>
From: "Renner Johannes" <rennj1@domain.hid>
Subject: Re: [Xenomai-help] Writing from user space direct to IO Ports
	withoutmode switches
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Thanks for the quick reply!


Renner Johannes wrote:
> > Hello everyone,
> >
> > The outb functions to control parallel ports in my user mode RT task
> causing inacceptable jitter and make >>the task unstable(-110) at =20
> > higher(10khz) output frequencies. I believe this is due to mode  >
switches form >Primary to the Secondary mode.

>You "believe" ?! You can check what happens using the same method as
ksrc/skins/native/snippets/sigxcpu.c

I checked that and can see the modeswitches before the task crashes(with
the sigxcpu method and in /proc/xenomai/stat)- i guess there would be a
solution as described in the fusion mailing list:
https://mail.rtai.org/pipermail/rtai/2005-July/012390.html but if it was
stable, timing would still be imprecise due to the use of outb

>
> >  I tried to access the
> > ports via /dev/mem and mmap() (method from
xenomai/examples/common/hw_direct_io.c) but thus mapping is=20
> >successful, writing -whatever- to the mapped pointer does not set any
> IO's on my x86.
>
>memory mapped I/O and inb/outb belong to different spaces.



> >  I have read that some Xenomai RT testing with the  > Parallel port
at frequencies above 200khz showed excellent =20
> > results. Which functions are used for such precise timings and are
> they only available in kernel space?

> Most functions available in kernel-space are available in user-space.
Check the API documentation.
>

>					    Gilles Chanteperdrix.

I actually meant functions or methods to write to IO's because the outb
command makes timing at higher frequencies imprecise.

