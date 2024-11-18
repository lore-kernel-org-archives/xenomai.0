Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02719340E
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925308; cv=none; b=ZlY4vo1weexy1ML+OuLm6fKFHPLOpyVuMqWsHJgqAqgEiXe1NglTiAYikOPBri0KcIscmS6FWJ80Nt1429PNKO7O/g9PxVG4yaLTOaelDkywoZmBFgMrQOpnzR2qCxgpFj4M6hSbBwt0x/aHQaK2oY05v21PQl8i9R0vthzu/7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925308; c=relaxed/simple;
	bh=EF3kvmiEw0eQboYbu1/2LuH2yAsC3AtrT1inKwHKLMw=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=PRfus+19ewDVfPRc3EVsNv6AT0hQj4mg59rJ9fDzUsFX4LBKUK1Lnnntk63t9kupWfxUZOLJ4AP3SLaUj7YWMPbBNWEGinKrfbTabKKiSNuRppSCUdd11Bl6FkVtzuNifRsEYAYakmY56L4XVzmZSE76rDUtLgw+VkTs26LMuys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=o4WVRptH; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="o4WVRptH"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id B6CE110000A
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 10:21:35 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 9123974004E
	for <xenomai@xenomai.org>; Mon, 18 Nov 2024 10:21:33 +0000 (UTC)
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 531AF5FFB7;
	Mon, 18 Nov 2024 11:21:33 +0100 (CET)
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 4AIALN8e2717334;
	Mon, 18 Nov 2024 11:21:27 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1731925292;
	bh=EF3kvmiEw0eQboYbu1/2LuH2yAsC3AtrT1inKwHKLMw=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=o4WVRptHp16Oeh8RMz8iufdn6wfwAfyxyQB8KHJxsM3OL/yatxZv7f9Hp37+FsR9o
	 AaZyf+jwRf9zbVqaEkJSVbKOx3JrG//bGIOjlKoj6yFkYa6Cr/2l00KEXqqLRcd5VA
	 /CO4bjd8rTMo+2S1Crq62WafKVUz3jynQL7YQe3WFe+S9T0W5v2KDdfzT0Kp3zyV9z
	 Y7V/9isfLaS8gWtAz6VrbccMT3U2bS+t0LJr0w/VOOvn1xGjLg6YLEtNPpyG17GUiX
	 4yMDTIRuJaRIExeYZ8jddPF4XWQQurMienzTKBbAHRHKUPKos7mQuw2neMPh+bO0cI
	 L8wSrcA9DH22g==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <95cf1a42-58f9-4319-b2a6-45400bad4c15@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.100.101
Date: Mon, 18 Nov 2024 11:21:23 +0100
Cc: xenomai@xenomai.org
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1017-673b1500-29-2c5d8800@223319941>
Subject: =?utf-8?q?Re=3A?= Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean
Authentication-Results: spool.mail.gandi.net;
	dkim=fail ("headers rsa verify failed") header.d=thom.fr.eu.org header.s=default header.b=o4WVRptH;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of devel@thom.fr.eu.org designates 2a01:e0c:1:1599::14 as permitted sender) smtp.mailfrom=devel@thom.fr.eu.org

Le Lundi, Novembre 18, 2024 10:01 CET, Jan Kiszka <jan.kiszka@siemens.c=
om> a =C3=A9crit: 
 
> On 18.11.24 09:50, Fran=C3=A7ois Legal wrote:
> > Hello,
> > 
> > running on an Arm v7 cortex A9 platform, I'm trying to switch from =
xenomai 3.2 (linux 5.4 IPIPE) to xenomai 3.3 (linux 5.15 Dovetail).
> > 
> > I can successfully boot my system with linux 5.15 + CONFIG=5FDOVETA=
IL, but as soon as I enable Xenomai (CONFIG=5FXENOMAI), I got stuck at =
boot in a do=5Fidle loop. Did I miss anything ?
> > 
> > Attached is my config.
> 
> Can you factor out from it what the SoC is, if you patched the kernel=

> for it (in the past and now), if you had to adopt Dovetail etc.?
> 
> Jan

The SoC is Xilinx zynq 7000. I have custom patches for custom FPGA peri=
pherals (which most of them have been successfully ported to 5.15).

> 
> -- 
> Siemens AG, Technology
> Linux Expert Center

