Message-ID: <4546494d0611062232h26a2e45fgda0ed8bc86f8f465@domain.hid>
Date: Tue, 7 Nov 2006 14:32:50 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
Subject: Re: [Xenomai-core] Xenomai v2.2.5
In-Reply-To: <1162750194.7285.11.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2741_26478878.1162881170845"
References: <1162750194.7285.11.camel@domain.hid>
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

------=_Part_2741_26478878.1162881170845
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Philippe,

Not sure you have noticed this typo or not:

xenomai-2.2.5/ksrc/skins/posix/syscall.c

2674: nt __pse51_call_not_available(struct task_struct *curr, struct pt_regs
*regs)

should be:

int __pse51_call_not_available(struct task_struct *curr, struct pt_regs
*regs)

Regards,

-Yi



On 11/6/06, Philippe Gerum <rpm@xenomai.org> wrote:
>
>
> Here is the fifth maintenance release for the v2.2.x branch.  Short
> log follows:
>
>         [nucleus]
>
>         * Fix period validity check when setting up the timer for
>         periodic timing mode.
>
>         [hal]
>
>         * ppc: Define special wrappers to get/put_user macros which
>         bypass the might_sleep() checks. Upgrade Adeos support.
>
>         * x86: Upgrade Adeos support.
>
>         * arm: Upgrade Adeos support.
>
>         [native]
>
>         * Fix rt_queue_send() upon null broadcast (wrong reference
>         count).
>
>         [posix]
>
>         * Make sure to read interrupt-related macros from the core
>         headers when including posix/pthread.h from user-space.
>
>
> See the ChangeLog for details.
>
> http://download.gna.org/xenomai/stable/xenomai-2.2.5.tar.bz2
>
>
> --
> Philippe.
>
>
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>

------=_Part_2741_26478878.1162881170845
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Philippe,<br><br>Not sure you have noticed this typo or not:<br><br>xenomai-2.2.5/ksrc/skins/posix/syscall.c<br><br>2674: nt __pse51_call_not_available(struct task_struct *curr, struct pt_regs *regs)<br><br>should be:<br>
<br>int __pse51_call_not_available(struct task_struct *curr, struct pt_regs *regs)<br>
<br>Regards,<br><br>-Yi<br><br><br><br><div><span class="gmail_quote">On 11/6/06, <b class="gmail_sendername">Philippe Gerum</b> &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>Here is the fifth maintenance release for the v2.2.x branch.&nbsp;&nbsp;Short<br>log follows:<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[nucleus]<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* Fix period validity check when setting up the timer for<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;periodic timing mode.<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[hal]<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* ppc: Define special wrappers to get/put_user macros which<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bypass the might_sleep() checks. Upgrade Adeos support.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* x86: Upgrade Adeos support.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* arm: Upgrade Adeos support.
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[native]<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* Fix rt_queue_send() upon null broadcast (wrong reference<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;count).<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[posix]<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* Make sure to read interrupt-related macros from the core<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;headers when including posix/pthread.h from user-space.
<br><br><br>See the ChangeLog for details.<br><br><a href="http://download.gna.org/xenomai/stable/xenomai-2.2.5.tar.bz2">http://download.gna.org/xenomai/stable/xenomai-2.2.5.tar.bz2</a><br><br><br>--<br>Philippe.<br><br><br>
<br>_______________________________________________<br>Xenomai-core mailing list<br><a href="mailto:Xenomai-core@domain.hid">Xenomai-core@domain.hid</a><br><a href="https://mail.gna.org/listinfo/xenomai-core">https://mail.gna.org/listinfo/xenomai-core
</a><br></blockquote></div><br>

------=_Part_2741_26478878.1162881170845--

