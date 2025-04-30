Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F66221D3E9
	for <xenomai@lists.linux.dev>; Wed, 30 Apr 2025 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746027455; cv=none; b=i0d5/zjPSKkfYTb7bohnxR++dsadt+ZV+6iKCB3pMlhKyhv/uEn9M8FRL05BjqrDpsg3J+1XONNcJmaS7ZiByxSa7LrreXw1yPNNLCWn476NRDo0S5OqxPWwjW9kMrFfLNXluY2EAFK73a2qdYXsI+mvQWD9xU/5fJFZXuI0Kj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746027455; c=relaxed/simple;
	bh=+NMXwLc1neJqRtH1LmCfiF6zsh5GD1NClksVGpPp+38=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X90YjFfZ73ViTmSspjyCzpsRI0oM1AE7TAgwTxYsjse7uR8wDsJ8dB2+7t/pQQvploDZiui7RbaY/HE6xjPUzftMy0mm4YLfdgu2dga7Q4NisQQyDZxxSB7EHuKmM+cKKPeTFzjp5JRojj2JP+xjuhdX1ZZOFQ8P0PMGj3WWUrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=NNtqXRfx; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="NNtqXRfx"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202504300956563e6b554d3bf2583cd6
        for <xenomai@lists.linux.dev>;
        Wed, 30 Apr 2025 11:56:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kLQD1HeIv3aa+i6ylN1szGeQtunDs2DJge4WGthyirs=;
 b=NNtqXRfx54SnuAsMgUGVfrCna0Qh3tSufaydpZAlH7eaSE7iylXxmP+sv6TyYBMGidvML5
 81QZIYyCbePvjRCHS/NU3B6WQt1GEH362dCiaq5PYEdZ8lV0CFXqv10vNiBCkQyiY9iDgBoK
 mcKRPPdaGAB8Lt9aCA5BHhF8Ww5qyF+7zZ4Z5Iee2kw22oDac1ucOKkQpDPTeVSi7Z3cZyGU
 YiwOdz1ltETudANHmo7HoDrDlPbdZD39T0YSGNljx5+H46Y06UuhMN/qZBuU0R1UUTVDvb09
 Qa0DvyBRzb9ATclMTFpj50hZxuO1kwkqTvbQcnLYiGXF0fGZCb5WtW8A==;
Message-ID: <298a2bdeb3a4a15ccfbac1e7a37c68c8833a2fa3.camel@siemens.com>
Subject: Re: Build error of kernel/xenomai/debug.c
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Qiao, Wei" <wei.qiao@intel.com>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>,  "xenomai@lists.linux.dev"	
 <xenomai@lists.linux.dev>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Pirou, Florent"
	 <florent.pirou@intel.com>
Date: Wed, 30 Apr 2025 11:56:55 +0200
In-Reply-To: <IA1PR11MB651388E02D8925FB8EA908CE8CBB2@IA1PR11MB6513.namprd11.prod.outlook.com>
References: 
	<IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
	 <72c2c5cb18b635f1145c35b6592c661cf55aeb0f.camel@siemens.com>
	 <370f022e-d5e3-46f1-a19f-5448afeebb61@siemens.com>
	 <IA1PR11MB6513A045F8ECB1186B65DA9A8CBF2@IA1PR11MB6513.namprd11.prod.outlook.com>
	 <4342e7e1-a7d4-431c-8fcc-f7731d3938d9@siemens.com>
	 <IA1PR11MB6513FC978522428982B0A30A8CB82@IA1PR11MB6513.namprd11.prod.outlook.com>
	 <4abe85c4-1457-4137-9e54-ea1a8aa534d4@siemens.com>
	 <IA1PR11MB651388E02D8925FB8EA908CE8CBB2@IA1PR11MB6513.namprd11.prod.outlook.com>
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

On Tue, 2025-04-22 at 08:00 +0000, Qiao, Wei wrote:
> My ubuntu version is PRETTY_NAME=3D"Ubuntu 24.04.2 LTS"
> gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0 the default gcc version.

As that topic came up in the community call today again, I tried that
exact compiler version inside a ubuntu:24.04 podman environment. It's
building fine.

Please double check your environment. Maybe there is a CFLAGS variable
(or a similar variable) with different compiler options involved?

Best regards,
Florian

>=20
> -----Original Message-----
> From: Florian Bezdeka <florian.bezdeka@siemens.com>=20
> Sent: Monday, April 21, 2025 5:45 PM
> To: Qiao, Wei <wei.qiao@intel.com>; Kiszka, Jan <jan.kiszka@siemens.com>;=
 xenomai@lists.linux.dev
> Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Pirou, Florent <florent.pir=
ou@intel.com>
> Subject: Re: Build error of kernel/xenomai/debug.c
>=20
> On 21.04.25 02:08, Qiao, Wei wrote:
> > Gcc verison:
> > qiaowei@wqiao2:~$ gcc --version
> > gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0
> >=20
> > Kernel:=20
> > v6.12.19-dovetail1-rebase
> >=20
> > https://gitlab.com/Xenomai/xenomai-hacker-space.git
> > tag: v3.3
>=20
> I tried the following build configurations, all worked:
>=20
> - gcc (GCC) 15.0.1 20250329 (Red Hat 15.0.1-0)
> - gcc (GCC) 14.2.1 20250110 (Red Hat 14.2.1-7)
> - gcc (Debian 12.2.0-14) 12.2.0
> - gcc (Debian 10.4.0-7) 10.4.0
>=20
> The default gcc version of Ubuntu 24.04 - as provided by the gcc package
> - is 13.2.0-7ubuntu1. Seems you installed the gcc-13 package for some rea=
son.
>=20
> What happens if you switch back to the default compiler, does that work?
>=20
> I can't tell why, but gcc 13.2 seems unable to derive the object size...
>=20
> As Jan mentioned the quick fix I posted is kind of an overkill.
>=20
> As I don't have an Ubuntu system at hand and all tries to reproduce on De=
bian and Fedora failed so far and in addition a lot of different compiler v=
ersions are working fine: No further investigations will follow on my end.
>=20
> >=20
> > -----Original Message-----
> > From: Florian Bezdeka <florian.bezdeka@siemens.com>
> > Sent: Monday, April 21, 2025 5:47 AM
> > To: Qiao, Wei <wei.qiao@intel.com>; Kiszka, Jan=20
> > <jan.kiszka@siemens.com>; xenomai@lists.linux.dev
> > Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Pirou, Florent=20
> > <florent.pirou@intel.com>
> > Subject: Re: Build error of kernel/xenomai/debug.c
> >=20
> > On 18.04.25 07:51, Qiao, Wei wrote:
> > > Test pass.
> > > The system can boot up and work well.
> >=20
> > Which xenomai/compiler/kernel combination are you trying to build?
> >=20
> > I tried to reproduce with gcc 15 - the latest gcc release - but it is s=
till building fine.
> >=20
> > You mentioned Ubuntu 24.04, which should ship gcc 10.5, which should be=
 fine as well.
> >=20
> > >=20
> > > -----Original Message-----
> > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > Sent: Thursday, April 17, 2025 4:59 PM
> > > To: Bezdeka, Florian <florian.bezdeka@siemens.com>; Qiao, Wei=20
> > > <wei.qiao@intel.com>; xenomai@lists.linux.dev
> > > Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Pirou, Florent=20
> > > <florent.pirou@intel.com>
> > > Subject: Re: Build error of kernel/xenomai/debug.c
> > >=20
> > > On 17.04.25 10:43, Florian Bezdeka wrote:
> > > > On Thu, 2025-04-17 at 08:15 +0000, Qiao, Wei wrote:
> > > > > Hi All,
> > > > >=20
> > > > > If we build the kernel in ubuntu 24.04, there is build error:
> > > > >=20
> > > > > from kernel/xenomai/debug.c:23:
> > > > > In function 'strcpy',
> > > > >     inlined from 'hash_symbol' at kernel/xenomai/debug.c:94:2:
> > > > > ./include/linux/fortify-string.h:787:17: error: call to '__write_=
overflow' declared with attribute error: detected write beyond size of obje=
ct (1st parameter)
> > > > >   787 |                 __write_overflow();
> > > > >       |                 ^~~~~~~~~~~~~~~~~~
> > > > >=20
> > > > > This is because new gcc version has stricter FORTIFY_SOURCE( =3D3=
 is =E2=80=8Cstricter=E2=80=8C than =3D2). Please help to fix, thanks.
> > > >=20
> > > > That is the flexible array story...
> > > >=20
> > > > You could try something like below (completely untested) and report=
=20
> > > > back if it works:
> > > >=20
> > > > diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c index
> > > > 25b194c26..d048dc757 100644
> > > > --- a/kernel/cobalt/debug.c
> > > > +++ b/kernel/cobalt/debug.c
> > > > @@ -47,7 +47,8 @@ EXPORT_SYMBOL_GPL(cobalt_debug_vfroot);
> > > > =20
> > > >  struct hashed_symbol {
> > > >  	struct hashed_symbol *next;
> > > > -	char symbol[];
> > > > +	size_t size;
> > > > +	char symbol[] __counted_by(size);
> > > >  };
> > > > =20
> > > >  static struct hashed_symbol *symbol_jhash[SYMBOL_HSLOTS]; @@ -91,6
> > > > +92,7 @@ static const char *hash_symbol(const char *symbol)
> > > >  		goto out;
> > > >  	}
> > > > =20
> > > > +	p->size =3D len + 1;
> > > >  	strcpy(p->symbol, symbol);
> > > >  	p->next =3D *h;
> > > >  	*h =3D p;
> > > >=20
> > >=20
> > > A bit of overkill, given that allocation and access of according size=
 happens within the same function. No smarter way to tell the compiler to s=
tay away here?
> > >=20
> > > Jan
> > >=20
> > > --
> > > Siemens AG, Foundational Technologies Linux Expert Center

