Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317F142AA0
	for <xenomai@lists.linux.dev>; Fri, 24 May 2024 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716552497; cv=none; b=ocZPdFwlXNiI/EXm4uIFRclzYFnhHTVS5NkgP5WnL1FnNxRx9/dYzva9LnlT4ApQFw1OCKEVWVUOm+WZLRK3mx/5z4vrDHxpBo12A77KACH9sq1xSUHAHVpQZQinbDKMKmtNCGqSa7kTLm8xikYu0/P96hxTgRdl8xQbTdNyOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716552497; c=relaxed/simple;
	bh=1IEWNekh+f5dgi4hKVOJLXOc1J/SkhqYgNmt4mOM0JM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QtC9DpPa2ITdjBp8g2RdWQlVL+6VCIEszx7t1fDc55vyCYKQAGLp0uYpCRDH38sIRudxYev1r8co7po0eDhzRmg/55vjiudrFjtb3UfwJietelCM4IfFxXpUmSOcVTt5kW0PAa3dzQigWHV0gczCsU5+iBvQagfUmqjmbeyCfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=nWxbWWg5; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="nWxbWWg5"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240524120809d5275d8fa769ecb005
        for <xenomai@lists.linux.dev>;
        Fri, 24 May 2024 14:08:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HS1toWRi4wAP8PzkU23jgBKDglWv20qDvhML5FmDhkI=;
 b=nWxbWWg58OpBNx18u+acJdumCUK4y+quQ9G87WIsJ6g1yDoWg9Mv+SwI69njYTuO2QT75A
 9QgRsVwbwvidEX9n0c/byxDls7TDC+O3RgRjsIMZvzbIDfh8ns34oJBaVUdbw9KT5e3DjHAB
 zREYDb7Xwee8OugOijPHtxlKvA6Ws=;
Message-ID: <da74792da55cdc921c86a5ac12de49f626f9c47d.camel@siemens.com>
Subject: Re: [PATCH v2 2/3] rpi4: Add rpi4 (Raspberry Pi 4) as target
 platform
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Yi Jiang <yi.jiang@siemens.com>, xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
Date: Fri, 24 May 2024 14:08:08 +0200
In-Reply-To: <20240524110254.37483-3-yi.jiang@siemens.com>
References: <20240524110254.37483-1-yi.jiang@siemens.com>
	 <20240524110254.37483-3-yi.jiang@siemens.com>
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

On Fri, 2024-05-24 at 13:02 +0200, Yi Jiang wrote:
> --- a/recipes-kernel/linux/linux-xenomai-3-dovetail.inc
> +++ b/recipes-kernel/linux/linux-xenomai-3-dovetail.inc
> @@ -12,5 +12,6 @@
>  require recipes-kernel/linux/linux-xenomai-3.inc
> =20
>  SRC_URI +=3D "git://source.denx.de/xenomai/linux-dovetail.git;protocol=
=3Dhttps;nobranch=3D1"
> +SRC_URI:append:rpi4 =3D " file://rpi4.cfg"

Here...

> =20
>  PV ?=3D "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
> diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-ker=
nel/linux/linux-xenomai-3_latest.bb
> index c65c28d..5908c59 100644
> --- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
> +++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
> @@ -80,3 +80,4 @@ SRC_URI +=3D "${GIT_REPO};protocol=3Dhttps;branch=3D${G=
IT_BRANCH}"
>  SRCREV =3D "${AUTOREV}"
> =20
>  SRC_URI:append:beagle-bone-black =3D " ${@ 'file://bbb_4.4.cfg' if is_xe=
no_3_0(d) else '' }"
> +SRC_URI:append:rpi4 =3D " file://rpi4.cfg"

and here I'm expecting a Isar build failure now. This two hunks need to
be removed.

Best regards,
Florian
