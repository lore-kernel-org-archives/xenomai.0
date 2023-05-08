Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415C2168C8
	for <xenomai@lists.linux.dev>; Mon,  8 May 2023 10:56:40 +0000 (UTC)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2A34383623;
	Mon,  8 May 2023 12:50:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1683543008;
	bh=S3330HlAzhM2DfyZhCTgSp3IrRPB/d68AJfOSXSePBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a/ODDGPAAojv1R8A/+x4vtekcxwk+y+4EBjZFKSQ3sc8BmI2ibfvl2rK8sNlVcFvD
	 qFjmOGRNyl0g+liIx3x8oAkWhONWNdcSymbyJqA9Rvfekr9aIdKFRr+/Ha/Mywovef
	 jVoOkUKwKN8N2A4j6KRkk7sEZtjG2eGy29ar1Ye1ToK2slvwJsg4dzaMB9NG6ro86J
	 KvkKHFQrk8qnbZa8iex0lxRsxJ0pKz5vowDSU8PCoys+2Bjh9FnPg7sMbQ/uuxJGrx
	 mX/jrZnFvGJIQ5k9cS1SjajSBo5vZ58QtkQHFivsKNWvOMfsq3OtgFmP7P/B0vHz8w
	 sWL4KwFYlLSpA==
Date: Mon, 8 May 2023 12:50:07 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Subject: Re: [PATCH 13/13] y2038: testsuite/smokey/y2038: Adding tests for
 timerfd_gettime
Message-ID: <20230508125007.52fc2dae@wsk>
In-Reply-To: <20230508-florian-y2038-part-two-v1-13-a417812fba85@siemens.com>
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
	<20230508-florian-y2038-part-two-v1-13-a417812fba85@siemens.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b51oUpKqvl_yGCz9uYBSVvd";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/b51oUpKqvl_yGCz9uYBSVvd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Florian,

> Extending the smokey testsuite to do some tests for the recently added
> timerfd_gettime syscall.
>=20

For better Y2038 compliance coverage one can use OE/Yocto ptest from
glibc:

https://git.yoctoproject.org/poky/plain/meta/recipes-core/glibc/glibc/run-p=
test
https://lore.kernel.org/all/YXm9s2mVGNI+NtzR@piout.net/T/

> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/y2038/syscall-tests.c | 50
> ++++++++++++++++++++++++++++++++++ 1 file changed, 50 insertions(+)
>=20
> diff --git a/testsuite/smokey/y2038/syscall-tests.c
> b/testsuite/smokey/y2038/syscall-tests.c index 87d85b9df..2e3b81e0c
> 100644 --- a/testsuite/smokey/y2038/syscall-tests.c
> +++ b/testsuite/smokey/y2038/syscall-tests.c
> @@ -1397,6 +1397,52 @@ out:
>  	return ret;
>  }
> =20
> +static int test_sc_cobalt_timerfd_gettime64(void)
> +{
> +	long sc_nr =3D sc_cobalt_timerfd_gettime64;
> +	struct xn_itimerspec64 its =3D { 0 };
> +	uint64_t buf =3D 0;
> +	int ret;
> +	int fd;
> +
> +	fd =3D timerfd_create(CLOCK_REALTIME, 0);
> +	if (fd =3D=3D -1)
> +		return -errno;
> +
> +	/* Make sure we don't crash because of NULL pointers */
> +	ret =3D XENOMAI_SYSCALL2(sc_nr, fd, NULL);
> +	if (ret =3D=3D -ENOSYS) {
> +		smokey_note(
> +			"cobalt_timerfd_gettime64: skipped. (no
> kernel support)");
> +		ret =3D 0;
> +		goto out; // Not implemented, nothing to test,
> success
> +	}
> +	if (!smokey_assert(ret =3D=3D -EFAULT)) {
> +		ret =3D ret ?: -EINVAL;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Set some random values, allows us to detect that the
> kernel has
> +	 * written the time
> +	 */
> +	its.value.tv_sec =3D 123;
> +	its.value.tv_nsec =3D 456;
> +
> +	/* Fetch the time from the timer, should succeed */
> +	ret =3D XENOMAI_SYSCALL2(sc_nr, fd, &its);
> +	if (!smokey_assert(!ret))
> +		goto out;
> +
> +	smokey_assert(buf =3D=3D 0);
> +	smokey_assert(its.value.tv_sec =3D=3D 0);
> +	smokey_assert(its.value.tv_nsec =3D=3D 0);
> +out:
> +	smokey_check_errno(close(fd));
> +
> +	return ret;
> +}
> +
>  static int check_kernel_version(void)
>  {
>  	int ret, major, minor;
> @@ -1498,5 +1544,9 @@ static int run_y2038(struct smokey_test *t, int
> argc, char *const argv[]) if (ret)
>  		return ret;
> =20
> +	ret =3D test_sc_cobalt_timerfd_gettime64();
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/b51oUpKqvl_yGCz9uYBSVvd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmRY098ACgkQAR8vZIA0
zr02Sgf/Q4d7D7ZfDkaex3WTpkwvJeThnqq018d/NEaGn678O1OXOluulI0kPhJz
0abuWEW6jYimXibZzd9AcgITWs2SAE+1iCMX15pabZEoKlab2DhUwGmUyXGZWrD/
Cc+oExsrpTnu1CnZmX96G0+GTS5DKScMxmNasYRcmES6Ej2Sq/Sh1sKK5/KdmMVS
lihdmToW4YZvXdT1VkzcufIDWxRI9yQJGWz4hhz1Ty+uwsLEnNHqlYxu9g8j3yOD
Z694ZSQH+cJTRHK7UGYcklRP1YXXJ+EaOUOrbAbLemqcptuoLNIuW6MXRWxM5FXR
83PRgG080iJnMKvRghh+4q7J7DNgTg==
=zvCD
-----END PGP SIGNATURE-----

--Sig_/b51oUpKqvl_yGCz9uYBSVvd--
