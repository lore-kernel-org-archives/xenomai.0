From: "Terry Fryar" <terry.fryar@domain.hid>
References: <F71AC02934794B77BC6691D3173A980B@TerryHP>
	<4F062328.1090309@domain.hid>
In-Reply-To: <4F062328.1090309@domain.hid>
Date: Thu, 5 Jan 2012 16:28:44 -0600
Message-ID: <BD1A5089C77B4964811B0F5AAB5C49DE@TerryHP>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] RTDM and spi
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Philippe Gerum' <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Ah...simple enough!  One question though...are the xenomai sync services
items and irq functions available for non-RT kernel threads??

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org
Sent: Thursday, January 05, 2012 4:25 PM
To: Terry Fryar
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] RTDM and spi

On 01/05/2012 11:12 PM, Terry Fryar wrote:
> Using the RTDM api with Xen 2.6 to develop a linux driver.
> Basically have an ISR registered using *rtdm_irq_request*()that is=20
> triggered from a gpio pin. ISR works fine. Inside ISR, the only thing=20
> done is a *rtdm_event_signal*() on an event.
> Then, I have a task created using *rtdm_task_init*() that is waiting=20
> on the event using *rtdm_event_timedwait*().
> So far, so good...all works. But, in the task I am making an SPI call=20
> after the event is signaled using spi_message_add_tail() and=20
> spi_sync() and that's where I get this:
> BUG: sleeping function called from invalid context at=20
> kernel/mutex.c:278 [ 98.449178] in_atomic(): 1, irqs_disabled(): 0, =
pid:
-555875760, name:
> v=FF=FF=FD=FF=BF=B7=BD=FF=A7=FF=FF=F5>=FF=FF=FDw=BF@=DE=DEP=DE=DE
> [ 98.458686] INFO: lockdep is turned off.
> [ 98.462811] [<c00572ac>] (unwind_backtrace+0x0/0xe0) from=20
> [<c04639bc>]
> (mutex_lock_nested+0x24/0x384)
> [ 98.472501] [<c04639bc>] (mutex_lock_nested+0x24/0x384) from=20
> [<c033ca48>] (__spi_sync+0x88/0xd8) [ 98.481730] [<c033ca48>]=20
> (__spi_sync+0x88/0xd8) from [<bf007180>]
> (irqdrv_task+0x44/0xd4 [irqdrv])
> [ 98.491149] [<bf007180>] (irqdrv_task+0x44/0xd4 [irqdrv]) from=20
> [<c00e93d0>] (xnarch_thread_trampoline+0x20/0x2c)
> [ 98.501845] [<c00e93d0>] (xnarch_thread_trampoline+0x20/0x2c) from=20
> [<c00e5adc>] (__xnpod_schedule+0x5cc/0xa54) [ 98.512355] [<c00e5adc>]=20
> (__xnpod_schedule+0x5cc/0xa54) from [<fff7febf>] (0xfff7febf) [=20
> 98.520674] Xenomai: suspending kernel thread bf008180 ('irqdrvTask')=20
> at 0xc00a92f8 after exception #0x0 I have tried this inside a kthread=20
> and it works fine. I can also try the spi stuff without being=20
> triggered by an IRQ, and I get the same error. I know this is=20
> something simple???

You may not call the regular Linux kernel routines from a real-time =
context.
You have two kernels running side by side, Linux and Xenomai,
unsynchronized. Your RTDM driver is entering __spi_sync() over a =
non-Linux
context, this can't work since that context may have preempted Linux
anywhere, including in the middle of what Linux thinks is an atomic =
section.

Any kernel code you want to call from the real-time co-kernel has to be
adapted to support this. Specifically, you cannot run the regular SPI =
stack
over a real-time RTDM context.

>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.


