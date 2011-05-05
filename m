Message-ID: <4DC299F2.40700@domain.hid>
Date: Thu, 05 May 2011 14:37:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DC2962B.9060802@domain.hid>
In-Reply-To: <4DC2962B.9060802@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] mini2440: ipipe kernel stuck in idle loop after
 xenomai init
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Alexey Galakhov <agalakhov@domain.hid>
Cc: adeos-main@gna.org

On 05/05/2011 02:20 PM, Alexey Galakhov wrote:
> Hi,
> 
> I'm still trying to debug ipipe on the mini2440 board (linux 2.6.35.9 +
> ipipe 1.18.01 + Gilles' ARM patches). Now I encounter the following
> problem. If any Xenomai skin module is loaded the system hangs. In fact,
> it goes into sleep with interrupts off.
> 
> The sleep was in pm_idle() and it is done correctly. The problem lies
> somewhere else. I tried to use busy-loop instead of sleep, like that:
> 
> - if (hlt_counter) {
> + if (1 || hlt_counter) {
> 
> in cpu_idle() (arch/arm/kernel/process.c). Now I found that the loop
> "while (!need_resched())" never exits, need_resched() is always
> returning false and there are no interrupts. Looks like the timer
> interrupt either stops ticking or is masked out since xenomai skin is
> loaded.
> 
> Can you please help to debug it?

You should make sure that pm_idle == default_idle. In this case,
__ipipe_halt_root is called instead of arch_idle, and everything should
work.

> 
> --
> Alex
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
> 


-- 
					    Gilles.

