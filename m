MIME-Version: 1.0
In-Reply-To: <521F409D.4070507@siemens.com>
References: <CAMZj-5M0tr1Mqc7w10gTnfBwkHnY7xq87NOxNtc4TiPuX2_cvA@mail.gmail.com>
	<521F409D.4070507@siemens.com>
Date: Fri, 30 Aug 2013 09:11:31 +0200
Message-ID: <CAMZj-5OASu0jYzT=7JXHjQxULUNhurOTC5RQqt2X=rU0wHMxTA@mail.gmail.com>
From: Asier <atamayoarbide@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Virtualization with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Jan, Nicolas,

Thank you for your help:

> Third option may be even more interesting (provided you really want to
> use Windows for the UI): Run Xenomai on the host and combine it with KVM
> to host another OS. This works fine with latest ipipe for 3.8 when RT
> tasks and the QEMU process (that uses KVM) are on separate CPUs, I just
> heard of issues (couldn't reproduce yet) when they share a CPU.
>
If I am not wrong, KVM runs on top of Linux, and then Windows on top of it.
Isn't it too much overhead? Isn't it better to use a Type 1 virtualization?
When you say separate CPUs, do you mean separate cores?

> Virtualizing your RT workload won't make things faster, naturally.
> Depending on the hypervisor architecture and hardware capabilities, it
> may not be measurable.
>
So, do you mean that, even though the system may be slower, the real-time
response will run smoothly?

> But I would refrain from such stacking unless there is a real need
> (which I do not see for your setup).
>
My plan for the mid term is to run the user interface (HMI) and the
real-time applications in one board. Meanwhile, I need to update my HMI and
I want to use a complete Linux distribution (one with a desktop manager)
with Xenomai. However, I may finally be forced to use Windows (3rd party
programs) and, when porting my system to one board, I would need some
virtualization tools.

Yesterday, I wrote another e-mail asking for opinions about a Linux
distribution with Xenomai, or about any experience with the Yocto project
and Xenomai. Has anyone got any information regarding this?


> In Windows world, use RTX :
http://www.intervalzero.com/products/rtx-rtx64/overview/
>
In fact, if I change from Xenomai Linux to Windows, first I will remove all
the real-time applications from that board and run them in the other one.
Anyway, it's an interesting link.

Thanks again,

Ata




2013/8/29 Jan Kiszka <jan.kiszka@siemens.com>

> On 2013-08-29 13:06, Asier Tamayo Arbide wrote:
> > Hello all,
> >
> > My embedded system has two boards running Linux: one runs the user
> > interface and the other one the critical real-time tasks. Both boards a=
re
> > running Xenomai on an Atom N270 chipset.
> >
> > Now, I am planning to compact my system in just one board and have two
> > options. The first one is to execute everything using Xenomai and the
> > second one is to port my user interface to Windows and to run both
> Windows
> > and Xenomai on top of a hypervisor. My e-mail regards this second optio=
n.
> >
>
> Third option may be even more interesting (provided you really want to
> use Windows for the UI): Run Xenomai on the host and combine it with KVM
> to host another OS. This works fine with latest ipipe for 3.8 when RT
> tasks and the QEMU process (that uses KVM) are on separate CPUs, I just
> heard of issues (couldn't reproduce yet) when they share a CPU.
>
> > I would like to know if anyone has any experience with this. Is the
> > real-time response affected in any way when using a hypervisor? My
> current
> > kernel has been compiled using the ELinOS Embedded Linux distribution.
> Do I
> > have to patch it?
> >
>
> Virtualizing your RT workload won't make things faster, naturally.
> Depending on the hypervisor architecture and hardware capabilities, it
> may not be measurable. But I would refrain from such stacking unless
> there is a real need (which I do not see for your setup).
>
> > I am studying Xen, VmWare, KVM and Enea. Do you recommend any of them?
> The
> > board I=92ll use in the new (compact) system will support virtualizatio=
n
> > extensions (Intel VT).
>
> See above.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
> Corporate Competence Center Embedded Linux
>
