Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B091C27
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731890918; cv=none; b=qY5EGMWWfkMUEK0I5J6Yd85LT9xVAHer3KyZm2mnZ+OPXGuKXG8A6Tiw06r6vdbiRQspVFd3YEdAjO8vWIoqVQOQjWJRMGOtf1nWkRqUsCy6Jbx5Mzy0bQss4MgjP8qOht/XFAHQMcUnVQuzXNSxEL0hKomDZECx58tpSusBGcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731890918; c=relaxed/simple;
	bh=D4R+mGATmyccO5FG+7LOznvPFOsxdl/GprwDy9D7KAM=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=QTqnaYEnFhU6wFkSAINY3SYzbIf7T43tsjQOJeHfVk+UzVvNaZJuKzXPMetAfSj0DbVLRlw8r+0YnFC9/oOKM2e6fdopuDIWargNz8ka0i9uvr0rEzdhtrs3H3vyD87+z6+mG+W0wJWPlbiD5vvvzm7pnU5qC7oBk7Gtuzlv5vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=RRoBjW1r reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="RRoBjW1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=0u5//BdhDaB6HDS7cY3GY52E4mQUizDThYshLES/Uaw=; b=R
	RoBjW1r/91bLd9RRoPlzm0sg5LSLLoAOvJZM+eINxHQJIijnQmfYjMewn94u/YCF
	FjU1dy0UMUXsIoRCgL3G62sRI7lP52xN6gBGrPrTNQUgkYqFaqNtPjCSKhYyGYUv
	mm6G3PgOVsRtYVVXKAQ06AFyhOgZkvg3ifxww8NW/4=
Received: from suntaoworks$163.com ( [120.224.142.42] ) by
 ajax-webmail-wmsvr-40-113 (Coremail) ; Mon, 18 Nov 2024 08:48:25 +0800
 (CST)
Date: Mon, 18 Nov 2024 08:48:25 +0800 (CST)
From: Suntao  <suntaoworks@163.com>
To: xenomai@lists.linux.dev
Subject: Re:xenomai latency shows negative value
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <18194dcc.758d.19329a45455.Coremail.suntaoworks@163.com>
References: <18194dcc.758d.19329a45455.Coremail.suntaoworks@163.com>
X-NTES-SC: AL_Qu2YA/SSv0Er4ymabekZk0YXj+c/W8K1vvsg1YdfPJs0oiTp6A4NbW94Jl7K+s6+CRmhoAibVSBT8spwco1jU4eeZMAPGZFIx+mx1EOpObTp
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <19ece4eb.7b6.1933cbe034d.Coremail.suntaoworks@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cSgvCgD338rZjjpn8j4pAA--.61823W
X-CM-SenderInfo: xvxq3txrzr2yrv6rljoofrz/xtbBoQSaYmc5yfCKXgADst
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpJIHNvbHZlIGl0IGJ5IHVzaW5nIHhlbm9tYWkgYXV0b3R1bmUgdG9vbHMuCgoKCgoKCgoKCgoK
CgoKQXQgMjAyNC0xMS0xNCAxNTo0NzozNSwgIsvvzM4iIDxzdW50YW93b3Jrc0AxNjMuY29tPiB3
cm90ZToKPgo+ZGVhciBhbGwsCj5JIHJ1biB4ZW5vbWFpIGxhdGVuY3kgdG9vbCBvbiBteSBkZXZp
Y2UgbGlrZSAiLi9sYXRlbmN5IC10IDEgLXAgMTAwIiwgdGhlICJsYXQgYmVzdCIgc2hvd3MgbmVn
YXRpdmUgdmFsdWUuSSBhdXRvdHVuZSBpdCBsaWtlICJlY2hvIDAgPiAvcHJvYy94ZW5vbWFpL2xh
dGVuY3kiLCBpdCBjaGFuZ2VzIG5vdGhpbmcuUGxlYXNlIGhlbHAgbWUuCj5CZXN0IHJlZ2FyZHMs
Cj5TdW50YW8K
