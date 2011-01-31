From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <3FF315C710820E47A04E55C6F7D9B0AD5F3244@domain.hid>
References: <3FF315C710820E47A04E55C6F7D9B0AD5F3244@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 Jan 2011 11:07:27 +0100
Message-ID: <1296468447.2214.26.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] CONFIG_XENO_OPT_SELECT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

On Mon, 2011-01-31 at 10:46 +0100, roderik.wildenburg@domain.hid
wrote:
> In the Xenomai 2.4.x series there was a kernel option CONFIG_XENO_OPT_SEL=
ECT.
> Unfortunately there is no help available for this option and Google  wasn=
=C2=B4t very fertile.
> Could somebody tell me, what this option is for?
> I am asking, as we face some problems with "select" in a Xenomai task (ta=
sk is stuck in select, was permanently marked as running (R in /proc/xenoma=
i/sched) and lower priority tasks weren=C2=B4t  scheduled). I am wondering =
whether this could be related to this option, which isn=C2=B4t activated in=
 my kernel config.
> We are running a 2.4.25 PPC Kernel with Xenomai 2.4.9.

This option is not related to the issue, it's basically to compile in
the support for select() over RTDM fildes. Your issue is likely related
to a bug in the RPI protocol, we did fix some bugs in this area in
2.5.x.

Try disabling CONFIG_XENO_OPT_PRIOCPL to check whether it helps.

>=20
> Many thanks in advance
> Roderik
>=20
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall,=
 Paul Steidle  =20
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht Of=
fenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--=20
Philippe.



