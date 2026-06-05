Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926AD2F532F
	for <xenomai@lists.linux.dev>; Fri,  5 Jun 2026 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780628438; cv=none; b=AEzwm7AJZZb6VTaTg5NLtBc5zcMLcvbUuXHXYHAYhcb1DIZLiZTF68d+OsNjxcfEtDh9eudzyjy7mp+G7eSgiPK4X2yMMaGNBocUc8WePrX20RnlpCrIPHFEdmFuIeyqyN0MUqv8Ec5e0YXJfR59cfcSMMpcme8ND4aGJGcZ/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780628438; c=relaxed/simple;
	bh=pVR4D/cf6FLANBCwA95hWBRpDZuGngB8EKivmepIywQ=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=fwXV2fqQJPNL29WkobkM0tu7Bg2ik0kI5AlVcq7tCtz0cm4HPtHGpKsTvkCVtxeJQWJbujEjnIkYHrkgH990vQq4lOkqlAsGX7YI+Q5DH3jVQYZdV8Wie1O8R0bYgc94dDFK1g6kU09AtxIdHcSxYtlGS13sO/52Ioi429r2Qs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=C7x5xAVR; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="C7x5xAVR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780628421; bh=pVR4D/cf6FLANBCwA95hWBRpDZuGngB8EKivmepIywQ=;
	h=From:To:Subject:Date;
	b=C7x5xAVRx/N18jUVaEeJZkwrG+h6yih2BnuSWIZ+F3mQJzMX/bI7nmW3l0SI5MFKe
	 qdqP2WMQi48Es43hJcMAAJSX4HexgfKgwLplm925FzF1GptBUrFTZkek0BB0QZxHCI
	 kjcVNiKG+XcmFGj8bZZf/uNjwrsd/oA1JzeaDyC8=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-XMAILINFO: MFBABGT0feQ/l94p5/H+uktaPGi+urZ2+SleabcIk3YQtF6yuF2Hg4eOibWmDA
	 ov0DMKYK5B0B/SfZSJRep3284A5d09QI7ZbXTsUd5d4dK1l0UN1PDqnOsInwDN1yVIg3cGRQIDqPg
	 922G9vM3CfC2NbXSBkbjydfYNAuhsF1j2rONJV8hY3hsNcBnSkiZfX6ZIbJu9nKNmmY1XkU26yPjh
	 /dyaUa3IwXZqh4FGRoSOYJXJ7r3+uBRLkDruhwCKvmT/OIkqj2Pc4ZHKEZOjYbEg0Z66vGMAp0J/B
	 sfHgjFsnUHK3IQlfzjYHVC3DI633WNc7RLMCF3vNNsAcgv8hHcVdCB3xfjicCYulewdTBr/Dg5+9U
	 aM08dTeQlM2d9tPbOFtxkg2NcEfLcxHeLBFENoLADWBx5wI4O2bFJobUA7HXq1vMTM/5U0NOZjefU
	 3Mb1ZBET5nrgaIgtPXsf+DGzqfh5RuWCx0o68IFaWadd+sZzhxeSYCcBwM9s+e0O8LVWHKmfHdx8D
	 76Y7+bF6/HJDIdCNq3bKEstblQ3UfIon3QrcG6HWlkgn9sifDoZXTu5d2LcKu9HtWs3LKggEyXCXw
	 V4zgXQrrKgrtigYAwnu052afhx7mDGSY1PVDhnwhVLPiCasPU/z7EObXMz0Zz6kkLOg9fUkW9zVJC
	 Ma/F/zPFU9P3XhgTk+kRviIR4czUXL6bDVoSL1xlWtHLkbnnl6Xp5z8gNP+qjLgnEsJRuspQd8b+B
	 rB0HvH+5yc232RJK/U7ndb8IPQmgGK3+PrZnXnFDsjzeduswTxGNU9D405lqzgrOQ93CtgVlDX1rk
	 tfuHeedRloq0FHTGlKesEUNTMMKsCKxo6QUJsssvzty4WsAqJJRPAuw8WJW2OX0UjO1HK1GnmoUhp
	 cMfD0LAGS5TOP63m/pJZExD5c3+T2iXWo7Toc2mO3mkk+W1Bq3akrX2kQ6kyJ5zuxArZ6VRT2QroQ
	 zRuH02M4saDNBX/jrqluYiCjz125I4ssco7W0M/BFlOIWVNdQ60sot96c9SuKlHiYA6tqF5k4qitz
	 RkpStrvbNcPu4GnLHGt8UfRim5Q4g0dpg/6w/In11fzq0In2JfTuQqsGPEA==
From: "=?utf-8?B?8J+QsA==?=" <384434518@qq.com>
To: "=?utf-8?B?eGVub21haUBsaXN0cy5saW51eC5kZXY=?=" <xenomai@lists.linux.dev>
Subject: [Xenomai] Inquiry about Xenomai 3 Cobalt support for Raspberry Pi 5 (BCM2712)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 5 Jun 2026 11:00:20 +0800
X-Priority: 3
Message-ID: <tencent_4B6C1E0637495CD615CA662268723067AA09@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezb41-0t1780628420t6y50c8y6

RGVhciBYZW5vbWFpIFRlYW0sCgpJIGFtIGNvbnNpZGVyaW5nIHVzaW5nIFhlbm9tYWkgMyBv
dmVyIHRoZSBDb2JhbHQgY29yZSBvbiB0aGUgUmFzcGJlcnJ5IFBpIDUsIHdoaWNoIGlzIGJh
c2VkIG9uIHRoZSBCcm9hZGNvbSBCQ00yNzEyIFNvQyAoQ29ydGV4LUE3NiwgQVJNdjguMuKA
kUEpLiBJIGhhdmUgY2hlY2tlZCB0aGUgb2ZmaWNpYWwgIlN1cHBvcnRlZCBIYXJkd2FyZSIg
cGFnZSBmb3IgWGVub21haSAzLCBidXQgaXQgY3VycmVudGx5IGxpc3RzIG9ubHkgdGhlIEJD
TTI4MzUvQkNNMjgzNiBzZXJpZXMgZm9yIEJyb2FkY29tIFNvQ3MgYW5kIGRvZXMgbm90IG1l
bnRpb24gdGhlIEJDTTI3MTIuCgpGb3IgeW91ciByZWZlcmVuY2UsIG1haW5saW5lIExpbnV4
IGhhcyBhZGRlZCBzdXBwb3J0IGZvciB0aGUgQkNNMjcxMiBTb0Mgc3RhcnRpbmcgZnJvbSB2
ZXJzaW9uIDYuMTIsIGFuZCBsYXRlciB2ZXJzaW9ucyBzdWNoIGFzIDYuMTgsIDYuMTksIGFu
ZCA3LjAgY29udGludWUgdG8gc3VwcG9ydCBpdC4KCklzIHRoZSBCQ00yNzEyIC8gUmFzcGJl
cnJ5IFBpIDUgY3VycmVudGx5IHN1cHBvcnRlZCBieSBYZW5vbWFpIDMgb3ZlciB0aGUgQ29i
YWx0IGNvcmUgKGluY2x1ZGluZyB0aGUgcmVxdWlyZWQgRG92ZXRhaWwgaW50ZXJydXB0IHBp
cGVsaW5lIHN1cHBvcnQpPyBJZiBub3QsIGlzIHRoZXJlIGFueSBwbGFuIHRvIGFkZCBzdXBw
b3J0IGluIHRoZSBuZWFyIGZ1dHVyZT8KClRoYW5rcy4KCgkK8J+QsAozODQ0MzQ1MThAcXEu
Y29t

