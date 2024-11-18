Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B23152166
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731928726; cv=none; b=pYctnBiwFg0El2uI4C/DKAnshKT4YXwz3ONHXwvzyVEK+U92oKhG68QnI72Qd9q3mAOp1ADfvsW/NPmzk89PUjuFsCxV28gHmN0D2obpEP6ljL82p6SzEEKmlC/zBYL4iFsEYP7jF+BThwHCkxQoiOMv0CBx0jDv/JsOupk0HAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731928726; c=relaxed/simple;
	bh=x6YuWhpYT1xy6/xWpRWlGhqigPJ7aosBilpqroRpPHU=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=DiqL5knqSpUlB9w+tjI3Q2U2jAovLLXZ5S/5+vYeKykBv1+Y9v3G9QO+vWtZ6laoRyj/aXG7mVFwFkaVZILqPXKgGxKNvtoD/ce8/dotqebkFDmJUrs4EuR8vVWvAUuSVUPxa32n5CzFqtAtunmCzOA4w+rIyY4eR6sW27a8sJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=Ulk0Eh6O; arc=none smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="Ulk0Eh6O"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 793CB200003
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 11:18:39 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by spool.mail.gandi.net (Postfix) with ESMTPS id C82D4AC0E3D
	for <xenomai@xenomai.org>; Mon, 18 Nov 2024 11:18:37 +0000 (UTC)
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 95C296013E;
	Mon, 18 Nov 2024 12:18:37 +0100 (CET)
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 4AIBIOtA2719345;
	Mon, 18 Nov 2024 12:18:28 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1731928716;
	bh=x6YuWhpYT1xy6/xWpRWlGhqigPJ7aosBilpqroRpPHU=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=Ulk0Eh6OTZnACEVcpb8s1u2Z4ic8Yt/Grv0IMhWakUYa41KfEbTv/lSumOOSfiBgU
	 21Q0CYHdgPDDnosxk91EQ35UQIDz99IvdXOXZHDgOoCs/mGTguvzxtzhOzgZtPKgoX
	 orjiiF+fWNOEuK24oK9QZdzEfBl6nAYyKso/LvHtngsmAAn+5FMXP6lwJWOGGCuinc
	 zlS3Xry+KW72GxXzv5lmRAFGTni7mFEjwoGJPOKdQmJzOT2vUyN4nP+AfU+t/rdReD
	 Stb2ahKR6gwG9LW2+LFZEKVr9JITLDU+wFVnO3pfSfax3j/C3+NLGtac/Ant+YSPiG
	 r/3yvijpImgaQ==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <a1f4a1141c0a281d58d22b8f4552afd6094f1bec.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.98.110
Date: Mon, 18 Nov 2024 12:18:24 +0100
Cc: "Jan Kiszka" <jan.kiszka@siemens.com>, xenomai@xenomai.org
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1018-673b2280-29-5b0c8700@119759758>
Subject: =?utf-8?q?Re=3A?= Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean
Authentication-Results: spool.mail.gandi.net;
	dkim=fail ("headers rsa verify failed") header.d=thom.fr.eu.org header.s=default header.b=Ulk0Eh6O;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of devel@thom.fr.eu.org designates 212.27.42.5 as permitted sender) smtp.mailfrom=devel@thom.fr.eu.org

Le Lundi, Novembre 18, 2024 11:32 CET, Florian Bezdeka <florian.bezdeka=
@siemens.com> a =C3=A9crit: 
 
> On Mon, 2024-11-18 at 11:21 +0100, Fran=C3=A7ois Legal wrote:
> > Le Lundi, Novembre 18, 2024 10:01 CET, Jan Kiszka <jan.kiszka@sieme=
ns.com> a =C3=A9crit: 
> > =C2=A0
> > > On 18.11.24 09:50, Fran=C3=A7ois Legal wrote:
> > > > Hello,
> > > > 
> > > > running on an Arm v7 cortex A9 platform, I'm trying to switch f=
rom xenomai 3.2 (linux 5.4 IPIPE) to xenomai 3.3 (linux 5.15 Dovetail).=

> > > > 
> > > > I can successfully boot my system with linux 5.15 + CONFIG=5FDO=
VETAIL, but as soon as I enable Xenomai (CONFIG=5FXENOMAI), I got stuck=
 at boot in a do=5Fidle loop. Did I miss anything ?
> > > > 
> > > > Attached is my config.
> > > 
> > > Can you factor out from it what the SoC is, if you patched the ke=
rnel
> > > for it (in the past and now), if you had to adopt Dovetail etc.?
> > > 
> > > Jan
> > 
> > The SoC is Xilinx zynq 7000. I have custom patches for custom FPGA =
peripherals (which most of them have been successfully ported to 5.15).=

> 
> We had a similar report for the zynq 7020 a couple of days ago.
> See [1].
> 
> What happens if you disable CONFIG=5FSMP? (Not that this should be th=
e
> final solution, but it might help to track the issue down...)
> 
> Florian
> 

Disabling config SMP makes my system boot again.
How can I help working this out ?

Fran=C3=A7ois

> [1]
> https://lore.kernel.org/xenomai/71139a9c193d776b890f11ebb01ae7a3e9dbd=
7bb.camel@siemens.com/T/#t
> > 
> > > 
> > > -- 
> > > Siemens AG, Technology
> > > Linux Expert Center
>

