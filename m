Message-ID: <474BF115.1050309@domain.hid>
Date: Tue, 27 Nov 2007 11:27:33 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1820393698@domain.hid>
In-Reply-To: <1820393698@domain.hid>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] interrupt programm hang up the computer
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
To: Andreas Vogt <A_C_V@web.de>
Cc: xenomai@xenomai.org

Andreas Vogt wrote:
> Hello,
>=20
> I try to implement an interrupt but I get always the error message -38.

-ENOSYS. Function not implemented.

 What does this messages mean?
> And when i delete in the section...
>=20
> if (err > 0) {int_count++;}
> 	 else {
> 			printf("interrupt_task_2 error =3D %i\n", err);
> 		}
> 		rt_intr_enable (&intr_desc);=20
>       =20
> 	   }
>=20
>  ... the printf command the program hang up.
>

Infinite loop you created yourself by not testing the status returned
from rt_intr_wait().

What about testing the return code from rt_intr_create() too?

> In my config the XENO_OPT_NATIVE_INTR is not set. Cause this any Problem?
> __________________

Yes. This is why you get -ENOSYS.

_____________________________________________________
> Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 3 Monate
> kostenlos testen. http://www.pc-sicherheit.web.de/startseite/?mc=3D022220
>=20
>=20
>=20
> ------------------------------------------------------------------------
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.

