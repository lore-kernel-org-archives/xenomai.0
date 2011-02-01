Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 1 Feb 2011 10:44:21 +0100
Message-ID: <3FF315C710820E47A04E55C6F7D9B0AD5F32E2@domain.hid>
In-Reply-To: <1296487075.2214.62.camel@domain.hid>
References: <3FF315C710820E47A04E55C6F7D9B0AD5F3244@domain.hid>
	<4D46CB77.5000004@domain.hid> <1296486423.2214.58.camel@domain.hid>
	<4D46D139.9090209@domain.hid> <1296487075.2214.62.camel@domain.hid>
From: <roderik.wildenburg@domain.hid>
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
To: rpm@xenomai.org, gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

> What bothers me, is that we should not even be able to
> read /proc/xenomai/sched from an unrelated shell, in case we had a
> runaway primary or even secondary SCHED_FIFO task. (IIRC, Roderik is
> running Xenomai over a single core ppc board, mpc52xx/icecube).
>=20

Yes this is amazing. The stuck task seems just to be marked running, but =
isn=C2=B4t really consuming CPU. Or could the linux kernel also be stuck =
at the callers prio and therefore execute other syscalls? (Or the task =
is simply running very often (every time we look at /proc/xenomai =
sched), so it just seems to be stuck at R).

Another irregularity we observed after we replaced the select-call  by a =
poll-call: In this case everything went fine apart from that mode =
switches  and context switches in /proc/xenomai/stat weren=C2=B4t =
incremented any more, even though we are sure that the task is running =
and yielding CPU.

Roderik

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

