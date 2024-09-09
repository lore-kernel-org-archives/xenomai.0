Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAEC1BA261
	for <xenomai@lists.linux.dev>; Mon,  9 Sep 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890490; cv=none; b=J72qyxVdQIwhYn0WaUuO/f7fHM1ZaNGdpnaY/N0/pW8uUWHHjDCYEBP3bo6p9Xhho1JomXP76Z98zgaMSOjGrSPPBYteNzoRfakKHfaGl3BI3ikaj04NaGIgDY2Cl0DPyf4qm0FPTrlMNeKk7EfE6tgYTaH2kbCeJbGF9znMXto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890490; c=relaxed/simple;
	bh=AWOVff/Q7Og5uUighJUPF1Rz47qpC8ugtGcZkxb63jY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CthNuJs3Wodnz/PqE7wxwPbIR9h70fhX7ohifQtO2KBzaFj6fdCcNW42zkiwb+RqqgWhbWJtJakHZcYkFLnBDjGNRlNqHywUpcwRYGnHu7MGLd5k6P0gbl/MrCxsVykKfzK0VAyKQbVB4dLB/KFc28DRtCGEivs9yoISeB2HHiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=bCsrXuVX; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="bCsrXuVX"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240909140121251d7e1309580158d2
        for <xenomai@lists.linux.dev>;
        Mon, 09 Sep 2024 16:01:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=AWOVff/Q7Og5uUighJUPF1Rz47qpC8ugtGcZkxb63jY=;
 b=bCsrXuVXTHosm/VRkLRWNBdluxJF7/raQgobVxPWuWlXWxas1R5z/cyKZgUoZ4dEUpbl7P
 DaW3zGfMdTohAbXuzGrw2Pp1MEoaahomDSQRd4bfxvlGiPpgMFf6J6cwgjpS+VbE/u6hb649
 JXQbmsSMkAPeKygL+kCAvVWYkOobeaRfdWEiAKnEc3vuq/vpHdwtsHMcKQAZHWLj0hrJBOSN
 NSkrIHvMtMNc3iM4cuzo1xuVKJ3dqRSmFs/dQmQbV63TYzsiSzRTc9Nh9iDq48pNSa0xmeMf
 0DUFh16bC7sN5mBo2I1Aucy0n+NZWtiaQGMRjvecuhtMiY06KZdZcUkA==;
Message-ID: <fc38f3af6fa7b993fdbc81deecd7134ad6a39af4.camel@siemens.com>
Subject: Re: Compilation error kernel Xenomai3 for x86 32 bits
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: LE-DOUARAIN Marc <m.ledouarain@fareco.fayat.com>, 
 "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>
Date: Mon, 09 Sep 2024 16:01:18 +0200
In-Reply-To: <AM6PR05MB6024420AB2F1754C19B5612EAD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
References: 
	<AM6PR05MB6024420AB2F1754C19B5612EAD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
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

Hi Marc,

On Mon, 2024-09-09 at 13:48 +0000, LE-DOUARAIN Marc wrote:
>=20
>=20
>=20
> Hello,
> =C2=A0
> I=E2=80=99ve tried to compile linux-dovetail-v5.10.214-dovetail1 github r=
epository for Xenomai 3.2.5 (from a Debian12.6=C2=A0i386),
> and it failed on theses errors=C2=A0:
> (the same with Xenomai 3.2.4)
>=20
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel/xenomai/pipeline/init.o
> kernel/xenomai/pipeline/init.c: In function =E2=80=98pipeline_init=E2=80=
=99:
> kernel/xenomai/pipeline/init.c:23:9: error: implicit declaration of funct=
ion =E2=80=98enable_oob_stage=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]
> =C2=A0=C2=A0 23 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enable_=
oob_stage("Xenomai");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~~~~~~~~~
> kernel/xenomai/pipeline/init.c: In function =E2=80=98pipeline_cleanup=E2=
=80=99:
> kernel/xenomai/pipeline/init.c:49:9: error: implicit declaration of funct=
ion =E2=80=98disable_oob_stage=E2=80=99 [-Werror=3Dimplicit-function-declar=
ation]
> =C2=A0=C2=A0 49 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disable=
_oob_stage();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:286 : kernel/xenomai/pipeline/init.o=
] Erreur 1
> make[2]: *** [scripts/Makefile.build:503 : kernel/xenomai/pipeline] Erreu=
r 2
> make[1]: *** [scripts/Makefile.build:503 : kernel/xenomai] Erreur 2
> make: *** [Makefile:1832 : kernel] Erreur 2

I think the main point here is that we do no longer support 32 bit
kernels. We still support the compat case, so 32 bit applications
running on a 64 bit kernel. Might that be an option for you?

Should work as long as your board supports is 64 bit.

>=20
> =C2=A0
> I=E2=80=99ve used the command =C2=AB=C2=A0/prepare-kernel.sh --linux=3D##=
######/linux-dovetail-v5.10.214-dovetail1 --arch=3Di386=C2=A0=C2=BB before =
configuring kernel.
> Not better with linux-dovetail-v6.6.23-dovetail2.

Haven't touched the prepare-kernel script for a while. Seems we should
bail out and complain loudly when trying to use --arch=3Di386.

Best regards,
Florian

> The =E2=80=98.config=E2=80=99 used is joined, if important.
>=20
> Thanks in advance for any help.
> Marc.
> =C2=A0
> =C2=A0

