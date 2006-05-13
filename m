Message-ID: <32862.84.156.104.36.1147511124.squirrel@domain.hid>
In-Reply-To: <44658F8A.6090709@domain.hid>
References: <6ee4c8380605012208xf8f9bb6p5eb542d8fb8da567@domain.hid>
	<4458949A.10606@domain.hid> <44658F8A.6090709@domain.hid>
Date: Sat, 13 May 2006 11:05:24 +0200 (CEST)
Subject: Re: [Xenomai-help] Xenomai in a VM
From: weigold@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, "Brian L." <bluczkie@domain.hid>

We are running Xenomai inside VMWare hosted on OpenSuse 10.0 and Windows
XP for quite a while now. Xenomai kernelspace and userspace applications
can be developed and tested. Since you are aware it=92s not realtime at a=
ll
and you don=92t have to deal with real hardware you get a very flexible
development environment.

Harald

> Jan Kiszka wrote:
>> Brian L. wrote:
>>> Has anyone tried running Xenomai inside a virtual machine (i.e. Qemu,
>>> Parallels, VMWare, bochs, simics)? Is there any reason to expect this
>>> to fail? In theory, the virtualization software should appear as a
>>> vanilla x86 to the OS running inside of it, but I'd imagine xenomai
>>> could potentially tweak bits of the cpu/architecture that are not as
>>> supported by the virtualization software .
>>>
>>> Of course, I wouldn't expect any real-time characteristics or
>>> performance to speak of. This would be for development/testing only.
>>>
>>> Thoughts?
>
>> Should work, just give it a try. We once started to play with our full
>> embedded distro under bochs, but I do not recall right now how far we
>> came - need to check with the person who actually did the work.
>>
>
> Meanwhile I'm running a VM myself: QEMU. No problems, it just works
> without any trick, also with RT software or with kgdb attached to the
> Xenomai kernel.
>
> Jan
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>



