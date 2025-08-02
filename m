Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171061EE7C6
	for <xenomai@lists.linux.dev>; Sat,  2 Aug 2025 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754121870; cv=none; b=TTWySytOue1WPE1h47XY40jHfJNbfKWZUhSlgCdMZQEHJAHQVRMUVinbt6hlOq1iC4Pvz7qRRcKsHjHfWUQ0PeuhWAauxMEMe4ihZSDLLOWhlSerENoSqbp9vVBOGaJuERq1mknkDBrnVDlcr0bw6cebf+44PDwZvFC9gQ4xqec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754121870; c=relaxed/simple;
	bh=/LvhSY17RUny4A44rXcFs5hWXcilxTCNd7rsUizp150=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=ojbcD5pcqOibOOdi0EwYcMCZG2ThiZ4AsBszb4wuZXBhszjm7jlfKBDUJlWMNQcIuv2kV4M6kQLC6sSV2NYw03Fjg18IJRA6QNx27Zx0cHxtxRkbP7s3mYH5rnLQlFeLjGqsUM6AiSdrb1UrdJdFR8die7Z6KLE8fFv0ZJ/JWq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=A2LF7y9G reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="A2LF7y9G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=wDmAtlXfM0t+d9T8Hw4O813e1VDepR83Epn7Gwuh1c0=; b=A
	2LF7y9G+S8Rp+rOKrNOQntOouI+KOM3WWxxMnyUuuw8A12tnlYbT2EfVmMnGOT9Z
	jYVXQyDPXlZHkpSjrNzsAEojAfvZ28QiIGuKGtkI8EoQeVt6/Xv+HhgfODY0fZFE
	F+SZxtZsjwzA+5JcFe5MzTly2cEznJ54Q4zHQytuJw=
Received: from suntaoworks$163.com ( [120.224.142.42] ) by
 ajax-webmail-wmsvr-40-124 (Coremail) ; Sat, 2 Aug 2025 16:04:19 +0800 (CST)
Date: Sat, 2 Aug 2025 16:04:19 +0800 (CST)
From: Suntao <suntaoworks@163.com>
To: xenomai@lists.linux.dev
Subject: How to enable floating-point operations in XNThread
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2eBv2ZvkAu7yOfY+kZk0YXj+c/W8K1vvsg1YdfPJs0kyTU3jwcdm5fNmL19PmCLyqmoQmWVgJX8fZBeqB+Ubqzu22PTJkShZkqRyioGDDG
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <310ab4c5.1f5d.19869cf7137.Coremail.suntaoworks@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:fCgvCgD3FzODxo1oPQIRAA--.4453W
X-CM-SenderInfo: xvxq3txrzr2yrv6rljoofrz/xtbBgAydYmiNvZFmFwACsJ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CmRlYXIgYWxso6xJIHVuZGVyc3RhbmQgdGhhdCB3aGVuIGRldmVsb3BpbmcgTGludXgga2VybmVs
IG1vZHVsZXMgb24gQVJNIHBsYXRmb3JtcywgaWYgZmxvYXRpbmctcG9pbnQgb3BlcmF0aW9ucyBh
cmUgaW52b2x2ZWQsIGl0J3MgbmVjZXNzYXJ5IHRvIGNhbGwga2VybmVsX25lb25fYmVnaW4oKS9r
ZXJuZWxfbmVvbl9lbmQoKS4gQWRkaXRpb25hbGx5LCB3aGVuIGNyZWF0aW5nIGFuIHhudGhyZWFk
LCB0aGUgWE5GUFUgZmxhZyBuZWVkcyB0byBiZSBzZXQuIEhvd2V2ZXIsIEknbSB1bmNsZWFyIGFi
b3V0IGhvdyB0byBwZXJmb3JtIGZsb2F0aW5nLXBvaW50IG9wZXJhdGlvbnMgc3BlY2lmaWNhbGx5
IHdpdGhpbiByZWFsLXRpbWUgdGhyZWFkc6GjcGxlYXNlIGhlbHAgbWUsIHRoYW5rcy4KCgo=
