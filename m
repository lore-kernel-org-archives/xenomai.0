Message-ID: <e4ef24880710251237s63c024bq241d6d6408fdcd1b@domain.hid>
Date: Thu, 25 Oct 2007 12:37:01 -0700
From: "Robert Gubler" <rgubler@domain.hid>
In-Reply-To: <4720D526.5010803@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2504_12998543.1193341021075"
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB266@domain.hid>
	<4720C9ED.8070402@domain.hid> <4720D056.1010403@domain.hid>
	<4720D526.5010803@domain.hid>
Subject: Re: [Xenomai-help] Problems building Xenomai 2.4-rc4 and linux2.6.23
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_2504_12998543.1193341021075
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I got it working.  Thanks for the help everyone.

-Rob

On 10/25/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Philippe Gerum wrote:
> > Jan Kiszka wrote:
> >> Fillod Stephane wrote:
> >>> Robert Gubler wrote:
> >>> [...]
> >>>>    AS      arch/i386/boot/compressed/head.o
> >>>>    CC      arch/i386/boot/compressed/misc.o
> >>>> In file included from include/linux/ipipe_base.h:29,
> >>>>                   from include/linux/kernel.h:17,
> >>>>                   from include/asm/system.h:4,
> >>>>                   from include/asm/processor.h:18,
> >>>>                   from include/asm/thread_info.h:16,
> >>>>                   from include/linux/thread_info.h:21,
> >>>>                   from include/linux/preempt.h:9,
> >>>>                   from include/linux/spinlock.h:49,
> >>>>                   from include/linux/vmalloc.h:4,
> >>>>                   from arch/i386/boot/compressed/misc.c:14:
> >>>> include/asm/ipipe_base.h:26:25: error: irq_vectors.h: No such file or
>
> >>>> directory
> >>>> make[2]: *** [arch/i386/boot/compressed/misc.o] Error 1
> >>>> make[1]: *** [arch/i386/boot/compressed/vmlinux] Error 2
> >>>> make: *** [bzImage] Error 2
> >>> I had the same issue with this setup(*). It went away when I switched
> >>> the subarch from CONFIG_X86_GENERICARCH (default with FC) to
> CONFIG_X86_PC.
> >>>
> >>> setup:
> >>> linux-2.6.23.1.tar.bz2
> >>> xenomai-2.4-rc4.tar.bz2
> >>> adeos-ipipe-2.6.23-i386-1.10-10.patch
> >>>
> >>> If you do need GENERICARCH, you can tweak
> arch/i386/boot/compressed/Makefile
> >>> and add -I${yourlinuxabsolutepath}/include/asm-i386/mach-default to
> CFLAGS.
> >> The attached patch fixes it (failed to find the time for posting it
> >> earlier, sorry). Philippe, we do need my original version here,
> mflags-y
> >> is not enough (actually, it is not needed now).
> >
> > The proper fix is the one below. Forcing mach-default as your patch does
> > would prevent the per-platform overrides to happen for some headers,
> > like irq_vectors.h. We do need the contents of mflags-y to be passed to
> > the leaf Makefile, verbatim. It's only a matter of proper quoting of
> > theisvariable when running make recursively, actually.
> >
> > diff --git a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
> > index f78f5fe..4e6a230 100644
> > --- a/arch/i386/boot/Makefile
> > +++ b/arch/i386/boot/Makefile
> > @@ -94,7 +94,7 @@ $(obj)/setup.bin: $(obj)/setup.elf FORCE
> >       $(call if_changed,objcopy)
> >
> >  $(obj)/compressed/vmlinux: FORCE
> > -     $(Q)$(MAKE) $(build)=$(obj)/compressed mflags-y=$(mflags-y)
> > IMAGE_OFFSET=$(IMAGE_OFFSET) $@
> > +     $(Q)$(MAKE) $(build)=$(obj)/compressed mflags-y="$(mflags-y)"
> > IMAGE_OFFSET=$(IMAGE_OFFSET) $@
> >
> >  # Set this if you want to pass append arguments to the
> > zdisk/fdimage/isoimage kernel
> >  FDARGS =
> > {rpm@xenomai.org} git diff arch/i386
> > diff --git a/arch/i386/Makefile b/arch/i386/Makefile
> > index 3b17aed..1fc6175 100644
> > --- a/arch/i386/Makefile
> > +++ b/arch/i386/Makefile
> > @@ -128,7 +128,7 @@ all: bzImage
> >  zImage zlilo zdisk: KBUILD_IMAGE := arch/i386/boot/zImage
> >
> >  zImage bzImage: vmlinux
> > -     $(Q)$(MAKE) $(build)=$(boot) mflags-y=$(mflags-y) $(KBUILD_IMAGE)
> > +     $(Q)$(MAKE) $(build)=$(boot) mflags-y="$(mflags-y)"
> $(KBUILD_IMAGE)
> >
> >  compressed: zImage
> >
> > diff --git a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
> > index f78f5fe..4e6a230 100644
> > --- a/arch/i386/boot/Makefile
> > +++ b/arch/i386/boot/Makefile
> > @@ -94,7 +94,7 @@ $(obj)/setup.bin: $(obj)/setup.elf FORCE
> >       $(call if_changed,objcopy)
> >
> >  $(obj)/compressed/vmlinux: FORCE
> > -     $(Q)$(MAKE) $(build)=$(obj)/compressed mflags-y=$(mflags-y)
> > IMAGE_OFFSET=$(IMAGE_OFFSET) $@
> > +     $(Q)$(MAKE) $(build)=$(obj)/compressed mflags-y="$(mflags-y)"
> > IMAGE_OFFSET=$(IMAGE_OFFSET) $@
> >
> >  # Set this if you want to pass append arguments to the
> > zdisk/fdimage/isoimage kernel
> >  FDARGS =
> >
>
> Ack, it's cleaner. Still, the actual problem is the for boot/compressed/
> unneeded, but probably unavoidable indirect inclusion of ipipe_base.h.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux
>

