Message-ID: <487DCCA4.60509@domain.hid>
Date: Wed, 16 Jul 2008 12:25:40 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <487B8B3E.8020805@domain.hid> <487B91F6.3070909@domain.hid>
	<487BA305.6040401@domain.hid> <487BB89B.6010604@domain.hid>
	<487BF171.2090902@domain.hid> <487C42CB.5080405@domain.hid>
In-Reply-To: <487C42CB.5080405@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE47C866584E3C4976DED939E"
Subject: Re: [Xenomai-help] rt_task_bind() and timeout values
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE47C866584E3C4976DED939E
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

your patch didnt work. The bind_calls are now blocking infinite (at least=
 much too long, still waiting...)
To compile i had to change following line in your patch:
-	if (timeout !=3D TM_NONBLOCK && timeout !=3D TM_INFINITE)
+	if (timeout !=3D XN_NONBLOCK && timeout !=3D XN_INFINITE)

I will use following patch for the moment, this works.

--- xenomai/nucleus/registry.c.old	2008-07-15 00:36:10.000000000 +0200
+++ xenomai/nucleus/registry.c	2008-07-15 15:28:23.000000000 +0200
@@ -733,8 +733,10 @@ int xnregistry_bind(const char *key, xnt
  		if (timeout !=3D XN_INFINITE) {
  			xnticks_t now =3D xntbase_get_time(tbase);

-			if (stime + timeout >=3D now)
-				break;
+			if (stime + timeout <=3D now) {
+				err =3D -ETIMEDOUT;
+				goto unlock_and_exit;
+			}	=09

  			timeout -=3D (now - stime);
  			stime =3D now;


Philippe Gerum schrieb:
> Stefan Kisdaroczi wrote:
>> Hi Philippe,
>>
>> the attached patch fixed the problem for me.
>=20
> Good spot. Now it's official, since four years that feature exists or s=
o, nobody
> actually used registry timeouts... Oh, well...
>=20
>> However, i think that in the "break case" still EACCES is returned.
>> Can the break be replaced with a "return ETIMEDOUT" ?
>>
>=20
> Yes, normally we should do that along with your patch. Actually, the mo=
st
> appropriate fix would be to use an absolute timeout value internally, s=
ince the
> nucleus allows it.
>=20
> --- ksrc/nucleus/registry.c	(revision 4044)
> +++ ksrc/nucleus/registry.c	(working copy)
> @@ -711,7 +711,6 @@
>  	xnobject_t *object;
>  	xnthread_t *thread;
>  	xntbase_t *tbase;
> -	xnticks_t stime;
>  	int err =3D 0;
>  	spl_t s;
>=20
> @@ -723,7 +722,8 @@
>=20
>  	xnlock_get_irqsave(&nklock, s);
>=20
> -	stime =3D xntbase_get_time(tbase);
> +	if (timeout !=3D TM_NONBLOCK && timeout !=3D TM_INFINITE)
> +		timeout +=3D xntbase_get_time(tbase);
>=20
>  	for (;;) {
>  		object =3D registry_hash_find(key);
> @@ -738,18 +738,8 @@
>  			goto unlock_and_exit;
>  		}
>=20
> -		if (timeout !=3D XN_INFINITE) {
> -			xnticks_t now =3D xntbase_get_time(tbase);
> -
> -			if (stime + timeout >=3D now)
> -				break;
> -
> -			timeout -=3D (now - stime);
> -			stime =3D now;
> -		}
> -
>  		thread->registry.waitkey =3D key;
> -		xnsynch_sleep_on(&registry_hash_synch, timeout, XN_RELATIVE);
> +		xnsynch_sleep_on(&registry_hash_synch, timeout, XN_ABSOLUTE);
>=20
>  		if (xnthread_test_info(thread, XNTIMEO)) {
>  			err =3D -ETIMEDOUT;
>  --
> Philippe.
>=20
>=20



--------------enigE47C866584E3C4976DED939E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIfcyqIPTw9rIdn6oRAmk/AJ0VbULD9pMOM7RPWy4e8sWasWgFPQCeK82l
oLpdwKmos0r8usYU3B9Ew5k=
=zJbT
-----END PGP SIGNATURE-----

--------------enigE47C866584E3C4976DED939E--

