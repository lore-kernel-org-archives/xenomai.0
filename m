Message-ID: <4857682B.8060900@domain.hid>
Date: Tue, 17 Jun 2008 09:30:51 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4856B7AE.9030805@domain.hid>
In-Reply-To: <4856B7AE.9030805@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Compile-time bug,
	and problem with PPC440 ethernet
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
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

Steven A. Falco wrote:
> I am building kernel 2.6.25.4 from DENX with Xenomai 2.4.4 for PPC440EPx
> (sequoia development board).
> 
> The kernel tries to use DHCP to obtain network settings.  With IPIPE
> disabled, this works perfectly.  However, when I enable IPIPE, the board
> sends packets ok, but does not receive packets - I can see the DHCP with
> a sniffer, but the development board does not receive them.
>

External interrupts are probably locked out by the pipeline engine; I've fixed a
similar issue in recent patches for other PICs. Which I-pipe patch release are
you using?

> Also, in order to disable IPIPE, I had to patch
> kernel/time/tick-common.c around line 168.  It is missing an ifdef:
> 
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 58bfacf..3a735b8 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -163,9 +163,11 @@ static void tick_setup_device(struct tick_device *td,
> 
>         td->evtdev = newdev;
> 
> +#ifdef CONFIG_IPIPE
>         /* I-pipe: derive global tick IRQ from CPU 0 */
>         if (cpu == 0)
>                 ipipe_update_tick_evtdev(newdev);
> +#endif
> 
>         /*
>          * When the device is not per cpu, pin the interrupt to the
> 
> Signed-off-by: Steve Falco <sfalco@domain.hid>
> 
> If anyone has suggestions as to why IPIPE is blocking received ethernet
> packets, I'd appreciate it.
> 
>     Steve
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Philippe.

