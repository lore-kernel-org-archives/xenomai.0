Date: Thu, 10 May 2012 18:04:12 +0200 (CEST)
From: aubin.rebillat@domain.hid
Message-ID: <1274569547.144858251.1336665852058.JavaMail.root@domain.hid>
In-Reply-To: <4FABDF16.2090702@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai on the TS-7553 ARM SBC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> =C3=80: "aubin rebillat" <aubin.rebillat@domain.hid>
> Cc: xenomai@xenomai.org
> Envoy=C3=A9: Jeudi 10 Mai 2012 17:30:30
> Objet: Re: [Xenomai-help] Xenomai on the TS-7553 ARM SBC
>=20
> On 05/10/2012 05:18 PM, aubin.rebillat@domain.hid wrote:
> >> root=3D/dev/ram0 means that you are using an initrd, which has been
> >> deprecated for many years.
> >=20
> > I don't really have another option because the board does not
> > support
> > U-BOOT (according to the manufacturer) and due to the specific
> > bootloader on the board I need an initrd : The bootloader only
> > initialises some hardware and loads the kernel image and the initrd
> > in memory before jumping on the kernel code. Then it uses the
> > "linux
> > booting linux" technique to launch debian. I agree with you that it
> > is not the way of doing it today and i suspect the board
> > manufacturer
> > to do so to sell a "fast booting board" because linux is booted in
> > less than 4 secs (of course for debian, it takes really more). They
> > actually made many things that seemed nice when i read the
> > description but when i wanted to develop with it I saw a lot of
> > really strange technique / behaviors (See the UART after for
> > example).
>=20
> There is no difference that I know of from the bootloader side
> whether
> booting with an initrd or an initramfs. Anyway, the only difference
> is
> that initramfs wastes more memory, it is not what is causing the
> problem. Either using an initrd or an initramfs wastes boot time,
> which
> is usually a scarse resource on embedded systems. Whatever the
> bootloader, I do not see what prevents you from passing different
> parameters than "root=3D/dev/ram0" to the kernel, which would be enough
> to
> boot from another device.
>=20
> But all this is unimportant.
>

I'm not that experienced with initrd/initramfs and that was what the manufa=
cturer recommended and i followed it so i can have support from them. But y=
es, at first, i think it can boot from another device.

>=20
> > I will look into the OABI and EABI settings then. I will also set
> > up
> > an NFS file system to mount debian from and see what is happening.
> >=20
> > Thank you Gilles for your reply. I will keep posting about my
> > progresses.
>=20
> The issue may simply well be that your timer code does not work.
> Could
> you post the code for your port? That is, the code you added to get
> it
> work with the I-pipe patch.=20
> Have you checked that linux timer is
> still
> ticking after Xenomai has been started?

No, i did not check that the linux timer is still ticking.
But i think it is because parts of the init script are executed and it is a=
 shell script calling several sub-processes.
Nevertheless, I will put some printk in the linux timer handler to be sure.

>=20
> You can also try to boot with CONFIG_IPIPE but without
> CONFIG_XENOMAI.

I did, and it's booting just fine.

>=20
> Note that in case you do not know it, there is a guide for porting
> the
> I-pipe patch on new ARM platforms:
>=20
> http://www.xenomai.org/index.php/I-pipe:ArmPorting

This is the HOWTO I followed to make the port.

Here is the code :

- Timer :

#ifdef CONFIG_IPIPE
# ifdef CONFIG_NO_IDLE_HZ
#  error "Dynamic tick timer not yet supported with IPIPE"
# endif /* CONFIG_NO_IDLE_HZ */

union tsc_reg
{
#ifdef __BIG_ENDIAN
    struct
    {
        unsigned long high;
        unsigned long low;
    };
#else
    struct
    {
        unsigned long low;
        unsigned long high;
    };
#endif
    unsigned long long full;
};

#ifdef CONFIG_SMP
static union tsc_reg tsc[NR_CPUS];
#else /* !CONFIG_SMP */
static union tsc_reg tsc[1];
#endif

int __ipipe_mach_timerint =3D INTC_TIMER1_BIT_INDEX;
int __ipipe_mach_timerstolen =3D 0;
unsigned __ipipe_mach_ticks_per_jiffy =3D LATCH;
int str8100_timer_initialised =3D 0;
#endif /* CONFIG_IPIPE */


#ifdef CONFIG_IPIPE
void ipipe_mach_update_tsc(void)
{
  union tsc_reg *local_tsc;
  unsigned long stamp;
  unsigned long flags;

  local_irq_save_hw(flags);
  local_tsc =3D &tsc[ipipe_processor_id()];
  stamp =3D str8100_read_timer_counter();
  if (stamp < local_tsc->low)
    local_tsc->high++;
  local_tsc->low =3D stamp;
  local_irq_restore_hw(flags);
}

void __ipipe_mach_acktimer(void)
{
#ifndef CONFIG_VIC_INTERRUPT
  write_seqlock(&xtime_lock);
  str8100_clear_timer_interrupt_status(__ipipe_mach_timerint);
  write_sequnlock(&xtime_lock);
#endif

  ipipe_mach_update_tsc();
}

notrace unsigned long long __ipipe_mach_get_tsc(void)
{
  if (likely(str8100_timer_initialised))
  {
    union tsc_reg *local_tsc, result;
    unsigned long stamp;

    local_tsc =3D &tsc[ipipe_processor_id()];

    __asm__ ("ldmia %1, %M0\n"
             : "=3Dr"(result.full), "+&r"(local_tsc)
             : "m"(*local_tsc));
    barrier();
    stamp =3D str8100_read_timer_counter();
    if (stamp < result.low)
      result.high++;
    result.low =3D stamp;
    return result.full;
  }
  return 0;
}

#ifdef CONFIG_SMP
void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
{
  info->type =3D IPIPE_TSC_TYPE_NONE;
}
#else /* !CONFIG_SMP */
void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
{
  info->type =3D IPIPE_TSC_TYPE_FREERUNNING;
  info->u.fr.counter =3D (unsigned *)(SYSPA_TIMER_BASE_ADDR + 0x40);
  info->u.fr.mask =3D 0xFFFFFFFF;
  info->u.fr.tsc =3D &tsc->full;
}
#endif /* !CONFIG_SMP */

void __ipipe_mach_set_dec(unsigned long delay)
{
  unsigned long flags;

  if (delay > 8)
  {
    local_irq_save_hw(flags);
    TIMER1_MATCH_VALUE1_REG =3D TIMER1_COUNTER_REG + delay;
    local_irq_restore_hw(flags);
  }
  else
    ipipe_trigger_irq(__ipipe_mach_timerint);
}

unsigned long __ipipe_mach_get_dec(void)
{
  return (TIMER1_MATCH_VALUE1_REG - TIMER1_COUNTER_REG);
}

void __ipipe_mach_release_timer(void)
{
  __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
}

#endif /* CONFIG_IPIPE */

- Interrupts :

#ifdef CONFIG_IPIPE
void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
{
  // No cascaded interrupt using the VIC
}
#endif /* CONFIG_IPIPE */

Best regards,

--=20
Aubin REBILLAT

