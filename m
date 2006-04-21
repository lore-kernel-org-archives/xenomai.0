Message-ID: <4448FC77.5000608@domain.hid>
Date: Fri, 21 Apr 2006 17:38:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4448EE7D.1020003@domain.hid> <4448F656.6070101@domain.hid>
In-Reply-To: <4448F656.6070101@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC6FFDCEE0175CAE8F648A799"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [Adeos-main] [PATCH] let ipipe_catch_event
	return old handler
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC6FFDCEE0175CAE8F648A799
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>=20
> <snip>
>=20
> Don't you mean this instead?
>=20
>> -int ipipe_catch_event(struct ipipe_domain *ipd,
>> -              unsigned event,
>> -              int (*handler)(unsigned event, struct ipipe_domain
>> *ipd, void *data))
>> +ipipe_event_handler_t ipipe_catch_event(struct ipipe_domain *ipd,
>> +                    unsigned event,
>> +                    ipipe_event_handler_t handler)
>>  {
> +       ipipe_event_handler_t old_handler;
>>      int self =3D 0;
>> =20
>> @@ -278,7 +278,7 @@
>>      }
>> =20
>>      if (event >=3D IPIPE_NR_EVENTS)
>> -        return -EINVAL;
>> +        return NULL;
>> =20
> -      if (!xchg(&ipd->evhand[event],handler))    {
> +      if (!(old_handler =3D xchg(&ipd->evhand[event],handler)))    {
>>          if (handler) {
>> @@ -301,7 +301,7 @@
>>              ipd->evself |=3D (1LL << event);
>>      }
>> =20
>> -    return 0;
>> +    return handler;
> -    return handler;
> +    return old_handler;
>>  }
>> =20
>>  cpumask_t ipipe_set_irq_affinity (unsigned irq, cpumask_t cpumask)
>>
>>

Ouch, obviously. A quick hack which was only tested for not breaking
existing software.

Jan


--------------enigC6FFDCEE0175CAE8F648A799
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESPx3niDOoMHTA+kRAiP2AJ9avRleXcYegwpOOlh92XzKLnDncACfTS86
PeEsTjlTm5owsEkdf77fEOg=
=pXlO
-----END PGP SIGNATURE-----

--------------enigC6FFDCEE0175CAE8F648A799--

