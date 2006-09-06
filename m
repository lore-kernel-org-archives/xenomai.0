Message-ID: <44FE6C55.1030900@domain.hid>
Date: Wed, 06 Sep 2006 08:36:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44FD7463.7010601@domain.hid> <44FD99E9.6030500@domain.hid>	
	<44FD9F92.4050802@domain.hid>
	<b647ffbd0609051210p26c56690oe7b332190b3b702e@domain.hid>
In-Reply-To: <b647ffbd0609051210p26c56690oe7b332190b3b702e@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0D2415CF5BDBE76797D9DFBF"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: Move rtdm_irq_enable close to rtdm_irq_request
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0D2415CF5BDBE76797D9DFBF
Content-Type: multipart/mixed; boundary="------------050901000409020907020309"

This is a multi-part message in MIME format.
--------------050901000409020907020309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 05/09/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>
>>
>> @Dmitry: What happens under CONFIG_XENO_OPT_SHIRQ_LEVEL &&
>> !CONFIG_XENO_OPT_SHIRQ_EDGE when someone comes along with
>> XN_ISR_SHARED|XN_ISR_EDGE? Looks like the level-triggered shared handl=
er
>> gets installed. Should we catch this? At Kconfig or at nucleus level?
>=20
>=20
> Currently XN_ISR_SHARED and XN_ISR_EDGE are unconditionally available f=
or
> any configuration. So nothing stops a user from calling rtdm_irq_reques=
t(
> ... , RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE) even when IRQ shared
> infrastructure is off.
> (the second call gives -EBUSY and a "bug" report is sent. I mean, if th=
e
> user has overlooked "shared irq" section on the configure step and cons=
ider
> it a default behavior).
>=20
> Probably the clean solution would be to export XN_ISR_SHARED and
> XN_ISR_EDGE
> only when their corresponding CONFIG_* parameters are defined.
>=20
> Then e.g. rtdm skin should do :
>=20
> #ifdef XN_ISR_SHARED
> #define RTDM_IRQTYPE_SHARED XN_ISR_SHARED
> #endif
>=20
> and let a compiler complain on undefined symbol when a user tries to us=
e
> SHARED/EDGE without proper CONFIG options. Although, I'm not sure it wo=
uld
> be clear for all users.
>=20
> Another approach,
>=20
> in xnintr.h
>=20
> #ifdef CONFIG_XENO_OPT_SHIRQ_LAYER
> #define XN_ISR_SHARED   1
> #else
> #define XN_ISR_SHARED    XN_ISR_WARNING
> #endif
>=20
> and then catch all wrong use cases in one place :
>=20
> int xnintr_attach(xnintr_t *intr, void *cookie)
> {
>        intr->hits =3D 0;
>        intr->cookie =3D cookie;
>=20
> +      if (intr->flags & XN_ISR_WARNING) {
> +                   xnlogerr("blablabla...\n");
> +                   return -EINVAL;
> +      }
>=20
> #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) ||
> defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
>        return xnintr_shirq_attach(intr, cookie);
> #else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */=

>        return xnarch_hook_irq(intr->irq, &xnintr_irq_handler, intr->iac=
k,
>                               intr);
> #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
> }
>=20
>=20
> ?
>=20

Sharing itself is no problem: if your request an IRQ with XN_ISR_SHARED
set but the nucleus is not able to actually assign it to more than one
driver, the second request will simply fail. I see no need to deny the
first request or even break the driver build.

Problematic is only the handling of edge-triggered shared IRQs with the
level-triggered handler (can cause lost IRQs). Probably a runtime check
is best as we cannot control the configuration of, e.g., external RTDM
drivers. What about the attached patch?

Jan

--------------050901000409020907020309
Content-Type: text/x-patch;
 name="catch-unsupported-XN_ISR_EDGE.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="catch-unsupported-XN_ISR_EDGE.patch"

Index: ksrc/nucleus/intr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/intr.c	(Revision 1560)
+++ ksrc/nucleus/intr.c	(Arbeitskopie)
@@ -638,10 +638,14 @@ static int xnintr_shirq_attach(xnintr_t=20
 			handler =3D &xnintr_shirq_handler;
 #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL */
=20
+			if (intr->flags & XN_ISR_EDGE) {
 #if defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
-			if (intr->flags & XN_ISR_EDGE)
 				handler =3D &xnintr_edge_shirq_handler;
+#else /* !CONFIG_XENO_OPT_SHIRQ_EDGE */
+				err =3D -ENOSYS;
+				goto unlock_and_exit;
 #endif /* CONFIG_XENO_OPT_SHIRQ_EDGE */
+			}
 		}
 		shirq->unhandled =3D 0;
=20

--------------050901000409020907020309--

--------------enig0D2415CF5BDBE76797D9DFBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE/mxZniDOoMHTA+kRAr82AJ9V/NHbpoVFkcEwFaUy/3xNq5EWUwCfZeJx
C6JUYbeizdz8w89ZX6OoXaQ=
=PYjV
-----END PGP SIGNATURE-----

--------------enig0D2415CF5BDBE76797D9DFBF--

