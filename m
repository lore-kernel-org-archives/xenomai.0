Received: from proxy25215.mail.163.com (proxy25215.mail.163.com [103.129.252.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB72A258C
	for <xenomai@lists.linux.dev>; Sun,  3 Dec 2023 07:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="eGa5Op5l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=o7M+UF0qlz8ekHP+0lkBQQ3pP/3jZpJD2LNOiO78eXo=; b=e
	Ga5Op5lbvS36QMFJC1ijHVtwSQjZ6CAD3MtOtaPsFixqD37HOaXTLv+hLi/KK174
	z0V3Fdrqf1M4jEo1EFzotT4WUFQ8SAQdNSH6JBw53iuso1gzKZ/LR0eRUCRzdI2y
	JHFrgI0nwZYV72YXiWED3sOp+Ju47Ny3yMzb7+mLn8=
Received: from mars_liu2023$163.com ( [14.153.114.226] ) by
 ajax-webmail-wmsvr-40-106 (Coremail) ; Sun, 3 Dec 2023 15:13:19 +0800 (CST)
Date: Sun, 3 Dec 2023 15:13:19 +0800 (CST)
From: "mars_liu2023@163.com" <mars_liu2023@163.com>
To: xenomai <xenomai@lists.linux.dev>
Subject: Can xenomai-kernel boot on the second-generation hyper-v ?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2bA/mTuE0i7ySRZekfm0sbgO89WcWzvv4v245TN51wjCDp9jEeQHRIGFjpyduGLTqzjBOcThV/4NlbQrZUbp4XHrD4TCqUtef8BYbDugGx0A==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <420e5f7c.141a.18c2e864085.Coremail.mars_liu2023@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3XyCPKmxlWvESAA--.46056W
X-CM-SenderInfo: 5pdu2sholxjiist6il2tof0z/xtbBnAk7D1ghlxpPrQAMs7
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgeGVub21haSwKCkkgdHJpZWQgdG8gbGVhcm4gdGhlIFhlbm9tYWkga2VybmVsIG9uIMKgSHlw
ZXItVu+8jGFuZCBhcHBlYXIgc29tZSBwcm9ibGVtcy4KeGVuby1rZXJuZWwgY2FuJ3QgYm9vdCBv
biB0aGUgaHlwZXItdiAsc28gaSBkaWQgdGhlIGZvbGxvd2luZyAuCkkgc2F3IHN1Y2ggYSBtZXNz
YWdlIGluIG90aGVyIG1haWxzIGluIHRoZSBjb21tdW5pdHkgdGhhdCAicHJldmVudCBDT05GSUdf
SFlQRVIgZnJvbSBiZWluZyBidWlsdCBpZiBpbnRlcnJ1cHQgcGlwZWxpbmUgaXMgZW5hYmxlZCIs
c28gaSBkaXNhYmxlZCBDT05GSUdfSFlQRVIgZm9yIMKgYm9vdCB4ZW5vX2tlcm5lbCh2ZXJzaW9u
IDo1LjEwLjE4MC14ZW5vbWFpLjMuMi4yKcKgIG9uIGh5cGVyLXYgLgppdCBjYW4gd29yayB3ZWxs
IG9uIHRoZSBmaXN0LWdlbmVyYXRpb24gaHlwZXItdixidXQgaXQncyBib290IGZhaWxlZCBvbiB0
aGUgc2Vjb25kLWdlbmVyYXRpb24gaHlwZXItdi4KVGhpcyBpcyBhbHNvIHRoZcKgIGNhc2Ugd2hl
biBkaXNhYmxlZCBDT05GSUdfSFlQRVIgb24gbm9ybWFsIGxpbnV4IGtlcm5lbC4KRGlkIGkgZG8g
c29tZXRoaW5nIHdyb25nID8gaXQgc2VlbXMgbGludXggKHZlc3Jpb24gNS4xMC4xODApIGRpc2Fi
bGVkIENPTkZJR19IWVBFUiBjYW4ndCB3b3JrIG9uIHRoZSBzZWNvbmQtZ2VuZXJhdGlvbiBoeXBl
ci12LgpJcyB4ZW5vLWtlcm5lbChkb3ZldGFpbCkgbm90IGFsbG93ZWQgdG8gd29yayBvbiB0aGUg
c2Vjb25kLWdlbmVyYXRpb24gaHlwZXItdj8gaWYgbm90ICxob3cgZG8gaSBkbyBpdCA/CnRoYW5r
cyBmb3IgYW55IHJlcGx5LgoKVGhhbmtzIGFuZCByZWdhcmRzCgoK
