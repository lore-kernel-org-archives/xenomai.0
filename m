Date: Thu, 13 Nov 2014 16:23:17 +0100 (CET)
From: tbultel@free.fr
Message-ID: <1535253467.116850655.1415892197439.JavaMail.root@zimbra90-e16.priv.proxad.net>
In-Reply-To: <20141113151022.GE4656@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
 adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: nicolas Mabire <nicolas.mabire@basystemes.fr>, xenomai@xenomai.org



----- Mail original -----
> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> =C3=80: tbultel@free.fr
> Cc: xenomai@xenomai.org, "nicolas Mabire" <nicolas.mabire@basystemes.fr>
> Envoy=C3=A9: Jeudi 13 Novembre 2014 16:10:22
> Objet: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 + adeos-ipipe-3.0.43-mx6q-1.=
18-14 -> very slow boot
>=20
> On Thu, Nov 13, 2014 at 04:03:31PM +0100, tbultel@free.fr wrote:
> >=20
> >=20
> > ----- Mail original -----
> > > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> > > =C3=80: tbultel@free.fr
> > > Cc: xenomai@xenomai.org, "nicolas Mabire"
> > > <nicolas.mabire@basystemes.fr>
> > > Envoy=C3=A9: Jeudi 13 Novembre 2014 15:51:15
> > > Objet: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
> > > adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
> > >=20
> > > On Thu, Nov 13, 2014 at 03:44:34PM +0100, tbultel@free.fr wrote:
> > > >=20
> > > >=20
> > > > ----- Mail original -----
> > > > > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> > > > > =C3=80: "Thierry Bultel" <tbultel@free.fr>
> > > > > Cc: xenomai@xenomai.org, "Lennart Sorensen"
> > > > > <lsorense@csclub.uwaterloo.ca>, "nicolas Mabire"
> > > > > <nicolas.mabire@basystemes.fr>
> > > > > Envoy=C3=A9: Mardi 11 Novembre 2014 21:03:58
> > > > > Objet: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
> > > > > adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
> > > > >=20
> > > > > On Tue, Nov 11, 2014 at 08:57:34PM +0100, Thierry Bultel
> > > > > wrote:
> > > > > > Le 10/11/2014 13:36, Gilles Chanteperdrix a =C3=A9crit :
> > > > > > >You can use printascii in the timer interrupt acknowledge
> > > > > > >routine
> > > > > > >to
> > > > > > >print a character every HZ ticks, this will give bad
> > > > > > >latency,
> > > > > > >but
> > > > > > >should work.
> > > > > > >
> > > > > >=20
> > > > > > For unknown reason, the kernel gets stuck after
> > > > > > "console [tty0] enabled, bootconsole disabled" if I use
> > > > > > printascii
> > > > > > in do_local_timer().
> > > > > > earlyprintk seems broken as well.
> > > > >=20
> > > > > Without doing this, does earlyprintk work?
> > > > >=20
> > > > > > >If this is indeed the broadcast timer, it should never
> > > > > > >tick,
> > > > > > >because
> > > > > > >we should never switch to broadcast mode.
> > > > > >=20
> > > > > > I have found out why it was ticking.
> > > > > > This is due to tick_broadcast_switch_to_oneshot() in
> > > > > > kernel/time/tick-broadcast.c
> > > > > >=20
> > > > > > This sets the oneshot mode to the time, and leads to a call
> > > > > > of
> > > > > > mxc_set_mode()
> > > > > >=20
> > > > > > In that function, there is that comment:
> > > > > > =09if (mode !=3D clockevent_mode) {
> > > > > > =09=09/* Set event time into far-far future */
> > > > > > =09=09if (timer_is_v2())
> > > > > >=20
> > > > > > ... and I estimate "far-far future" to be about 20 minutes.
> > > > > >=20
> > > > > > As a correction, I have made that change to
> > > > > > tick_broadcast_switch_to_oneshot():
> > > > > >=20
> > > > > > @@ -603,11 +610,21 @@ void
> > > > > > tick_broadcast_setup_oneshot(struct
> > > > > > clock_event_device *bc)
> > > > > >  {
> > > > > >         int cpu =3D smp_processor_id();
> > > > > >=20
> > > > > > +#if defined(CONFIG_IPIPE) && defined(CONFIG_SMP)
> > > > > > +       printk(KERN_ALERT "%s cpu %d -> dev %s
> > > > > > IGNORED\n",__PRETTY_FUNCTION__, cpu, bc->name);
> > > > > > +       return;
> > > > > > +#endif
> > > > > >=20
> > > > > > ... and that makes the job, the iMX Timer is no longer
> > > > > > armed.
> > > > > > What do you think about it ?
> > > > > >=20
> > > > > > Still currently stress-testing to see if things are getting
> > > > > > better.
> > > > >=20
> > > > > I am afraid this should not change anything. This timer
> > > > > ticking
> > > > > is
> > > > > not a problem by itself, it is a problem if the twd gets
> > > > > disabled.
> > > > >=20
> > > >=20
> > > > Unfortunately, you were right.
> > > > Even with that fix, we have 2 fail cases
> > > >=20
> > > > I have added 4 leds to the GPIOs, and toggle them in
> > > > do_local_timer, each 100 ticks
> > > > for being human visible. I found it more convenient at keeps my
> > > > console clean.
> > > >=20
> > > > 1) on one machine, the freeze does not make a backtrace on the
> > > > serial console
> > > >  a) in most cases, the leds do not blink, no more interrupts
> > > >  b) in one case, a single one kept blinking for a while before
> > > >  stopping
> > >=20
> > >=20
> > > do_local_timer is a bit to high level, try putting it in
> > > twd_timer_ack. Also, try setting the Linux timer to periodic
> > > (disable HIGHRES_TIMERS), this should make Xenomai timer tick
> > > periodically, not matter what happens on linux side.
> >=20
> > I can try that, but that would break my linux application that
> > relies on it.
>=20
> I mean for testing. Does the application exit in error, or does not
> work very correctly?

Good for testing. It should behave badly but should keep alive.=20
Let's try that.

>=20
> > > Do you have unlocked context switch enabled? If yes, turn it off.
> >=20
> > I can't:
> >  #error "Xenomai: ARM SMP systems require unlocked context switch
> >  prior to Linux 3.8"
>=20
> Oh yeah, there is that too. I completely forgot about that.
>=20
> We would need to backport the changes that have been made for
> switching contexts, but that is not a small change.
>=20
> Is there anyway you can run your tests without the specific hardware
> of your board, say with a recent mainline kernel? Just to see if the
> bug is gone with what we have made since then, or if it is still
> there?


Well, I already thought about that.=20
Basically, the AMOS820 is based on the 'nitrogen6x' board, formerly called =
'sabrelite'
Even without supporting all the hardware, that would mean to
convert the BSP of VIA, written in C, in a device tree, and I do not feel
completely comfortable in doing this for the moment.

>=20
> --
> =09=09=09=09=09    Gilles.
>=20

