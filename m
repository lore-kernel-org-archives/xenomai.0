Message-ID: <508573C7.5080103@openwide.fr>
Date: Mon, 22 Oct 2012 18:26:47 +0200
From: Romain Naour <romain.naour@openwide.fr>
MIME-Version: 1.0
References: <50812949.5040403@openwide.fr>
	<50814532.5090408@xenomai.org>	<5082CD5C.1040409@openwide.fr>
	<5082DED2.1050405@xenomai.org>	<50835162.5020401@openwide.fr>
	<50844242.7010107@xenomai.org>	<5084863E.7030900@openwide.fr>
	<508547AC.7020103@xenomai.org> <508552A9.7020608@xenomai.org>
In-Reply-To: <508552A9.7020608@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] s3c24xx with clocksource/clockevent (kernel 3.2.21)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Le 22/10/2012 16:05, Gilles Chanteperdrix a =C3=A9crit :
> On 10/22/2012 03:18 PM, Gilles Chanteperdrix wrote:
>
>> Another candidate would be irq_enable in kernel/irq/chip.c, shut off t=
he
>> irqs around the whole section, or move irq_state_clk_masked before the
>> call to irq_unmask with a compiler barrier.
>
> Actually, the following patch fixes another bug I had, so, could you
> check if it fixes yours? (and thanks for the explanations, they were
> very helpful).
>
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index f5d8d5e..cef1e78 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -167,8 +167,10 @@ int irq_startup(struct irq_desc *desc, bool resend=
)
>   	desc->depth =3D 0;
>  =20
>   	if (desc->irq_data.chip->irq_startup) {
> +		unsigned long flags =3D hard_cond_local_irq_save();
>   		ret =3D desc->irq_data.chip->irq_startup(&desc->irq_data);
>   		irq_state_clr_masked(desc);
> +		hard_cond_local_irq_restore(flags);
>   	} else {
>   		irq_enable(desc);
>   	}
> @@ -192,12 +194,14 @@ void irq_shutdown(struct irq_desc *desc)
>  =20
>   void irq_enable(struct irq_desc *desc)
>   {
> +	unsigned long flags =3D hard_cond_local_irq_save();
>   	irq_state_clr_disabled(desc);
>   	if (desc->irq_data.chip->irq_enable)
>   		desc->irq_data.chip->irq_enable(&desc->irq_data);
>   	else
>   		desc->irq_data.chip->irq_unmask(&desc->irq_data);
>   	irq_state_clr_masked(desc);
> +	hard_cond_local_irq_restore(flags);
>   }
>  =20
>   void irq_disable(struct irq_desc *desc)
> @@ -211,11 +215,13 @@ void irq_disable(struct irq_desc *desc)
>  =20
>   void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu)
>   {
> +	unsigned long flags =3D hard_cond_local_irq_save();
>   	if (desc->irq_data.chip->irq_enable)
>   		desc->irq_data.chip->irq_enable(&desc->irq_data);
>   	else
>   		desc->irq_data.chip->irq_unmask(&desc->irq_data);
>   	cpumask_set_cpu(cpu, desc->percpu_enabled);
> +	hard_cond_local_irq_restore(flags);
>   }
>  =20
>   void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu)
>
>
Indeed, it fixes my bug without modifying the samsung driver :)
Thank you.

> As explained on the page I directed you too, converting a spinlock to a=
n
> ipipe_spinlock is not something that should be done lightly. Otherwise,
> you might well end-up with large masking sections, so, I would try and
> find what section needs to run with irqs off, and only disable irqs for
> that section.
I can see that, IRQs are only disabled during the call of irq_enable().
It's better :)

Here is the trace:
I-pipe worst-case tracing service on 3.2.21/ipipe release #1
-------------------------------------------------------------
CPU: 0, Begin: 156240209 cycles, Trace Points: 22 (-3500/+85), Length:=20
1380 us
Calibrated minimum trace-point overhead: 0.600 us

  +----- Hard IRQs ('|': locked)
  |+-- Xenomai
  ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
  |||                          +---------- Delay flag ('+': > 1 us, '!':=20
 > 10 us)
  |||                          |        +- NMI noise ('N')
  |||                          |        |
      +func               -1750    2.400  uart_start+0x10 (uart_write+0x1=
34)
      #func               -1747    2.800  __uart_start+0x10=20
