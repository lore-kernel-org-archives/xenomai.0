Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493C218AE1
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 15:34:46 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202308091354163d8c3f13424d01c136
        for <xenomai@lists.linux.dev>;
        Wed, 09 Aug 2023 15:54:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=5y0InrNcXTA9ovvJIa+A8WODF3zQYw22W6x+1bizJkQ=;
 b=DmANjinDNoqqnSXUxWhjwyM1Gc2lNFyvTZ6XKc/P2/Cw9t5NY9VktMzqAAnvP5Wy+7L8tb
 TNiq//SpuU/FRRSrjOm/49g6qNsSzdCVXZGqozx45cT4jRnm5fiZtUbRgX8kb1yUfGCRdDy9
 RlbdtGrCcZg2mua4AAj9AbfdAhtM0=;
Message-ID: <a4bfd7f4abdb40bd676030862b6e070c804d6b6c.camel@siemens.com>
Subject: Re: [PATCH] debian: Enable lores clock by default
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Wed, 09 Aug 2023 15:54:12 +0200
In-Reply-To: <13d42c4f-ee14-4105-9fdb-ad371af50d41@siemens.com>
References: <13d42c4f-ee14-4105-9fdb-ad371af50d41@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2023-08-09 at 15:32 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Having the goal to be generically usable, the debian package should
> enable also this feature so that pSOS and VxWorks libraries can be used.
> It comes at the price of a slight overhead in time conversions for
> hi-res interfaces such as cobalt and alchemy.

Do I have to expect any performance problems now? How big is that
"price of a slight overhead" especially on x86?

I'm asking because internal customers are using the debianization "as
is", if there is now a need to deactivate this feature for them I have
to be careful during the next release cycle.

I see the need for activating it here to get CI running again but the
test should not fail if the feature is not available, the tests should
be skipped, no? Would say we have a "double fault" here.

Florian

>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  debian/rules | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/debian/rules b/debian/rules
> index 7664bf21c1..8e984acdcc 100755
> --- a/debian/rules
> +++ b/debian/rules
> @@ -19,7 +19,8 @@ CONFIG_OPTS =3D --prefix=3D/usr \
>              --with-testdir=3D/usr/lib/xenomai/testsuite \
>              --enable-lazy-setsched \
>              --enable-debug=3Dsymbols \
> -            --enable-dlopen-libs
> +            --enable-dlopen-libs \
> +            --enable-lores-clock
> =20
>  ifneq ($(DEB_HOST_GNU_TYPE),$(DEB_BUILD_GNU_TYPE))
>  	CONFIG_OPTS +=3D --build $(DEB_BUILD_GNU_TYPE) --host $(DEB_HOST_GNU_TY=
PE)
> --=20
> 2.35.3

