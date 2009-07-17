From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <6a782b880907170418q6bd4fbe7p6fde0f0c6bae551c@domain.hid>
References: <6a782b880906051338r401163b2m7e1d1a53f7f0800@domain.hid>
	<4A299794.6010504@domain.hid>
	<6a782b880906101236l625792d5p6fcd3dad53e965a2@domain.hid>
	<4A3010BE.9020107@domain.hid>
	<6a782b880907170418q6bd4fbe7p6fde0f0c6bae551c@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Jul 2009 14:14:11 +0200
Message-Id: <1247832851.4228.138.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Get ready queue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thiago Lima <thiagolims@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2009-07-17 at 08:18 -0300, Thiago Lima wrote:
> I am doing an schedulability test of real time processes in Xenomai.
> So that, when a new task is started in system, i need to get all
> threads from system, including the new one and make a test to decide
> if this workset is schedulable.
>=20
> I have a linux kernel module with a hook that is called whenever a
> task is started. Besides, i have to apply a patch to xenomai kernel in
> order to allow the hooks calling when a user space task is started.

You are likely using an outdated Xenomai core. 2.4.8 fires the START
callout for userland threads as well.

>=20
> My question is: how can i get all ready xenomai tasks ? Because i need
> to get the amount of threads to do this test.
>=20

Regarding the Xenomai 2.4 core: include/nucleus/pod.h, follow the readyq
member from the struct xnsched type.

This said, the scheduler innards were heavily rewritten in 2.5, to
provide scheduling classes and more policies than RR+FIFO (e.g. time
partitioning and POSIX sporadic server). So what you would measure for
2.4 may not be relevant with 2.5.

> Sorry for my last email. I have not so much time to write and it was
> vague.
>=20
> att,
>=20
> Thiago.
>=20
> On Wed, Jun 10, 2009 at 4:59 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>         Thiago Lima wrote:
>         > Sorry, i didnt understand you answer.
>        =20
>        =20
>         The question was vague, so was the answer.
>        =20
>         > I get the global queue doing this:
>         >
>         > threads =3D &pod->threadq;    // GLOBAL QUEUE
>         > holder =3D getheadq(&nkpod->threadq); //HEAD NODE
>        =20
>        =20
>         These are internal data, you are not supposed to access them
>         that way.
>         Besides threadq is not the ready queue. And with the recent
>         advent of
>         the scheduler classes, you could not do the same modification
>         for the
>         latest version of Xenomai. In short, it is a bad idea, really.
>        =20
>         If you explained us what you are trying to do (and not how you
>         are
>         trying to do it), maybe we could help. Chances are that you
>         can do what
>         you do without changing Xenomai core, simply using hooks for
>         instance.
>        =20
>         --
>                                                    Gilles.
>=20
>=20
>=20
> --=20
> Thiago Lima Silva
> Graduando - Ci=C3=AAncia da Computa=C3=A7=C3=A3o UFBA
> Registered Linux user #466887
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



