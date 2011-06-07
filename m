Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 7 Jun 2011 12:54:25 +0200
Message-ID: <3FF315C710820E47A04E55C6F7D9B0AD78FCD2@domain.hid>
In-Reply-To: <4DE4AE03.9020509@domain.hid>
References: <3FF315C710820E47A04E55C6F7D9B0AD78FA33@domain.hid>
	<4DE4AE03.9020509@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: [Xenomai-help] Solved: UDP-receive-task stalls
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Turned out that it was a simple segmentation fault, but SIGSEGV was =
captured by a vendor library so we didn=B4t realize it.
Sorry for blaming  Xenomai!
Roderik


> -----Urspr=FCngliche Nachricht-----
> Von: Jan Kiszka [mailto:jan.kiszka@domain.hid]
> Gesendet: Dienstag, 31. Mai 2011 11:00
> An: Wildenburg, Roderik RAEK1 MRA
> Cc: xenomai@xenomai.org
> Betreff: Re: UDP-receive-task stalls
>=20
> On 2011-05-31 10:34, roderik.wildenburg@domain.hid wrote:
> > We face the problem that a Xenomai task which receives UDP-packets
> > (secondary mode recvfrom()) on a high frequency ( every 50ms approx.
> > 1200 Byte) stalls sporadically (few times a day). In this case the
> > ROOT-task permanently shows the priority of the stalled task, the
> > receive queue of the stalled task fills up (netstat -u) , the task =
never
> > comes to live again . Attaching gdb or strace to this task stalls =
these
> > tools also. Other tasks and Linux run as expected even other =
UDP-receive
> > tasks!
> > Any idea what can cause this problem or how we can debug the stalled
> > task? (I think we had a similar problem with select() I presented in
> > this list).
> > We use:
> > - Linux 2.4.25 PPC
> > - Xenomai 2.4.9
>=20
> Do you depend on CONFIG_XENO_OPT_PRIOCPL? If not, switch it off, it =
may
> be involved here.
>=20
> Jan
>=20
> --
> Siemens AG, Corporate Technology, CT T DE IT 1
> Corporate Competence Center Embedded Linux

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933


