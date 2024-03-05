Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1026FC1C
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619110; cv=none; b=HSnC1eh88KZp+YOuL374HYUEgOGE5+iMpL9bhOqSyRLwa57jbou1e5ZSLDUzw0QxbWR4adNJ/NMx/VF1GZB3z+BBRQDZNyjSHsGIKkTAh+GMlLcIrnYdzgUE1lYZihLtbWN36dhzr3JD9M61V5cajDlXaWdH+ThAQ6t68Z2HHf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619110; c=relaxed/simple;
	bh=eybfMMcRuFP9PRxrrcVVZkZgJ3tLEM7RnAYWbunKpGc=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=d4Quh7DNBH2V7ffRCndyBxhvs0VzP7jFP+ZrtDrn0ec8GvDOFYfgu1Nw/KzqnWFXt6tDIN6y5Uc1LkuSDc+PoObyUzkm0wISzmglz6KeWrrBgEMXcCRSRwPCsx4FQ7SdPWfiiP8JdYpTQfSFjSuP3NFjZxBolBfCVbwUHJBAEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=j4QAVMMx reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="j4QAVMMx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=OSu1wIgU69JsimOV0Fi5gfr8LXyGipH3NCx0NRGrK/o=; b=j
	4QAVMMxAIZ+0N6XzKZikJT12Ak6SFYAgzowzHdNqaaiB2r7H4hS8Ok24mOZ1ZvxQ
	ALBB3qO7ESY73rqUwRCtoO4mpzveRCmsnHImJAOe/8aKsaPO/fZpVNFvEAUmJztp
	wG2cGVCPksC3dJLBHClfSxlN0JlGIutKcQEcXNEvx0=
Received: from suntaoworks$163.com ( [120.224.142.42] ) by
 ajax-webmail-wmsvr-40-111 (Coremail) ; Tue, 5 Mar 2024 14:11:40 +0800 (CST)
Date: Tue, 5 Mar 2024 14:11:40 +0800 (CST)
From: =?UTF-8?B?5a2Z5rab?= <suntaoworks@163.com>
To: xenomai@lists.linux.dev
Subject: Re:xenomai in vmwear
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <abbbd8a.85e2.18e0d30c733.Coremail.suntaoworks@163.com>
References: <abbbd8a.85e2.18e0d30c733.Coremail.suntaoworks@163.com>
X-NTES-SC: AL_Qu2bC/qatkkr5iWfZOkZk0YXj+c/W8K1vvsg1YdfPJs0oCTz4w46V1VqPWfr8dKlFxGCmjKacyhz1sBVcotcUKcFHDaICP3jKarrZ3kyVwXp
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <5ffd9077.8bbc.18e0d3d3ba1.Coremail.suntaoworks@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3n3adt+ZlhioFAA--.23390W
X-CM-SenderInfo: xvxq3txrzr2yrv6rljoofrz/xtbBoAaYYmWXwEXNmwABs8
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgptb3JlIGluZm9ybWF0aW9uOndpdGhvdXQgeGVub21haSBwYXRjaCAsaXQgd29ya3MgZmlu
ZSBvbiBib3RoIGRlYmlhbjggYW5kIGRlYmlhbjkKCgoKCgoKCgoKQXQgMjAyNC0wMy0wNSAxMzo1
ODowNCwgIuWtmea2myIgPHN1bnRhb3dvcmtzQDE2My5jb20+IHdyb3RlOgo+Cj4KPmRlYXIgbWFp
bnRhaW5lcnMsaSB1c2UgeGVub21haSgzLjEueCkrbGludXgga2VybmVsKDQuMS4xOCkraXBpcGUr
ZGViaWFuOCt2bXdlYXIrdm13ZWFyIHRvb2wgZm9yIGRldmVsb3BpbmcuaXQgd29ya3MgZmluZS53
aGVuIGkgY2hhbmdlIHRvIGRlYmlhbjksIGl0IGNhbid0IGZ1bGwgZGVza3RvcChoYXMgbGltaXQg
ZHBpKS5pIMKgd29uZGVyIHdoeT8gc2FtZSBrZXJuZWwsc2FtZSBwYXRjaGVzLHNhbWUgdm13ZWFy
LG9ubHkgc3lzdGVtIG9wZXJhdGlvbiBpcyBkaWZmZXJlbnQuIGkgYWxzbyBjb25maXJtIHRoYXQg
eG9yZyBvZiBkZWJpYW44IGFuZCBkZWJpYW45IMKgaXMgYWxzbyBzYW1lLmhlbHAgbWUsdGhhbmtz
Lgo=
