Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029910;
	b=43SfR+iIYEkIXIbOV5cpWhoDaPGLo+7E0kr8bDRmqaLS6e9+L4KC1zj+1hQZCeKxU6/T
	 +JG4/2ugWyIYiv2NbEY2r8tEIv3B9VFVHyUT8Xe3JCagajF4cpCKPPvlWsgV0xgH6PGVm
	 wpLUfY8pfzE2oG9T3pxi2RlNsT7gI7Q1TqQRXEct4fYra8aq0ArJMMLLMdjh+uNTStvnY
	 jrddLsQ2W+BRhSNcHf8bSH8bnEOP4LwxuKkH127Vs8LGuK87FKLltPapGGI1Uwicoo2Jl
	 Ey23JKexmzr2XDbitAA3GV1g0R15vCQJQgLOC1oXFmPRkZKXWcJJ99CQRSa4bOjgnig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029910;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=E4nZ2+N0sOif/+jql9/oVeWRnqFCcY/7zGKQhp6EeKQ=;
	b=a1DU3bV9FUDvxByrl6jmsykS2+lL45fdut7zy/qpusUCWQvVQ2ei1jDW7xzMAVL+W9ct
	 v6TujsJqXTu9gRWamcfAVxclbGfGhoHS+Q3FcivoCGSyE144AlazZkQevh1RWZfaW4k/7
	 pb9Kmn/nqj+Cbsj27OqUb1YhLR618TPGAm8yKVMfdjkm4pztmpUo9pwytFUxx58Xsnb2F
	 yjfXwmN3A411U+WJDy3ZWXk+BxQYb/enUvSIPBkJDTIl1+1xUixU2YceypJbyWxk+1J8d
	 rIkXbNASA2Zi+g2hrt3AELaqBwXLWTktIWZx09lQAWHIBdyz8bt4XtV4PVgu2pDbKPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=qXUIpLXJ;
	arc=none smtp.remote-ip=185.136.64.225
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA133606A31A
	for <xenomai@lists.linux.dev>; Mon, 26 Oct 2026 15:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA133606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=qXUIpLXJ
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20261026155139ce054502da0002076e
        for <xenomai@lists.linux.dev>;
        Mon, 26 Oct 2026 16:51:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=E4nZ2+N0sOif/+jql9/oVeWRnqFCcY/7zGKQhp6EeKQ=;
 b=qXUIpLXJm2mtKKmWDg9xujz4jX4L6UiP20xqE6yJdO3qlnj6i6qOX4DHjdESaPr+cxMpn+
 Q0TgWckYmbM0PGlfykPeWGdH5Cxr7QydICyLZh1hJKDwjpwEO6Wd7PX29U3tBwgo2y4s6rCQ
 wJoPR5N9DeLnPbX68PL8Jvo+6g1AhKHtOyGSLT5wlGKzVi/NX69zLwaTPLRY3OU+YVFv+wFI
 LuFW/ObQlCd2TcU3gch5xJPX27sZK62Xut1iQDACHqOU0loT25JHpQPkgz63Z/vvmxOVdGxf
 GcjD8yraTKC988wJqxXHmPoFpe9apBYUrp/dUtGawzEqTSM+h+pzSGsQ==;
Message-ID: <121abb882d62ce6d04e28bbedd76f0c445c12748.camel@siemens.com>
Subject: Re: Dovetail 7.3 release candidate available
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Date: Mon, 26 Oct 2026 16:51:38 +0100
In-Reply-To: <eec03efd38a42874e7ff4c7fca7246208e49ef03.camel@siemens.com>
References: <eec03efd38a42874e7ff4c7fca7246208e49ef03.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Mon, 2026-10-26 at 15:35 +0100, Florian Bezdeka wrote:
> Hi all,
>=20
> I just pushed a first Dovetail release candidate based on Linux 7.3 to
> the repository. The release candidate is available in the=C2=A0
>=20
> =C2=A0=C2=A0=C2=A0 wip/flo/v7.3-dovetail-rebase
>=20
> branch.
>=20
> Please test this release candidate as much as you can. If you plan to
> use that release in production: Let us know. We did not decide on
> Dovetail=20

... maintenance for that release yet.


Seems I pressed the "send" button a bit too fast.
