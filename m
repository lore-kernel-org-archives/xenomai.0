Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76BC194A40
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925955; cv=none; b=n2Qosk+xEwFExbq6WGW8nZkjrSaMFd0JqVqRStvoMo+9zVxvyW/jXuhAEMWcDTSfDJp5SCbGw1pBUtn6S9GKVlvDJlEiUdBdiqXuybuD6FP+q8cdk2k8hkhmoyg+GkJLACuRL7LXD/x6AiuQLIZ0X71AazR+5f77VijLzwQle7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925955; c=relaxed/simple;
	bh=qD68h5iu/EH9+pxl6VUm5979cF62NkxOm8MOqM9zz/c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CIJ5n1JgQ0EfrHLfxu6hlfvkRdG4QeHqWOgYNemRdFQn8vPpMxWoh9qzQnLQ19WSZEXqr4CTxk06RqvVQMoI8Xrmm8aJu8pIdrWrJRhgXDMah2VUVeAMXg0NwQzB7FYFZx9zOjNGz6aF+kNHCtbrCOvP1spJT9eGhOcRGw3oDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=IILugvK0; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="IILugvK0"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 60225100005
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 10:32:28 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 8C8D27803D8
	for <xenomai@xenomai.org>; Mon, 18 Nov 2024 10:32:27 +0000 (UTC)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20241118103226b0b19e3f582d5f25f3
        for <xenomai@xenomai.org>;
        Mon, 18 Nov 2024 11:32:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qD68h5iu/EH9+pxl6VUm5979cF62NkxOm8MOqM9zz/c=;
 b=IILugvK0rrfi9BWS6c144cDURn4q88/xUXcI6n3mly9j16ujmbl3YTFAfyw4rnJWVRULDr
 l+mAZLgx5XTn9MTnRf9e0s9mAU5CiLPrvKQ8/XUrUO8ZnIV2Ijv0jlh8y93IiW7JJnSYRcVe
 MTopx9JVyDkAN3rM2KuQZEK5Opz/pu9CBQc+BjpDit4RhJ5Yj17gHjfTFxDzhSRTqdx57IaV
 vKjM48cUmEQpMUpMLXogzdrT29Xg9bM/cXDRsqQ2tcU8+69NoUUdRb9FVvrFDJzI+Qk73JxZ
 ym2oT+NBpQqLnsaupd4AhjLiD/KsaA8XpW1hwtODbKE9RwPbQShuX5IA==;
Message-ID: <a1f4a1141c0a281d58d22b8f4552afd6094f1bec.camel@siemens.com>
Subject: Re: Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Fran=E7ois?= Legal <devel@thom.fr.eu.org>, Jan Kiszka
	 <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org
Date: Mon, 18 Nov 2024 11:32:26 +0100
In-Reply-To: <1017-673b1500-29-2c5d8800@223319941>
References: <1017-673b1500-29-2c5d8800@223319941>
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
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm2 header.b=IILugvK0;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-20241118103226b0b19e3f582d5f25f3-oT21oG@rts-flowmailer.siemens.com designates 185.136.65.228 as permitted sender) smtp.mailfrom=fm-68982-20241118103226b0b19e3f582d5f25f3-oT21oG@rts-flowmailer.siemens.com

On Mon, 2024-11-18 at 11:21 +0100, Fran=C3=A7ois Legal wrote:
> Le Lundi, Novembre 18, 2024 10:01 CET, Jan Kiszka <jan.kiszka@siemens.com=
> a =C3=A9crit:=20
> =C2=A0
> > On 18.11.24 09:50, Fran=C3=A7ois Legal wrote:
> > > Hello,
> > >=20
> > > running on an Arm v7 cortex A9 platform, I'm trying to switch from xe=
nomai 3.2 (linux 5.4 IPIPE) to xenomai 3.3 (linux 5.15 Dovetail).
> > >=20
> > > I can successfully boot my system with linux 5.15 + CONFIG_DOVETAIL, =
but as soon as I enable Xenomai (CONFIG_XENOMAI), I got stuck at boot in a =
do_idle loop. Did I miss anything ?
> > >=20
> > > Attached is my config.
> >=20
> > Can you factor out from it what the SoC is, if you patched the kernel
> > for it (in the past and now), if you had to adopt Dovetail etc.?
> >=20
> > Jan
>=20
> The SoC is Xilinx zynq 7000. I have custom patches for custom FPGA periph=
erals (which most of them have been successfully ported to 5.15).

We had a similar report for the zynq 7020 a couple of days ago.
See [1].

What happens if you disable CONFIG_SMP? (Not that this should be the
final solution, but it might help to track the issue down...)

Florian

[1]
https://lore.kernel.org/xenomai/71139a9c193d776b890f11ebb01ae7a3e9dbd7bb.ca=
mel@siemens.com/T/#t
>=20
> >=20
> > --=20
> > Siemens AG, Technology
> > Linux Expert Center

