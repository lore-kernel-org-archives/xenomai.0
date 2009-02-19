Message-ID: <499D774F.1030209@domain.hid>
Date: Thu, 19 Feb 2009 16:14:23 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4B2EEE69E41E524EB7FCDC62A15D68D80308F137@domain.hid>	<499572C2.3060609@domain.hid>	<49957D23.4040806@domain.hid>	<4B2EEE69E41E524EB7FCDC62A15D68D8030CCF0F@ARVMAIL1.mra.roland-man.biz>	<499C1749.7040804@domain.hid>	<4B2EEE69E41E524EB7FCDC62A15D68D8030CCF23@domain.hid>	<499C1BD6.3010909@domain.hid>
	<499C5A63.8060309@domain.hid>
	<4B2EEE69E41E524EB7FCDC62A15D68D8030CD121@domain.hid>
In-Reply-To: <4B2EEE69E41E524EB7FCDC62A15D68D8030CD121@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: thomas.debes@domain.hid
Cc: xenomai@xenomai.org

thomas.debes@domain.hid wrote:
> Thanks for testing it - that is exactly what I would like to see. Obvio=
usly it's a kernel/I-Pipe related thing which prevents me from getting th=
e exception. Unfortunately updating to kernel 2.6 is not an option for no=
w.
>

I'm afraid this is not I-pipe related, this would have been too easy. The=
 test
snippet works fine here as well on a lite5200 + ipipe-2.4.25-1.2-02, ELDK=
-4.1
environment.

Now we should suspect something going on with your target environment; wh=
ich
libc are you based on?


> Thomas
>=20
> -----Urspr=FCngliche Nachricht-----
> Von: Wolfgang Grandegger [mailto:wg@domain.hid
> Gesendet: Mittwoch, 18. Februar 2009 19:59
> An: Debes, Thomas RAEK3 MRA
> Cc: xenomai@xenomai.org; Gilles Chanteperdrix
> Betreff: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
>=20
> Wolfgang Grandegger wrote:
>> thomas.debes@domain.hid wrote:
>>> Unfortunately I don't have a newer kernel, I will talk to Wolfgang Gr=
andegger, maybe he can do a short test with my formerly attached sample a=
pplication.
>> I will try it out on my TQM5200 board later today or tomorrow.
>=20
> With I-Pipe v2.4-03, Xenomai v2.5-devel (SVN revision 4519) and Linux
> 2.6.26 on my TQM85200 I get:
>=20
>   -bash-3.2# ./fpu-exception-test
>   Floating point exception
>=20
>   -bash-3.2# dmesg|tail
>   ...
>   Xenomai: Switching trivial to secondary mode after
>   exception #1792 from user-space at 0x10001840 (pid 1127)
>=20
> Is that the expected behavior?
>=20
> Wolfgang.
>=20
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Ral=
l, Paul Steidle  =20
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20
Philippe.

