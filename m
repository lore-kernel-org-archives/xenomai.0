Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAB34844D
	for <xenomai@lists.linux.dev>; Wed, 22 Oct 2025 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145370; cv=none; b=VfNLM/X+k6QDuAc/IErXKGp+dy+BlYVq5oqcsDGGUBEXx0EBj1tlPRGkNAnN8G37KxhqLvUEcom1b5XRRIQX9kPkEISQgNfiUKgFuaAK+Mdw/XCZIuhsSC9CjsqzBTmuj5BkAYY2b/4haA17WLtkl1yxs+23yA5pkzwsV44YYY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145370; c=relaxed/simple;
	bh=tKLoOY5LrQRacasSbz6EBai6pJQldkpJ+nr8lyu/olw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AYNtzvDFlTJVeQU4nMfIubugWlHeB9HO5XRh/JBhDXemHs5h03t8r2nU4Xk4Lqu5H91MmFMxZFWP6qDweHH2Q/O9qKNK5C+GtQ6uvK0ED95NFJSLAuZ3TucRcWlS28pWMXgNF7K6T7eL5fpyuVFJCugMs0AYrespntOb40pyx0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=H5C095NQ; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="H5C095NQ"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251022150237f234ffab0c000207b1
        for <xenomai@lists.linux.dev>;
        Wed, 22 Oct 2025 17:02:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=woi8UkMy6Artg30sSvDjLAWfZ+kXcSAC73AY8vKAo88=;
 b=H5C095NQTARV+U5CSlnMOuIftK+yfwOP0QPZKLYNYOVBOtKRUeR6jdr6HPLtEIB3CEXrby
 uu3bxtJXw/oLi9MFd75W/SVivy97iBgfTWOrAKYfWyP35qCCFH6xovfLp3LVR+2k0a3eopY2
 fWP8ySeu8UYPPjBkoummp0RyAdxw0Hso+nl/+RVioxiBzKe5Ai+zUnabwtuyj6eBs72wYeXT
 t93b4cSzcsByxg16BPRBVhHyYfBoOaoiMfWmFEr6aUb7FBHzPY2GS5ZYvNNqflN18Wxq6TdE
 n55DQGIdNi8CVSfVT4YMqWOAvrpVNpEI5TsnhBPFf5CJ6xjAd35Y2naw==;
Message-ID: <787da4f86b16c6588dfcf41acab658d2a17ff75a.camel@siemens.com>
Subject: Re: [PATCH 1/2] linux-xenomai: Add arch specific debug kernel
 configuration snippets
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 22 Oct 2025 17:02:37 +0200
In-Reply-To: <73e0d573-6e0c-4e73-a62e-d80f811dac52@siemens.com>
References: <20251009111228.3504354-1-tobias.schaffner@siemens.com>
	 <20251009111228.3504354-2-tobias.schaffner@siemens.com>
	 <0e60ea350929090e70354a5ff705348f441ea15a.camel@siemens.com>
	 <73e0d573-6e0c-4e73-a62e-d80f811dac52@siemens.com>
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

On Fri, 2025-10-10 at 16:08 +0200, Tobias Schaffner wrote:
> On 10.10.25 15:16, Florian Bezdeka wrote:
> > On Thu, 2025-10-09 at 13:12 +0200, Tobias Schaffner wrote:
> > > [snip]
> >=20
> > > diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/=
linux/linux-xenomai.inc
> > > index 8c7df40..501c212 100644
> > > --- a/recipes-kernel/linux/linux-xenomai.inc
> > > +++ b/recipes-kernel/linux/linux-xenomai.inc
> > > @@ -16,9 +16,10 @@ FILESPATH =3D. "${LAYERDIR_xenomai}/recipes-kernel=
/linux/files:"
> > >  =20
> > >   XENOMAI_DEFCONFIG =3D "${DISTRO_ARCH}_defconfig"
> > >   KERNEL_DEFCONFIG ?=3D "${XENOMAI_DEFCONFIG}"
> > > +KERNEL_DEBUGCONFIG =3D "${DISTRO_ARCH}_debugconfig"
> > >   XENOMAI_DEBUG ?=3D "0"
> > >  =20
> > >   SRC_URI +=3D "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_D=
EFCONFIG') =3D=3D d.getVar('XENOMAI_DEFCONFIG') else ''}"
> > > -SRC_URI +=3D "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBU=
G') =3D=3D '0' else ''}"
> > > +SRC_URI +=3D "${@'file://${KERNEL_DEBUGCONFIG}' if d.getVar('XENOMAI=
_DEBUG') =3D=3D '1' else ''}"
> >=20
> > NACK. This switches all the CI builds to no-debug.
>=20
> No it doesn't. XENOMAI_DEBUG is set to 1 in ci builds by kas/opt/debug.ya=
ml.

Yep, I got this backwards.

So the default is 0, but the default for CI is 1. That makes sense.

>=20
> > We need all the debug flags enabled for CI builds.
> > Otherwise, we risk to loose really important debug information.
> >=20
> > no-debug builds, for example for performance measurement purposes need
> > to disable the debug settings, not the other way around.
> >=20
> > >  =20
> > >   S =3D "${WORKDIR}/git"
> > > --=20
> > > 2.43.0
