MIME-Version: 1.0
In-Reply-To: <52204A62.7040005@siemens.com>
References: <CAMZj-5M0tr1Mqc7w10gTnfBwkHnY7xq87NOxNtc4TiPuX2_cvA@mail.gmail.com>
	<521F409D.4070507@siemens.com>
	<CAMZj-5OASu0jYzT=7JXHjQxULUNhurOTC5RQqt2X=rU0wHMxTA@mail.gmail.com>
	<52204A62.7040005@siemens.com>
Date: Fri, 30 Aug 2013 12:22:44 +0200
Message-ID: <CAMZj-5NoALKD0KWzFYT-j3+hmcUKwnEYS61Gf4S2hoSMQEvX1Q@mail.gmail.com>
From: Asier <atamayoarbide@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Once again, thank you.Your last email was really helpful.

If I understand it correctly, for my system it is better to use the KVM
approach, that is, leave the Xenomai Linux running on top of the HW and the
Windows on KVM. Though this solution may have some overhead, the real-time
behaviour will be the same as before. Am I correct? Or it can't be said for
sure?

Regarding the Xenomai-aware Linux distributions, I'll have a look at the
debian packages for Xenomai. ELDK has no Intel support. I may consider
WindRiver Linux and Enea Linux, as well as using the Yocto tools themselves.

Best regards,

Asier







2013/8/30 Jan Kiszka <jan.kiszka@siemens.com>

> On 2013-08-30 09:11, Asier wrote:
> > Jan, Nicolas,
> >
> > Thank you for your help:
> >
> >> Third option may be even more interesting (provided you really want to
> >> use Windows for the UI): Run Xenomai on the host and combine it with KVM
> >> to host another OS. This works fine with latest ipipe for 3.8 when RT
> >> tasks and the QEMU process (that uses KVM) are on separate CPUs, I just
> >> heard of issues (couldn't reproduce yet) when they share a CPU.
> >>
> > If I am not wrong, KVM runs on top of Linux, and then Windows on top of
> it.
> > Isn't it too much overhead? Isn't it better to use a Type 1
> virtualization?
>
> Type 1 vs. type 2 is usually just marketing nonsense. You can do device
> pass-through with KVM as well, thus removing most of the I/O
> virtualization overhead, achieving near-native performance. Moreover, in
> contrast to several other hypervisors, KVM can benefit a lot from its
> architectural advantage to run hosted on Linux which reduced context
> switches on x86.
>
> > When you say separate CPUs, do you mean separate cores?
>
> Usually, this means cores (on a single-socket system).
>
> >
> >> Virtualizing your RT workload won't make things faster, naturally.
> >> Depending on the hypervisor architecture and hardware capabilities, it
> >> may not be measurable.
> >>
> > So, do you mean that, even though the system may be slower, the real-time
> > response will run smoothly?
>
> No general rule, depends on your hypervisor.
>
> >
> >> But I would refrain from such stacking unless there is a real need
> >> (which I do not see for your setup).
> >>
> > My plan for the mid term is to run the user interface (HMI) and the
> > real-time applications in one board. Meanwhile, I need to update my HMI
> and
> > I want to use a complete Linux distribution (one with a desktop manager)
> > with Xenomai. However, I may finally be forced to use Windows (3rd party
> > programs) and, when porting my system to one board, I would need some
> > virtualization tools.
> >
> > Yesterday, I wrote another e-mail asking for opinions about a Linux
> > distribution with Xenomai, or about any experience with the Yocto project
> > and Xenomai. Has anyone got any information regarding this?
>
> There are debian packages for Xenomai, but it is trivial to build it for
> any distro of your preference. Yocto-wise: ELDK, which should come with
> Xenomai support IIRC, is based on yocto these days.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
> Corporate Competence Center Embedded Linux
>
