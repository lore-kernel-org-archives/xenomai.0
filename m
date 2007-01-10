Message-ID: <30674978.1168446750005.JavaMail.ngmail@domain.hid>
Date: Wed, 10 Jan 2007 17:32:30 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] Xenomai Bug: rt_intr_create with NULL-name
	leads to Kernel oops in /proc/xenomai/irq
In-Reply-To: <b647ffbd0701100759p5432558dv386b5b1a580e3921@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <b647ffbd0701100759p5432558dv386b5b1a580e3921@domain.hid>
	<15523442.1168430357436.JavaMail.ngmail@domain.hid>
	<45A4DDA8.6090800@domain.hid>
	<b647ffbd0701100549y5d143e8at8e9ac5ab8e1826d6@domain.hid>
	<45A4F18A.4040209@domain.hid>
	<b647ffbd0701100621k25126a1bldb0bef19be65c92b@domain.hid>
	<45A4F9CC.6070807@domain.hid>
	<b647ffbd0701100655wd47af96y244c74d5227d6e85@domain.hid>
	<45A502A9.3060800@domain.hid>
	<b647ffbd0701100758i1ea15b12qab5ac7c33acae0be@domain.hid>
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

Hi Dmitry,

I have tested the patch.
Compiling works fine.

Then, I ran the test I have sent to the list.
Now, cat /proc/xenomai/irq works.
I get the output:
--------------
IRQ         CPU0
 11:           0         e0977700
216:         174         [timer]
226:           0         [virtual]
--------------
which seems to be ok.

Then I modified my kernel module to pass a string that is build on the stac=
k.
This works fine as well.

I.e. everything is fixed! Great work.
Thanks for the fast response time!

Best regards

Mathias
> >
> > Attached. Keep in mind that although it's a simple patch I,
> > personally, haven't tested it (even compilation-wise).
> > Anyone who would like to give it a try (Mathias?) is wellcome.
>=20
> Now finally attached.
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

