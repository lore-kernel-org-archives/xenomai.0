Subject: Re: [Xenomai-core] Xenomai v2.2.5
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4546494d0611062232h26a2e45fgda0ed8bc86f8f465@domain.hid>
References: <1162750194.7285.11.camel@domain.hid>
	<4546494d0611062232h26a2e45fgda0ed8bc86f8f465@domain.hid>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 07:55:35 +0100
Message-Id: <1162882535.5025.3.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Li Yi (Adam)" <liyiadam@domain.hid>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

On Tue, 2006-11-07 at 14:32 +0800, Li Yi (Adam) wrote:
> Hi Philippe,
> 
> Not sure you have noticed this typo or not:
> 
> xenomai-2.2.5/ksrc/skins/posix/syscall.c
> 
> 2674: nt __pse51_call_not_available(struct task_struct *curr, struct
> pt_regs *regs)
> 
> should be:
> 
> int __pse51_call_not_available(struct task_struct *curr, struct
> pt_regs *regs)
> 

Fixed, thanks.

> Regards,
> 
> -Yi
> 
> 
> 
> On 11/6/06, Philippe Gerum <rpm@xenomai.org> wrote:
>         
>         Here is the fifth maintenance release for the v2.2.x
>         branch.  Short
>         log follows:
>         
>                 [nucleus]
>         
>                 * Fix period validity check when setting up the timer
>         for
>                 periodic timing mode.
>         
>                 [hal]
>         
>                 * ppc: Define special wrappers to get/put_user macros
>         which
>                 bypass the might_sleep() checks. Upgrade Adeos
>         support.
>         
>                 * x86: Upgrade Adeos support.
>         
>                 * arm: Upgrade Adeos support. 
>         
>                 [native]
>         
>                 * Fix rt_queue_send() upon null broadcast (wrong
>         reference
>                 count).
>         
>                 [posix]
>         
>                 * Make sure to read interrupt-related macros from the
>         core
>                 headers when including posix/pthread.h from
>         user-space. 
>         
>         
>         See the ChangeLog for details.
>         
>         http://download.gna.org/xenomai/stable/xenomai-2.2.5.tar.bz2
>         
>         
>         --
>         Philippe.
>         
>         
>         
>         _______________________________________________
>         Xenomai-core mailing list
>         Xenomai-core@domain.hid
>         https://mail.gna.org/listinfo/xenomai-core
> 
-- 
Philippe.



