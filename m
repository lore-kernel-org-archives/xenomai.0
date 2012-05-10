Date: Thu, 10 May 2012 19:29:26 +0200 (CEST)
From: aubin.rebillat@domain.hid
Message-ID: <479588872.145094722.1336670966752.JavaMail.root@domain.hid>
In-Reply-To: <4FABEE1E.9000200@domain.hid>
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
> Envoy=C3=A9: Jeudi 10 Mai 2012 18:34:38
> Objet: Re: [Xenomai-help] Xenomai on the TS-7553 ARM SBC
>=20
> On 05/10/2012 06:04 PM, aubin.rebillat@domain.hid wrote:
> > I'm not that experienced with initrd/initramfs and that was what
> > the
> > manufacturer recommended and i followed it so i can have support
> > from
> > them. But yes, at first, i think it can boot from another device.
>=20
> Could you wrap your lines around 72 characters ? I have to do it for
> you
> when I want to reply your posts.

I will, sorry for the inconvenience.

>=20
> >=20
> >>
> >>> I will look into the OABI and EABI settings then. I will also set
> >>> up
> >>> an NFS file system to mount debian from and see what is
> >>> happening.
> >>>
> >>> Thank you Gilles for your reply. I will keep posting about my
> >>> progresses.
> >>
> >> The issue may simply well be that your timer code does not work.
> >> Could
> >> you post the code for your port? That is, the code you added to
> >> get
> >> it
> >> work with the I-pipe patch.
> >> Have you checked that linux timer is
> >> still
> >> ticking after Xenomai has been started?
> >=20
> > No, i did not check that the linux timer is still ticking.
> > But i think it is because parts of the init script are executed and
> > it is a shell script calling several sub-processes.
>=20
> If subprocesses were an issue, nobody would be able to run xenomai.
>=20
>
> > Nevertheless, I will put some printk in the linux timer handler to
> > be sure.
> >=20
> >>
> >> You can also try to boot with CONFIG_IPIPE but without
> >> CONFIG_XENOMAI.
> >=20
> > I did, and it's booting just fine.
>=20
> Ok. Then it is really likely the timer code which is broken. As the
> only
> difference when xenomai is started is that linux timer is handled by
> xenomai.
>=20
>=20
> > void ipipe_mach_update_tsc(void)
> > {
> >   union tsc_reg *local_tsc;
> >   unsigned long stamp;
> >   unsigned long flags;
> >=20
> >   local_irq_save_hw(flags);
> >   local_tsc =3D &tsc[ipipe_processor_id()];
> >   stamp =3D str8100_read_timer_counter();
> >   if (stamp < local_tsc->low)
> >     local_tsc->high++;
> >   local_tsc->low =3D stamp;
> >   local_irq_restore_hw(flags);
> > }
>=20
> Since this code is called from the timer ack routine, the interrupts
> are
> already off, so, you should not need local_irq_save_hw. On the other
> hand, calling ipipe_mach_update_tsc in the timer ack routine adds to
> the
> timer interrupt latency, so, should be done only if the time source
> is
> wrapping really fast. As your timesource is a 32 bits timesource
> (according to what you wrote in __ipipe_mach_get_tscinfo), it is
> probably not wrapping fast, and you can call ipipe_mach_update_tsc
> from
> linux timer interrupt.
>=20
> >=20
> > void __ipipe_mach_acktimer(void)
> > {
> > #ifndef CONFIG_VIC_INTERRUPT
> >   write_seqlock(&xtime_lock);
> >   str8100_clear_timer_interrupt_status(__ipipe_mach_timerint);
> >   write_sequnlock(&xtime_lock);
> > #endif
> >=20
> >   ipipe_mach_update_tsc();
> > }
>=20
> Wrong: you can not call write_seqlock from the acktimer routine. The
> seqlock are reserved to usage by Linux. Also note that you should
> remove
> the call to str8100_clear_timer_interrupt_status from Linux timer
> interrupt.

Actually, it's only if the Vector Interrupt Controller from the CNS2132
is not enabled, which is not my case. But at least i should erase this.

>=20
>=20
> > void __ipipe_mach_set_dec(unsigned long delay)
> > {
> >   unsigned long flags;
> >=20
> >   if (delay > 8)
> >   {
> >     local_irq_save_hw(flags);
> >     TIMER1_MATCH_VALUE1_REG =3D TIMER1_COUNTER_REG + delay;
> >     local_irq_restore_hw(flags);
> >   }
> >   else
> >     ipipe_trigger_irq(__ipipe_mach_timerint);
> > }
>=20
> ipipe_mach_set_dec is called with interrupts already off, so there is
> no
> need to call local_irq_save_hw/local_irq_restore_hw.
>=20
> Also, from the sources I could gather (snakeos-sdk), the hardware
> timer
> for str8100 is programmed in periodic, auto-reload mode. Obviously,
> when
> CONFIG_IPIPE is on, you have to change this to make the timer run in
> one-shot mode, as required by Xenomai.

I did not know that it was required, i thought it was handy not to reprogra=
m=20
the timer each time.

>=20
> > #ifdef CONFIG_IPIPE
> > void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
> > {
> >   // No cascaded interrupt using the VIC
> > }
> > #endif /* CONFIG_IPIPE */
>=20
> You probably do not need to define this function if you #define
> ipipe_mach_irq_mux_p to always be 0.
>

I do, to avoid an undefined reference.

Nevertheless, thank you very much for all this.

When i developped the IPIPE code for this board i followed the
HOWTO but it's quite vague so I mostly read what has been done=20
with other boards and what has been done with linux for this board=20
to implement it.
Therefore, I'm clearly not aware of the interactions between Linux=20
and Xenomai. I will definitely read the publications available on=20
the Xenomai website.

Best regards,

--=20
REBILLAT Aubin

