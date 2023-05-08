Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F649171AF
	for <xenomai@lists.linux.dev>; Mon,  8 May 2023 11:45:35 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202305081145261213a27c0eb0119fcd
        for <xenomai@lists.linux.dev>;
        Mon, 08 May 2023 13:45:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Cc:References:In-Reply-To;
 bh=z6hitZ49BBFtGIC3c1oLsoN4yo7McCj4QlBLoVGuaqk=;
 b=FXlksvob0IBuMFUWnqlLGBjBNWTKgQmcfhek0Zq8GQ+LyCzwcdyGUotcEQNLieGOOM+iHG
 3jJnRj6VqSIFzLROPPto3QiYMPRvMMCeErP3T7zkZ7G2EUPXxSEuQDT3PKq/pBrEBXqvMWx5
 adYb3bl8vaHVtf7eiee9xFoMjYsvY=;
Message-ID: <862cebd40855873341eb4ec40e81f2bc83284e36.camel@siemens.com>
Subject: Re: [PATCH 13/13] y2038: testsuite/smokey/y2038: Adding tests for
 timerfd_gettime
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Date: Mon, 08 May 2023 13:45:13 +0200
In-Reply-To: <20230508125007.52fc2dae@wsk>
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
	 <20230508-florian-y2038-part-two-v1-13-a417812fba85@siemens.com>
	 <20230508125007.52fc2dae@wsk>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-ro1auC1JaNnuTvASU8Hh"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer


--=-ro1auC1JaNnuTvASU8Hh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2023-05-08 at 12:50 +0200, Lukasz Majewski wrote:
> Hi Florian,
>=20
> > Extending the smokey testsuite to do some tests for the recently added
> > timerfd_gettime syscall.
> >=20
>=20
> For better Y2038 compliance coverage one can use OE/Yocto ptest from
> glibc:
>=20
> https://git.yoctoproject.org/poky/plain/meta/recipes-core/glibc/glibc/run=
-ptest
> https://lore.kernel.org/all/YXm9s2mVGNI+NtzR@piout.net/T/##

Hi Lukasz,

I know your glibc testing stuff but it's not re-usable for Xenomai as
is right now. One reason is that the necessary glibc wrappers have not
been merged into Xenomai yet. That is one of the things still waiting
in my y2038 queue (see cover letter). I hope to get that merged within
next weeks.

We can reconsider when the remaining stuff has been integrated.

The purpose of the y2038 smokey tests is to test the lowest level of
kernel service entry points and proper routing within Xenomai. That's
likely not what the glibc test would provide. Integration of such tests
would likely happen within xenomai-images project and not within
Xenomai itself. (IMHO ;-))

Thanks for the heads up, again.

Best regards,
Florian

>=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---


--=-ro1auC1JaNnuTvASU8Hh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEE9uDgn8QzUKfG+AFGSgfIT2sbV08FAmRY4MkcHGZsb3JpYW4u
YmV6ZGVrYUBzaWVtZW5zLmNvbQAKCRBKB8hPaxtXT20YB/96AeXiUfXjjjqpBRvj
JNPGcSO41RqlMnkI27g1KgkqsIoc+v05AO8hZ1Y6V6Nm2/j/IbX0IjrvyvRHWSqL
puH7i0rqRIJK9UgZPrHvuVxrw7ztjSlG27MQ2yrlh1ilKG5Ifu3qQKGJchs2HDLu
S3lCEfxJOgoo3ZODsxkYKU25rY/mRMOPx8o42qPD9gWqEXS45ftNBWkVg2t+4bV3
T3pJ/WAY7bJoWZiawN7zJHFunnX3Yz7Gtf8GAWzWy3NAaPUshn3gqhG4q4p9CVzU
TVDXoAglcUJUXGsBfbQY+6Sy18LnCcluq5HMCNzGHSkQeNwTQz5nha6AJ9frp6KE
Mhdm
=FC3L
-----END PGP SIGNATURE-----

--=-ro1auC1JaNnuTvASU8Hh--
