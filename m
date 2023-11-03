Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9E2D632
	for <xenomai@lists.linux.dev>; Fri,  3 Nov 2023 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Jm0o/do9"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20231103104535d93e3028b37f0cd16a
        for <xenomai@lists.linux.dev>;
        Fri, 03 Nov 2023 11:45:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=FgISVYcExjq41Y8U+WX5eGCjQa7CTftoHpGgAFjbvR8=;
 b=Jm0o/do97NGEVdA47wmeyYzEP03nE0SQfsnER2KZXp+j4wAx3tIjPp+KtQRp0lAb2hkEex
 ybCEjH+Z9V/MGTUgPUvUKC0cOATGN2O8ZwFRz/6+C9jxy7k3xcYTKOb70MMd962PwFb+bdyB
 0XJJ2B1GwChSAa5OLNAQ7tUfUFRjY=;
Message-ID: <3ecef04c29194f54e5a6acdffa9489b422012ea0.camel@siemens.com>
Subject: Re: [PATCH 4/6] testsuite: alchemytests: Skip pipe test if kernel
 support is missing
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 03 Nov 2023 11:45:34 +0100
In-Reply-To: <fb79d12f-2915-41b9-9c8c-c3ddbb15708d@siemens.com>
References: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
	 <20231030-flo-cleanup-testsuite-v1-4-0fb7bbd2d45f@siemens.com>
	 <fb79d12f-2915-41b9-9c8c-c3ddbb15708d@siemens.com>
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

On Thu, 2023-11-02 at 15:56 +0100, Jan Kiszka wrote:
> On 02.11.23 15:41, Florian Bezdeka wrote:
> > The pipe test depends on the RTIPC/XDDP protocol which must be provided
> > by the kernel. Skip the test if the kernel does not support it.
> >=20
> > Might be that the module is not loaded or the kernel configuration has
> > CONFIG_XENO_DRIVERS_RTIPC_XDDP set to 'n'.
>=20
> For module loading, we have smokey_modprobe. Maybe extend with that
> later on.

I will come up with a patch that tries to load the xeno_rtipc module,
but there is still no guarantee that it provides XDDP support.

That will slightly improve the situation as the default for
CONFIG_XENO_DRIVERS_RTIPC_XDDP is y.

>=20
> Jan
>=20
> >=20
> > The error message reported by smokey:
> > 0"000.543| WARNING: [alchemytests_pi] RTIPC/XDDP protocol not supported=
 by kernel
> > 0"000.567| BUG in __traceobj_assert_failed(): [alchemytests_pi] trace a=
ssertion failed:
> >            pipe-1.c:88 =3D> "ret >=3D 0"
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  testsuite/smokey/alchemytests/pipe-1.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/testsuite/smokey/alchemytests/pipe-1.c b/testsuite/smokey/=
alchemytests/pipe-1.c
> > index 488c0ee3b..8989f3a46 100644
> > --- a/testsuite/smokey/alchemytests/pipe-1.c
> > +++ b/testsuite/smokey/alchemytests/pipe-1.c
> > @@ -6,6 +6,7 @@
> >  #include <copperplate/traceobj.h>
> >  #include <alchemy/task.h>
> >  #include <alchemy/pipe.h>
> > +#include <smokey/smokey.h>
> > =20
> >  static struct traceobj trobj;
> > =20
> > @@ -85,7 +86,10 @@ int main(int argc, char *const argv[])
> >  	traceobj_init(&trobj, argv[0], 0);
> > =20
> >  	ret =3D rt_pipe_create(&mpipe, "pipe", P_MINOR_AUTO, 0);
> > -	traceobj_assert(&trobj, ret >=3D 0);
> > +	if (ret < 0) {
> > +		notice("Test skipped (no kernel support)");
> > +		return 0;
> > +	}
> > =20
> >  	ret =3D rt_pipe_delete(&mpipe);
> >  	traceobj_check(&trobj, ret, 0);
> > @@ -138,5 +142,5 @@ int main(int argc, char *const argv[])
> > =20
> >  	traceobj_join(&trobj);
> > =20
> > -	exit(0);
> > +	return 0;
> >  }
> >=20
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

