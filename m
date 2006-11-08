Message-ID: <4546494d0611080053o75c30c2ev81898fcbab473fa1@domain.hid>
Date: Wed, 8 Nov 2006 16:53:14 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
Subject: Re: [Xenomai-core] Xenomai v2.2.5
In-Reply-To: <1162882535.5025.3.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_26087_21348960.1162975994567"
References: <1162750194.7285.11.camel@domain.hid>
	<4546494d0611062232h26a2e45fgda0ed8bc86f8f465@domain.hid>
	<1162882535.5025.3.camel@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org, xenomai@xenomai.org

------=_Part_26087_21348960.1162975994567
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Another typo in xenomai-2.2.5/ksrc/drivers/testing/timerbench.c:

412:
printk("%s: bad ioctl code (0x%x)\n", _ _FUNCTION_, request);
should be:
printk("%s: bad ioctl code (0x%x)\n", _ _FUNCTION_ _, request);

-Yi

On 11/7/06, Philippe Gerum <rpm@xenomai.org> wrote:
>
> On Tue, 2006-11-07 at 14:32 +0800, Li Yi (Adam) wrote:
> > Hi Philippe,
> >
> > Not sure you have noticed this typo or not:
> >
> > xenomai-2.2.5/ksrc/skins/posix/syscall.c
> >
> > 2674: nt __pse51_call_not_available(struct task_struct *curr, struct
> > pt_regs *regs)
> >
> > should be:
> >
> > int __pse51_call_not_available(struct task_struct *curr, struct
> > pt_regs *regs)
> >
>
> Fixed, thanks.
>
> > Regards,
> >
> > -Yi
> >
> >
> >
> > On 11/6/06, Philippe Gerum <rpm@xenomai.org> wrote:
> >
> >         Here is the fifth maintenance release for the v2.2.x
> >         branch.  Short
> >         log follows:
> >
> >                 [nucleus]
> >
> >                 * Fix period validity check when setting up the timer
> >         for
> >                 periodic timing mode.
> >
> >                 [hal]
> >
> >                 * ppc: Define special wrappers to get/put_user macros
> >         which
> >                 bypass the might_sleep() checks. Upgrade Adeos
> >         support.
> >
> >                 * x86: Upgrade Adeos support.
> >
> >                 * arm: Upgrade Adeos support.
> >
> >                 [native]
> >
> >                 * Fix rt_queue_send() upon null broadcast (wrong
> >         reference
> >                 count).
> >
> >                 [posix]
> >
> >                 * Make sure to read interrupt-related macros from the
> >         core
> >                 headers when including posix/pthread.h from
> >         user-space.
> >
> >
> >         See the ChangeLog for details.
> >
> >         http://download.gna.org/xenomai/stable/xenomai-2.2.5.tar.bz2
> >
> >
> >         --
> >         Philippe.
> >
> >
> >
> >         _______________________________________________
> >         Xenomai-core mailing list
> >         Xenomai-core@domain.hid
> >         https://mail.gna.org/listinfo/xenomai-core
> >
> --
> Philippe.
>
>
>

------=_Part_26087_21348960.1162975994567
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Another typo in xenomai-2.2.5/ksrc/drivers/testing/timerbench.c:<br><br>412: <br>printk(&quot;%s: bad ioctl code (0x%x)\n&quot;, _ _FUNCTION_, request);<br>should be:<br>printk(&quot;%s: bad ioctl code (0x%x)\n&quot;, _ _FUNCTION_ _, request);
<br><br>-Yi<br><br><div><span class="gmail_quote">On 11/7/06, <b class="gmail_sendername">Philippe Gerum</b> &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Tue, 2006-11-07 at 14:32 +0800, Li Yi (Adam) wrote:<br>&gt; Hi Philippe,<br>&gt;<br>&gt; Not sure you have noticed this typo or not:<br>&gt;<br>&gt; xenomai-2.2.5/ksrc/skins/posix/syscall.c<br>&gt;<br>&gt; 2674: nt __pse51_call_not_available(struct task_struct *curr, struct
<br>&gt; pt_regs *regs)<br>&gt;<br>&gt; should be:<br>&gt;<br>&gt; int __pse51_call_not_available(struct task_struct *curr, struct<br>&gt; pt_regs *regs)<br>&gt;<br><br>Fixed, thanks.<br><br>&gt; Regards,<br>&gt;<br>&gt; -Yi
<br>&gt;<br>&gt;<br>&gt;<br>&gt; On 11/6/06, Philippe Gerum &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Here is the fifth maintenance release for the v2.2.x<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; branch.&nbsp;&nbsp;Short
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; log follows:<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [nucleus]<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Fix period validity check when setting up the timer<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; periodic timing mode.
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [hal]<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * ppc: Define special wrappers to get/put_user macros<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; which<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bypass the might_sleep() checks. Upgrade Adeos<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; support.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * x86: Upgrade Adeos support.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * arm: Upgrade Adeos support.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [native]<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Fix rt_queue_send() upon null broadcast (wrong
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reference<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count).<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [posix]<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Make sure to read interrupt-related macros from the<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; core<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; headers when including posix/pthread.h from
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user-space.<br>&gt;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; See the ChangeLog for details.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://download.gna.org/xenomai/stable/xenomai-2.2.5.tar.bz2">http://download.gna.org/xenomai/stable/xenomai-2.2.5.tar.bz2
</a><br>&gt;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Philippe.<br>&gt;<br>&gt;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _______________________________________________<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Xenomai-core mailing list<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="mailto:Xenomai-core@domain.hid">
Xenomai-core@domain.hid</a><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="https://mail.gna.org/listinfo/xenomai-core">https://mail.gna.org/listinfo/xenomai-core</a><br>&gt;<br>--<br>Philippe.<br><br><br></blockquote></div><br>

------=_Part_26087_21348960.1162975994567--

