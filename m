Message-ID: <13528436.1171883639835.JavaMail.ngmail@domain.hid>
Date: Mon, 19 Feb 2007 12:13:59 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] Standard linux assignment of processes to
	CPUs depends on Xenomai Config
In-Reply-To: <b647ffbd0702190301h468a2bbemafff7b9d592e7e@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <b647ffbd0702190301h468a2bbemafff7b9d592e7e@domain.hid>
	<24461688.1170430564542.JavaMail.ngmail@domain.hid>
	<45D97B38.6060202@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: dmitry.adamushko@domain.hid, jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Hi!

I am very busy this week, I can do a check next week.
However, it looks as Dmitry aleady got a clue to that issue...=20

Regards

Mathias
> Hi,
>=20
> I suppose, that's what happens.
>=20
> __xeno_sys_init() (./ksrc/nucleus/module.c) which is module_init() and
> when compiled in -> initcall()
>=20
> calls xnarch_init() (./include/asm-i386/bits/init.h)
>=20
> This one amongst other things does
>=20
> ...
> #ifdef CONFIG_SMP
>         /* Make sure the init sequence is kept on the same CPU when
>            running as a module. */
>         set_cpus_allowed(current, cpumask_of_cpu(0));
> #endif /* CONFIG_SMP */
>=20
> In fact, "running as a module" seems to be a bit
> misleading here.  Then another macro should be used in addition,
> MODULE or how it's called.
>=20
> Now guess who is a "current" here? It's "init" (pid 0).
>=20
> init() -> do_basic_setup() -> do_initcalls() -> ... ->
> __xeno_sys_init() -> xnarch_init()
>=20
> "init" is a first process to run and all the rest will inherit its
> "cpus_allowed" field.
>=20
> That's it.
>=20
> --=20
> Best regards,
> Dmitry Adamushko
>=20

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