------=_Part_2504_12998543.1193341021075
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I got it working.&nbsp; Thanks for the help everyone.<br><br>-Rob<br><br><div><span class="gmail_quote">On 10/25/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
jan.kiszka@domain.hid</a>&gt; wrote:
</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Philippe Gerum wrote:<br>&gt; Jan Kiszka wrote:<br>&gt;&gt; Fillod Stephane wrote:<br>

&gt;&gt;&gt; Robert Gubler wrote:<br>&gt;&gt;&gt; [...]<br>&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;AS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/i386/boot/compressed/head.o<br>&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/i386/boot/compressed/misc.o<br>&gt;&gt;&gt;&gt; In file included from include/linux/ipipe_base.h:29,
<br>&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/linux/kernel.h:17,<br>&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/asm/system.h:4,<br>&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/asm/processor.h:18,<br>&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/asm/thread_info.h:16,
<br>&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/linux/thread_info.h:21,<br>&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/linux/preempt.h:9,<br>&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/linux/spinlock.h:49,<br>

&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/linux/vmalloc.h:4,<br>&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from arch/i386/boot/compressed/misc.c:14:<br>&gt;&gt;&gt;&gt; include/asm/ipipe_base.h:26:25: error: irq_vectors.h: No such file or
<br>&gt;&gt;&gt;&gt; directory<br>&gt;&gt;&gt;&gt; make[2]: *** [arch/i386/boot/compressed/misc.o] Error 1<br>&gt;&gt;&gt;&gt; make[1]: *** [arch/i386/boot/compressed/vmlinux] Error 2<br>&gt;&gt;&gt;&gt; make: *** [bzImage] Error 2
<br>&gt;&gt;&gt; I had the same issue with this setup(*). It went away when I switched<br>&gt;&gt;&gt; the subarch from CONFIG_X86_GENERICARCH (default with FC) to CONFIG_X86_PC.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; setup:<br>

