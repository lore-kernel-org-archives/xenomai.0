From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <3FF315C710820E47A04E55C6F7D9B0AD5F32E2@domain.hid>
References: <3FF315C710820E47A04E55C6F7D9B0AD5F3244@domain.hid>
	<4D46CB77.5000004@domain.hid> <1296486423.2214.58.camel@domain.hid>
	<4D46D139.9090209@domain.hid> <1296487075.2214.62.camel@domain.hid>
	<3FF315C710820E47A04E55C6F7D9B0AD5F32E2@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 Feb 2011 10:59:13 +0100
Message-ID: <1296554353.2071.17.camel@domain.hid>
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

On Tue, 2011-02-01 at 10:44 +0100, roderik.wildenburg@domain.hid
wrote:
> > What bothers me, is that we should not even be able to
> > read /proc/xenomai/sched from an unrelated shell, in case we had a
> > runaway primary or even secondary SCHED_FIFO task. (IIRC, Roderik is
> > running Xenomai over a single core ppc board, mpc52xx/icecube).
> >=20
>=20
> Yes this is amazing. The stuck task seems just to be marked running, but =
isn=C2=B4t really consuming CPU. Or could the linux kernel also be stuck at=
 the callers prio and therefore execute other syscalls? (Or the task is sim=
ply running very often (every time we look at /proc/xenomai sched), so it j=
ust seems to be stuck at R).
>=20

This clearly points the finger at the prio coupling code. Basically, the
root thread is never downgraded to its original priority, despite the
boost should have been lifted (typically because the relaxed thread is
blocked on a linux syscall, or moved back to primary mode -- in your
case, the former case is likely relevant).

> Another irregularity we observed after we replaced the select-call  by a =
poll-call: In this case everything went fine apart from that mode switches =
 and context switches in /proc/xenomai/stat weren=C2=B4t incremented any mo=
re, even though we are sure that the task is running and yielding CPU.
>=20

I suspect that by calling Xenomai's wrapped select(), your thread moves
to primary mode (this happens regardless of whether OPT_SELECT is
enabled or not). Therefore, that thread migrates back and forth between
the primary and secondary modes, because if OPT_SELECT is switched off,
your request is automatically forwarded to __real_select() after -ENOSYS
is received from the Xenomai nucleus. Because your thread somehow
oscillates between the two runtime modes at high frequency, the prio
coupling bug is more prone to happen.

OTOH, if your thread directly calls __real_select(), it simply remains
in secondary mode, so the prio coupling bug does not bite.

You could try to confirm this by switching off OPT_PRIOCPL.

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

--=20
Philippe.



