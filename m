Message-ID: <49E36498.4040803@domain.hid>
Date: Mon, 13 Apr 2009 18:13:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49D513D8.5020001@domain.hid> <49D530C8.8050109@domain.hid>	
	<1238708700.6932.136.camel@domain.hid> <49D70E31.4070706@domain.hid>
	<1238836702.6932.179.camel@domain.hid>
In-Reply-To: <1238836702.6932.179.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig992E1C968FC2671BDAEBF664"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] libnative: Avoid double-evaluation of
 rt_task_self()
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig992E1C968FC2671BDAEBF664
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sat, 2009-04-04 at 09:37 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Thu, 2009-04-02 at 23:40 +0200, Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> [ can be pulled from git.xenomai.org/xenomai-jki.git queues/assorte=
d ]
>>>>>
>>>>> Keep the result of rt_task_self() in a local variable to avoid the
>>>>> second invocation.
>>>> Maybe we could create a pure/const variant of rt_task_self() for use=
 in
>>>> task.c only which would avoid the double evaluatino ?
>>>>
>>> Can't do const because of pthread_getspecific(), but pure attribute i=
s t
>>> hand, yes.
>>>
>> At least my gcc 4.3 ignores
>>
>> RT_TASK *rt_task_self(void) __attribute__ ((pure));
>>
>=20
> We can't do that on rt_task_self() directly, because of
> rt_task_shadow().
>=20
>> and keeps on inserting two calls in rt_task_delete.
>>
>=20
> What if a pure static inline helper is used internally from task.c?
>=20

Makes no difference (and defining a new helper for this purpose would be
overkill anyway).

So please pull my original version from
git://git.xenomai.org/xenomai-jki.git for-upstream

BTW, you'll find another trivial fix in that queue:

--- a/src/testsuite/switchtest/switchtest.c
+++ b/src/testsuite/switchtest/switchtest.c
@@ -1094,7 +1094,7 @@ int check_fpu(void)
 		exit(EXIT_FAILURE);
 	}

-	return (int) status;
+	return (long) status;
 }

 int main(int argc, const char *argv[])

Jan


--------------enig992E1C968FC2671BDAEBF664
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAknjZJ8ACgkQniDOoMHTA+nimgCfearaWLxUCe5x3uzSWaY1bn8K
q0AAnAiKc6I8YMj2v25qY8wjLxsjgED5
=Z0MV
-----END PGP SIGNATURE-----

--------------enig992E1C968FC2671BDAEBF664--