(uart_start+0x50)
      #func               -1745    3.200 s3c24xx_serial_start_tx+0x10=20
(__uart_start+0x54)
      #func               -1741    1.600  enable_irq+0x14=20
(s3c24xx_serial_start_tx+0xc4)
      #func               -1740    4.600 __irq_get_desc_lock+0x10=20
(enable_irq+0x2c)
      #func               -1735    2.200  __enable_irq+0x10=20
(enable_irq+0x64)
      #func               -1733    3.200  irq_enable+0x10=20
(__enable_irq+0xac)
  |   #(0x01)  0x00000001 -1730    1.000  irq_enable+0x3c=20
(__enable_irq+0xac)
  |   #(0x02)  0x00000001 -1729    2.000  irq_enable+0x54=20
(__enable_irq+0xac)
  |   #func               -1727    2.200 s3c_irq_uart0_unmask+0x10=20
(irq_enable+0x7c)
  |   #(0x01)  0x00000001 -1725    1.000  irq_enable+0x9c=20
(__enable_irq+0xac)
  |   #(0x02)  0x00000000 -1724    3.800  irq_enable+0xb4=20
(__enable_irq+0xac)
  |   #func               -1720    2.800 __ipipe_grab_irq+0x10=20
(__irq_svc+0x24)
  |   #func               -1717    2.800 __ipipe_dispatch_irq+0x10=20
(__ipipe_grab_irq+0x54)
  |   #func               -1714    1.800 __ipipe_ack_irq+0x10=20
(__ipipe_dispatch_irq+0x94)
  |   #func               -1712    1.600 s3c_irq_demux_uart0+0x10=20
(__ipipe_ack_irq+0x1c)
  |   #func               -1711    1.600 s3c_irq_demux_uart+0x10=20
(s3c_irq_demux_uart0+0x1c)
  |   #func               -1709    1.400 __ipipe_dispatch_irq+0x10=20
(s3c_irq_demux_uart+0x54)
  |   #func               -1708    1.800 __ipipe_ack_irq+0x10=20
(__ipipe_dispatch_irq+0x94)
  |   #func               -1706    1.200 __ipipe_ack_level_irq+0x10=20
(__ipipe_ack_irq+0x1c)
  |   #func               -1705    2.600 s3c_irq_uart0_ack+0x10=20
(__ipipe_ack_level_irq+0x34)
  |   #(0x01)  0x00000001 -1702    1.000 __ipipe_ack_level_irq+0x78=20
(__ipipe_ack_irq+0x1c)
  |   #(0x02)  0x00000001 -1701    3.000 __ipipe_ack_level_irq+0x90=20
(__ipipe_ack_irq+0x1c)
  |   #func               -1698    4.600 __ipipe_set_irq_pending+0x10=20
(__ipipe_dispatch_irq+0x120)
  |   #func               -1694    2.200 __ipipe_do_sync_pipeline+0x10=20
(__ipipe_dispatch_irq+0x16c)
  |   #func               -1691    1.600 __ipipe_exit_irq+0x10=20
(__ipipe_grab_irq+0x5c)
  |   #func               -1690    2.400=20
__ipipe_check_root_interruptible+0x10 (__irq_svc+0x94)
      #func               -1687    1.600 check_irq_resend+0x10=20
(__enable_irq+0xb8)
      #func               -1686    1.600 __irq_put_desc_unlock+0x10=20
(enable_irq+0x74)
      #func               -1684    1.200 ipipe_unstall_root+0x10=20
(uart_start+0x5c)
  |   +func               -1683    3.600 __ipipe_do_sync_stage+0x10=20
(ipipe_unstall_root+0x3c)

Regards,
Romain

