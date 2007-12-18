Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Dec 2007 17:37:54 +0100
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E01ADBE44@domain.hid>
In-Reply-To: <200712172350.48963.berlemont.hauw@domain.hid>
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E01A9B226@domain.hid>
	<200712172350.48963.berlemont.hauw@domain.hid>
From: "Thomas Necker" <thomas.necker@domain.hid>
Subject: Re: [Xenomai-help] Oprofile with PPC in timer mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai@xenomai.org

> > I'm trying to get oprofile working on a MPC8270 with=20
> xenomai. However,=20
> > hardware perofromance counters don't seem to work due to a=20
> bug in the
> > 603 processor. I tried it with oprofile's timer mode=20
> without success.
> > Before digging deeper: Has anyone experience with this? Since=20
> > oprofile's timer mode requires interrupts not to be disabled, I=20
> > suspect this interferes somehow with the adeos ipipe ...
>=20
> I tried oprofile in timer mode on PPC405GPr (Linux 2.6.19.2 /=20
> Xenomai 2.3.3 /
> oprofile-0.9.3) a few months ago.
>=20
> That was not working really well, opreport was not able to=20
> locate in which process the CPU was during any timer tick.=20
> After some instrumentation, I found out the instruction=20
> pointer was not passed to Linux through the interrupt pipeline.
>=20
> So with this little patch,  the problem was fixed. I did not=20
> find enough time to double check what I did. Therefore, I did=20
> not send any mail to disclose the problem, which is not very nice.
>=20
> Sorry.

It seems to work! Thanks!=20
Just a small improvement since I compiled oprofile support as a module.

Thomas


--- ipipe-root.c.orig	2007-12-18 17:32:58.000000000 +0100
+++ ipipe-root.c	2007-12-18 17:24:40.000000000 +0100
@@ -358,6 +358,10 @@
=20
 	__ipipe_tick_regs[cpuid].msr =3D regs->msr; /* for do_timer() */
=20
+#if defined CONFIG_OPROFILE || defined CONFIG_OPROFILE_MODULE
+       __ipipe_tick_regs[cpuid].nip =3D regs->nip; /* for =
oprofile_tick()
*/
+#endif /* CONFIG_OPROFILE */
+
 #ifndef CONFIG_40x
 	if (__ipipe_decr_ticks !=3D tb_ticks_per_jiffy) {
 		unsigned long long next_date, now;