&gt;&gt;&gt; linux-2.6.23.1.tar.bz2<br>&gt;&gt;&gt; xenomai-2.4-rc4.tar.bz2<br>&gt;&gt;&gt; adeos-ipipe-2.6.23-i386-1.10-10.patch<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; If you do need GENERICARCH, you can tweak arch/i386/boot/compressed/Makefile
<br>&gt;&gt;&gt; and add -I${yourlinuxabsolutepath}/include/asm-i386/mach-default to CFLAGS.<br>&gt;&gt; The attached patch fixes it (failed to find the time for posting it<br>&gt;&gt; earlier, sorry). Philippe, we do need my original version here, mflags-y
<br>&gt;&gt; is not enough (actually, it is not needed now).<br>&gt;<br>&gt; The proper fix is the one below. Forcing mach-default as your patch does<br>&gt; would prevent the per-platform overrides to happen for some headers,
<br>&gt; like irq_vectors.h. We do need the contents of mflags-y to be passed to<br>&gt; the leaf Makefile, verbatim. It&#39;s only a matter of proper quoting of<br>&gt; theisvariable when running make recursively, actually.
<br>&gt;<br>&gt; diff --git a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile<br>&gt; index f78f5fe..4e6a230 100644<br>&gt; --- a/arch/i386/boot/Makefile<br>&gt; +++ b/arch/i386/boot/Makefile<br>&gt; @@ -94,7 +94,7 @@ $(obj)/setup.bin: $(obj)/setup.elf FORCE
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(call if_changed,objcopy)<br>&gt;<br>&gt;&nbsp;&nbsp;$(obj)/compressed/vmlinux: FORCE<br>&gt; -&nbsp;&nbsp;&nbsp;&nbsp; $(Q)$(MAKE) $(build)=$(obj)/compressed mflags-y=$(mflags-y)<br>&gt; IMAGE_OFFSET=$(IMAGE_OFFSET) $@<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; $(Q)$(MAKE) $(build)=$(obj)/compressed mflags-y=&quot;$(mflags-y)&quot;
<br>&gt; IMAGE_OFFSET=$(IMAGE_OFFSET) $@<br>&gt;<br>&gt;&nbsp;&nbsp;# Set this if you want to pass append arguments to the<br>&gt; zdisk/fdimage/isoimage kernel<br>&gt;&nbsp;&nbsp;FDARGS =<br>&gt; {rpm@xenomai.org} git diff arch/i386<br>&gt; diff --git a/arch/i386/Makefile b/arch/i386/Makefile
<br>&gt; index 3b17aed..1fc6175 100644<br>&gt; --- a/arch/i386/Makefile<br>&gt; +++ b/arch/i386/Makefile<br>&gt; @@ -128,7 +128,7 @@ all: bzImage<br>&gt;&nbsp;&nbsp;zImage zlilo zdisk: KBUILD_IMAGE := arch/i386/boot/zImage<br>&gt;
<br>
&gt;&nbsp;&nbsp;zImage bzImage: vmlinux<br>&gt; -&nbsp;&nbsp;&nbsp;&nbsp; $(Q)$(MAKE) $(build)=$(boot) mflags-y=$(mflags-y) $(KBUILD_IMAGE)<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; $(Q)$(MAKE) $(build)=$(boot) mflags-y=&quot;$(mflags-y)&quot; $(KBUILD_IMAGE)<br>&gt;<br>&gt;&nbsp;&nbsp;compressed: zImage
<br>&gt;<br>&gt; diff --git a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile<br>&gt; index f78f5fe..4e6a230 100644<br>&gt; --- a/arch/i386/boot/Makefile<br>&gt; +++ b/arch/i386/boot/Makefile<br>&gt; @@ -94,7 +94,7 @@ $(obj)/setup.bin: $(obj)/setup.elf FORCE
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(call if_changed,objcopy)<br>&gt;<br>&gt;&nbsp;&nbsp;$(obj)/compressed/vmlinux: FORCE<br>&gt; -&nbsp;&nbsp;&nbsp;&nbsp; $(Q)$(MAKE) $(build)=$(obj)/compressed mflags-y=$(mflags-y)<br>&gt; IMAGE_OFFSET=$(IMAGE_OFFSET) $@<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; $(Q)$(MAKE) $(build)=$(obj)/compressed mflags-y=&quot;$(mflags-y)&quot;
<br>&gt; IMAGE_OFFSET=$(IMAGE_OFFSET) $@<br>&gt;<br>&gt;&nbsp;&nbsp;# Set this if you want to pass append arguments to the<br>&gt; zdisk/fdimage/isoimage kernel<br>&gt;&nbsp;&nbsp;FDARGS =<br>&gt;<br><br>Ack, it&#39;s cleaner. Still, the actual problem is the for boot/compressed/
<br>unneeded, but probably unavoidable indirect inclusion of ipipe_base.h.<br><br>Jan<br><br>--<br>Siemens AG, Corporate Technology, CT SE 2<br>Corporate Competence Center Embedded Linux<br></blockquote></div><br>

------=_Part_2504_12998543.1193341021075--

