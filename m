Message-ID: <44048252.2060806@domain.hid>
Date: Tue, 28 Feb 2006 18:03:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b647ffbd0602270656m4719d6aes@domain.hid>	
	<4403891C.5070603@domain.hid>
	<b647ffbd0602280120k745ee5e6t@domain.hid>
In-Reply-To: <b647ffbd0602280120k745ee5e6t@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] Shared interrupts (yet another movie :)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Dmitry Adamushko wrote:
> 
> On 28/02/06, *Jan Kiszka* <jan.kiszka@domain.hid <mailto:jan.kiszka@domain.hid>> 
> wrote:
> 
>     Dmitry Adamushko wrote:
>      > ...
>      > Ok, are there any objections as to the current patch? If no,
>     please apply.
>      >
> 
>     Oops, I found a minor problem:
> 
>     make[2]: Entering directory `/usr/src/xenomai/build/doc/doxygen'
>     doxygen
>     /usr/src/xenomai/ksrc/skins/native/intr.c:523: Warning: no matching file
>     member found for
>     int rt_intr_create(RT_INTR *intr, unsigned irq, int mode)
>     Possible candidates:
>       int rt_intr_create(RT_INTR *intr, const char *name, unsigned irq, int
>     mode)
> 
> 
> ...
> 
>     int rt_intr_bind(rt_intr_placeholder *intr, unsigned irq, RTIME timeout)
>     Possible candidates:
>       int rt_intr_bind(RT_INTR *intr, const char *name, RTIME timeout)
>       int rt_intr_bind(RT_INTR *intr, const char *name, RTIME timeout)
> 
>     Seems the doc is not yet up-to-date.
> 
> 
> Thanks. I have overlooked some parts. This patch fixes it up (should be 
> applied after the main patch).
> 
>  

Applied, thanks.

> 
> 
>     Jan
> 
> 
> 
> -- 
> Best regards,
> Dmitry Adamushko


-- 

Philippe.

