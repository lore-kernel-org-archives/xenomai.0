Received: from de-s03-gw2.mail.cloud.nospamproxy.com (de-s03-gw2.mail.cloud.nospamproxy.com [178.212.92.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D67A217701
	for <xenomai@lists.linux.dev>; Wed,  9 Jul 2025 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=178.212.92.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048071; cv=pass; b=boHlY7TT4s91f9UgkSjPfKdtECulcIJ6t8wJxNSIL0tewgZU2JrRvObK/wQUpXaQTgKahvXx4XuhpUP3UU2w3qCtpcztF3B4TBM8VdWgp1IZ1rey0hbpK124GrgxNLd30DXTy3GJvEkPkVrP3Ji/ahJDtSA0zooApYTfzBLo8Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048071; c=relaxed/simple;
	bh=HwjGLyyDC8+ouP/1IWgmzxuFeWDw8llrtvzhQYR5xu8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=vA7pEnpZIdMxWwQH9itO0mjV9IfK7T2/jzOqxdYkpgTEU/jgTkqk3GF/M8QOHryzGgMMjDUFnZ8WBXjV0NwUOdOLLCl7bhFcl4Mhv4GipYWIW8aeAigoy0tLisB/EAJciN0qQhhpEdNDbqdoFH8CwVs3imP5YlJokXV3JHUAubc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baumueller.com; spf=pass smtp.mailfrom=baumueller.com; dkim=permerror (0-bit key) header.d=baumueller.com header.i=@baumueller.com header.b=r4jy0NsZ; dkim=pass (1024-bit key) header.d=baumueller.com header.i=@baumueller.com header.b=EnVl/tQd; arc=pass smtp.client-ip=178.212.92.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baumueller.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baumueller.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=baumueller.com header.i=@baumueller.com header.b="r4jy0NsZ";
	dkim=pass (1024-bit key) header.d=baumueller.com header.i=@baumueller.com header.b="EnVl/tQd"
ARC-Seal: i=1; cv=none; a=rsa-sha256; t=1752047765; d=cloud.nospamproxy.com; 
 s=arc-s03-250709061604r; b=
 uCOAosxkHFwK1QcZBay85HZLz4yiZ69lCxmQ1H7KYLGUn2RF2nOEd286w383WZcdH3Drswf4mksNCBQDDCK7DIJQrLzLx0mWbtAhGKPvPzH1AMliF2DXTDM8vC0zEUHlCNjYszMAG8H6FbJWsxdNVKaWO95A47lbtMhXmhBspyI=
ARC-Message-Signature: i=1; c=relaxed/relaxed; d=cloud.nospamproxy.com; 
 s=arc-s03-250709061604r; t=1752047765; 
 bh=HwjGLyyDC8+ouP/1IWgmzxuFeWDw8llrtvzhQYR5xu8=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 m6HWe4DTdOb8q/r9puVmeVv3VnY6N3hvdTqLFic9Rq42yIaRkcXcGv2tks7Q2dTxd2TJLoifG6qh5/VFV7vSsa7mvo17Qyhcoa85w2QLLyfH/itGSPPjZyQktdO7j/sVpbG25Q4pvr8dkt7skfBbLR2u8dqaudPikHrW20Ycm9M=
ARC-Authentication-Results: i=1; cloud.nospamproxy.com;spf=Pass
 smtp.mailfrom=Peter.Steub@baumueller.com
 smtp.helo=nospam.baumueller.com;dmarc=Pass header.from=baumueller.com
DKIM-Signature: v=1; c=relaxed/relaxed; d=baumueller.com; s=dkim1e; 
 t=1752047765; bh=HwjGLyyDC8+ouP/1IWgmzxuFeWDw8llrtvzhQYR5xu8=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 r4jy0NsZKCnkpkogTxaX8GdXpBXs8mP7nVvEmdSonZiWEHdpbl43oqEtX0VKSZA15ysSCkLECLUczfi4mPe2Ag==
DKIM-Signature: v=1; c=relaxed/relaxed; d=baumueller.com; s=dkim1r; 
 t=1752047765; bh=HwjGLyyDC8+ouP/1IWgmzxuFeWDw8llrtvzhQYR5xu8=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 EnVl/tQdNdfbE5FxsTmnb0QP5HQU54Uj9VbTkXOT3sSenb7Fnq7/fArX3S2NIoBceTr6NcRAiFwVICUbcJb9bul02eettHB2b3m7LkegJCYj6www6EIpapStDt+WbJyiremjoj4bkVe5UQDCgeMeDXxzWb0gWiQQMB03J8op9L0=
From: "Steub, Peter" <Peter.Steub@baumueller.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: [EVL_XENOMAI-4] libevl and __USE_TIME_BITS64 on 32bit ARMv7
Thread-Topic: [EVL_XENOMAI-4] libevl and __USE_TIME_BITS64 on 32bit ARMv7
Thread-Index: AdvwpuKBls/PuQ6OSi2Dqmr4+DVZYg==
Date: Wed, 9 Jul 2025 07:56:03 +0000
Message-ID: <e5963e4cef7d473baf4a039d8eac49b1@baumueller.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

I just realized, that my application is using 32bit time values, which is n=
ot what I want and need. So I added " -D_TIME_BITS=3D64 -D_FILE_OFFSET_BITS=
=3D64" to my toolchain. Now the evl api is not working anymore. All functio=
ns with "timespec" like "evl_read_clock()" fail since "timespec" has change=
d from 32bit seconds to 64bit seconds.

What is the right way to fix this, I guess I need to build libevl with 64bi=
t time values but I did not find how to do it right.=20

Evl (R51) is cross build through a Yocto build.

Thank you.

Mit freundlichen Gr=FC=DFen / kind regards

i. A. Peter Steub


