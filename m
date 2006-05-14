Message-ID: <6ee4c8380605141440g6e756934m2332a79def2f01d7@domain.hid>
Date: Sun, 14 May 2006 17:40:09 -0400
From: "Brian L." <bluczkie@domain.hid>
Sender: zorander@domain.hid
Subject: Re: [Xenomai-help] Xenomai in a VM
In-Reply-To: <6ee4c8380605131006n2d65d745v5f09c350ed97c566@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <6ee4c8380605012208xf8f9bb6p5eb542d8fb8da567@domain.hid>
	<4458949A.10606@domain.hid> <44658F8A.6090709@domain.hid>
	<32862.84.156.104.36.1147511124.squirrel@domain.hid>
	<6ee4c8380605131006n2d65d745v5f09c350ed97c566@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "weigold@domain.hid" <weigold@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Update: Xenomai runs swimmingly in both Parallels and Q (qemu
repackaged) on my intel mac. Since my normal mode of development is
headless, I can run parallels in the background and then develop
through terminal as usual...except without lugging around the dev
machine.



On 5/13/06, Brian L. <bluczkie@domain.hid> wrote:
> Great...I haven't gotten around to trying it out, but I hopefully will
> soon. I wonder how qemu does on intel macs...
>
>
> On 5/13/06, weigold@domain.hid <weigold@domain.hid> wrote:
> > We are running Xenomai inside VMWare hosted on OpenSuse 10.0 and Window=
s
> > XP for quite a while now. Xenomai kernelspace and userspace application=
s
> > can be developed and tested. Since you are aware it's not realtime at a=
ll
> > and you don't have to deal with real hardware you get a very flexible
> > development environment.
> >
> > Harald
> >
> > > Jan Kiszka wrote:
> > >> Brian L. wrote:
> > >>> Has anyone tried running Xenomai inside a virtual machine (i.e. Qem=
u,
> > >>> Parallels, VMWare, bochs, simics)? Is there any reason to expect th=
is
> > >>> to fail? In theory, the virtualization software should appear as a
> > >>> vanilla x86 to the OS running inside of it, but I'd imagine xenomai
> > >>> could potentially tweak bits of the cpu/architecture that are not a=
s
> > >>> supported by the virtualization software .
> > >>>
> > >>> Of course, I wouldn't expect any real-time characteristics or
> > >>> performance to speak of. This would be for development/testing only=
.
> > >>>
> > >>> Thoughts?
> > >
> > >> Should work, just give it a try. We once started to play with our fu=
ll
> > >> embedded distro under bochs, but I do not recall right now how far w=
e
> > >> came - need to check with the person who actually did the work.
> > >>
> > >
> > > Meanwhile I'm running a VM myself: QEMU. No problems, it just works
> > > without any trick, also with RT software or with kgdb attached to the
> > > Xenomai kernel.
> > >
> > > Jan
> > >
> > > _______________________________________________
> > > Xenomai-help mailing list
> > > Xenomai-help@domain.hid
> > > https://mail.gna.org/listinfo/xenomai-help
> > >
> >
> >
> >
>

