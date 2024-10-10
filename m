Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3FD1E1A16
	for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728544898; cv=none; b=aHm/S34TcHvQj+ZQz9cQMEZhrS76IrSDuQn3fPYiPVkXaUBXrvLeAO3WOOF2nZhBIjR5L5/EGfiz4B3REswueoY3FFhWlOsi0Bn4au67HCt1rqtnrrNPMFkaks5kZ9cO2gWJ6JWqn1sPMreP5UYa4Kf1s7R3oK9BHtxZm7TNe8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728544898; c=relaxed/simple;
	bh=DJcduXSB6aY5rLKZNM45LWHuuIPSTyRp9vMZQpafBak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=u80aQ3wq5rWinUeA5/AoYLpcEr1vQrZFy2sKDKNk+d7Lm+JppjbdYQUQ13fPHy50Ni5RkZdRaaDqV0klabmLnlKReLixE/mSSHoHS8pTvGDdTPbYuRxyQxh700VwyAdlu6G0adCTmpcyL71k0gP/KqH5R2qJfsOsOKgf2ucadbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=EpDrJu53 reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="EpDrJu53"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=5HFzriVwtreg4/f5e5O5GT+kEeXwt2AEmS4kycqCD38=; b=E
	pDrJu53fmgCb5wPzFn9T3GxN6soct4AZqHE8g7mrwHrcQmik7C0gIQ9ycT1R2Cja
	ozy2nzbRGWCVjG1yC6m6Us+A/fiJ0K6b8nzw573EKTobSUyExZZELbHohvrGqHOr
	FS8iOwH//KpM8EFnbDrMGVQvJjP0hjGsLU2h90v7SU=
Received: from mars_liu2023$163.com ( [103.161.254.5] ) by
 ajax-webmail-wmsvr-40-149 (Coremail) ; Thu, 10 Oct 2024 15:21:32 +0800
 (CST)
Date: Thu, 10 Oct 2024 15:21:32 +0800 (CST)
From: mars_liu  <mars_liu2023@163.com>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Subject: Re:Re: how to add cpu load in testing latency
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <d3b53281-610b-42d3-8e56-02f5e64838cc@siemens.com>
References: <3c07ae1c.6c55.19232479f35.Coremail.mars_liu2023@163.com>
 <d3b53281-610b-42d3-8e56-02f5e64838cc@siemens.com>
X-NTES-SC: AL_Qu2ZCvmfu0Ai5CmaZ+kWmEsQju45WMW0uPwu3YZTOJs0uibW8R4FenhTAFDf4c+NLRy8tx+0QjJ0+tZbWIR5eaShy0fkgbn1NcCSzhdVNEXW
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <75e938ae.7216.192754de7fe.Coremail.mars_liu2023@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:lSgvCgDX32J9gAdnezIKAA--.19089W
X-CM-SenderInfo: 5pdu2sholxjiist6il2tof0z/xtbB0g50D2cHaLqMNAAHsq
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCkF0IDIwMjQtMDktMjcgMjE6NDE6MDEsICJKYW4gS2lzemthIiA8amFuLmtpc3prYUBzaWVt
ZW5zLmNvbT4gd3JvdGU6Cj5PbiAyNy4wOS4yNCAwOTowMCwgbWFyc19saXUgd3JvdGU6Cj4+IAo+
PiAKPj4gaGkgeGVub21haSwKPj4gCj4+IGknbSB0cnlpbmcgdG8gdGVzdCBsYXRlbmN5IHdpdGgg
ZnVsbCBjcHUgbG9hZCAuCj4+IAo+PiBpdCBoYXMgNCBjcHUgY29yZXMsYW5kIHRoZXJlIGFyZSB0
d28gbW9kZSBjYXVzZSBmdWxsIGNwdSBsb2FkIDoKPj4gMS4gCj4+IGZvciBudW0gaW4gYHNlcSA0
YCAKPj4gZG8KPj4gZGQgaWY9L2Rldi96ZXJvIG9mPS9kZXYvbnVsbCBicz0xNk0KPj4gZG9uZSAK
Pj4gMi4KPj4gc3RyZXNzIC0tY3B1IDQgCj4+IAoKSSBtYXkgaGF2ZSBtaXhlZCB1cCB0aGUgd29y
ZCAnbW9kZScgYWJvdmUuCgp0aGUgYXJndW1lbnQgZm9yICdsYXRlbmN5IC10JyBpcyBhbHdheXMg
MChkZWZhdWx0KSBpbiB0aGlzIHRlc3QgLgoKdGhlICdtb2RlJyBpIG1lYW4gYSBtZXRob2QgYWJv
dmUgdGhhdCBnZW5lcmF0ZSBjcHUgbG9hZCAuCgpzaG91bGQgaSB1c2UgJ3N0cmVzcyAtLWNwdScg
b3IgJ2RkIGlmIC4uLi4uLicgdG8gZ2VuZXJhdGUgY3B1IGxvYWQgZm9yICdsYXRlbmN5IC10IDAn
ID8gCgpSZWdhcmRzCgo=
