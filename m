Message-ID: <4B0430E6.30304@domain.hid>
Date: Wed, 18 Nov 2009 18:37:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B042121.2050509@domain.hid>	
	<1258562983.2348.168.camel@domain.hid>	
	<4B042B0F.2080003@domain.hid>
	<1258564904.2348.170.camel@domain.hid>
	<4B042E1C.40505@domain.hid>
In-Reply-To: <4B042E1C.40505@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH] Restore pipeline state on exit from
	ipipe_suspend_domain
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> On Wed, 2009-11-18 at 18:12 +0100, Jan Kiszka wrote:
>>> This fixes the valid complaint about safe_halt being called with the
>>> root domain unstalled.
>> The fix should go to the caller. ipipe_suspend_domain() acts as a
>> logical barrier: after that point, you may assume that the current
>> domain is unstalled.
> 
> The caller so far expect to find no interruption window between return
> from ipipe_suspend_domain and yet another local_irq_disable. It expects
> to remain stalled all the time until safe_halt.

Checked again: Opening the IRQ window here is bogus, may cause
rescheduling delays to Linux (if not much worse things).

I suppose it's better to adjust the assumption that ipipe_suspend_domain
behaves like "sti; hlt". Are there users that rely on this?
__ipipe_walk_pipeline does not look like it would.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

