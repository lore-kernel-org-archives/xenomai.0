Message-ID: <2ff1a98a0708290753v45f17595webd06c7c2b3bed67@domain.hid>
Date: Wed, 29 Aug 2007 16:53:35 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <46D57F2F.5030006@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <904710.33097.qm@domain.hid>
	<2ff1a98a0708290232p1fdbc479i878225139da6fc3c@domain.hid>
	<2ff1a98a0708290620r38e7fad4q81405ee5f06fb615@domain.hid>
	<200708291447.21741.paul_c@domain.hid> <46D57F2F.5030006@domain.hid>
Subject: Re: [Xenomai-help] Re : sqrt() function in xenomai kernel module
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
Cc: Xenomai <xenomai@xenomai.org>

On 8/29/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Paul wrote:
> > On Wednesday 29 August 2007 14:20, Gilles Chanteperdrix wrote:
> >> On 8/29/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> >>> On 8/29/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >>>> Mathieu JOINIE-MAURIN wrote:
> >>>>> The application I used is a small controller for robot developped by
> >>>>> people in the lab. Before it used to be in RTAI. But now they are
> >>>>> trying to use Xenomai. The application is splitted in two parts: the
> >>>>> user side which saves data, manages interfaces and the kernel module
> >>>>> which realise all the real time tisk (sampling, writing to electronic
> >>>>> card, controler). The communications between the two is made by 5
> >>>>> pipes (command, parameters, acknowledgment, save, status).
> >>>>>
> >>>>> This is why i need to make my sqrt() function (of double variables)
> >>>>> into my kernel modul part.
> >>>> Given that this is also a "small" application, I bet it will be far
> >>>> easier for you to port it to user-space (POSIX or native skin) than
> >>>> porting a math lib into kernel space.
> >>> Compiling a libm in kernel-space is not hard at all, especially since
> >>> a libm does not use any system call. But Mathieu could even do a
> >>> simpler thing: if the only math function used is sqrt, he could simply
> >>> add an implementation of this function into his kernel module.
> >> Actually the rtai_math module seems to have no external dependency.
> >> So, you can use it freely with Xenomai. If you want to port it a bit
> >> more cleanly to xenomai, all you have to do is replacing libm_errno
> >> with *xnthread_get_errno_location() (defined in nucleus/thread.h).
> >
> > Running the x86_64 build here, I found a GCC flag (-mno-sse IIRC) being used
> > by the kernel make that prevents any floating point instructions from being
> > used. So a port/cleanup of rtai_math would most likely only work for i386 &
> > ppc architectures..
> >
>
> And that rtai_math stuff is arch-independent, i.e. the slower your CPU
> is, the less efficient that code gets. Back in the old days when we used
> RTAI kernel space modules (LXRT was unstable), we had to hack our own
> i386 math lib with inline assembly for accelerated hw support, thus
> acceptable performance.
>
> Kernel-space math remains a dead end, just the point where it ends may
> vary. We should really encourage people to port away from it whenever
> possible.

Still, I think that having some libm support in kernel-space may help
people when porting their applications to Xenomai.

Of course, if the rtai_math module suffers from some quality issues,
we should not start from it.

-- 
                                               Gilles Chanteperdrix

