Message-ID: <3D331D01.F756F16B@opersys.com>
Date: Mon, 15 Jul 2002 15:05:37 -0400
From: Karim Yaghmour <karim@domain.hid>
Reply-To: karim@domain.hid
MIME-Version: 1.0
References: <20020715183746.72137.qmail@domain.hid>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Subject: [Adeos-main] Re: patchless debugger for U.P x86
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.mail.freesoftware.fsf.org>
List-Unsubscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.freesoftware.fsf.org/pipermail/adeos-main/>
To: Miguel =?iso-8859-1?Q?Rodr=EDguez?= <agus_081074@domain.hid>
Cc: linux-kernel@domain.hid, Adeos <adeos-main@gna.org>

This is just fantastic. I'm glad to see someone ran with the ideas of
patchless kernel debuggers as described in the Adeos paper and the like=
s.

There are definitely interfacing opportunities with the Adeos work
that's already been done using a kernel patch. Having both Adeos
as a kernel patch and as a patchless nanokernel is now really within
our reach.

Kudos to Miguel :)

Karim

Miguel Rodr=EDguez wrote:
>=20
> I have released an initial alpha release for a x86
> (uniprocessor) Linux kernel patchless debugger under
> the GNU GPL at savannah.gnu.org. Project is called
> kmdbg. First debugger implemented is a remote serial
> debugger.
> It is just a simple interrupt/exception/syscall
> interception scheleton and may have a lot of errors
> (or not work at all) although it worked for me with
> kernel 2.4.XX, 2.5.24.
> See:
>=20
> https://savannah.gnu.org/projects/kmdbg
>=20
> Miguel.
>=20
> _______________________________________________________________
> Yahoo! Messenger
> Nueva versi=F3n: Webcam, voz, y mucho m=E1s =A1Gratis!
> Desc=E1rgalo ya desde http://messenger.yahoo.es
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@domain.hid
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
                 Karim Yaghmour
               karim@domain.hid
      Embedded and Real-Time Linux Expert
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

