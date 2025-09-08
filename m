Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F620CCDC
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757300759; cv=none; b=TicHDgrYe+1YO3U5f6BfVenSGniXBIP58cYvOkHBmZSewV3l2+VmV6D7y8WzOmC76aQptdEZUmidAHbS6i4PV9jPWghVoAT7mnTuVcZVAVGO9PSBHDlc3z8YFkAdsYL9zGIRhTf7emnlMHo7lFKdHHYu2vSJCnrUml8MxIJXISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757300759; c=relaxed/simple;
	bh=yhHwHbI3MrVvqKkMXVlO47Lskvb7alNQIjbCntrGQwM=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=KRPuq6iuuEbI9rnm35t05HLoRHz49nRHtKHlz+T6GmaxFJs6mxCp78ZU8Xg2Tt2BHRbELimqfpYBXoiYVUVmYeLY7o0vc4OaUcWd2YsHI6jF/pFO409xhgRssWNxx4woGaqjMRfYj6u1plLpb5Xqgse0vNxSKPyaYyoOspudNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=EJBpLMdg; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="EJBpLMdg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=yhHwHbI3MrVvqKkMXVlO47Lskvb7alNQIjbCntrGQwM=; b=E
	JBpLMdgey9ofJGYdG7wL0SJEaWSMb6/ihCA1dZl3BC1d8TVshnZ2Z5rIxuOuvlB2
	na8f4d28QGKoYf9Loq483b93fcFBYMl1s3Da/wuADPb8NVYE7DW1q0HBZxzM0gj1
	NFUTh23B5YgBfTObakDR8hZ8/MhO5Fsek/6iAK55TA=
Received: from yxianyao$126.com ( [183.238.12.146] ) by
 ajax-webmail-wmsvr-41-107 (Coremail) ; Mon, 8 Sep 2025 11:05:46 +0800 (CST)
Date: Mon, 8 Sep 2025 11:05:46 +0800 (CST)
From: "Yao Yongxian" <yxianyao@126.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Regarding the issue of rt_timer_read
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 126com
In-Reply-To: <6e6d5f0a.3f41.18ce78d31f5.Coremail.yxianyao@126.com>
References: <5990240f.1ddd.18c8f7bf237.Coremail.yxianyao@126.com>
 <c8491c64-f8d7-4136-8552-8ac1fb111170@siemens.com>
 <6e6d5f0a.3f41.18ce78d31f5.Coremail.yxianyao@126.com>
X-NTES-SC: AL_Qu2eBf+bv08v4ymRYukWmEsQju45WMW0uPwu3YZTOJs0oi7hxi0PXF5CGmn78suWICaqmzyQYRZv5cheVKlIX7AgQ8it+SsocFz0LylPb0gS
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <5a675ae.2fa0.19927496712.Coremail.yxianyao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aykvCgDnT0gLSL5oC1opAA--.25099W
X-CM-SenderInfo: p10lt0x1drqiyswou0bp/1tbiWAu9s2i3l5gXVwAGsL
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpLAoKT24gdGhlIHNhbWUgY29tcHV0ZXIsIGltbWVkaWF0ZWx5IGV4ZWN1dGUgcnRfdGltZXJf
cmVhZCgpIGFmdGVyIHJlYm9vdGluZyB0aGUgbWFjaGluZSB0byBvYnRhaW4gdGhlIHRpbWU6Cgph
KSBXaGVuIHJ1bm5pbmcgTGludXggNC4xOS44OSAgICsgaXBpcGUgICAgICArIFhlbm9tYWkzLjEs
ICAgICBydF90aW1lcl9yZWFkKCkgcmV0dXJuIDg3MTUwNjk5OTBucwpiKSBXaGVuIHJ1bm5pbmcg
TGludXggNS4xMC4xOTkgKyBkb3ZldGFpbCArIFhlbm9tYWkgMy4yLjQsIHJ0X3RpbWVyX3JlYWQo
KSByZXR1cm4gICAgIDUwODc5MDI4bnMKClRoZSB0aW1lIHJlYWQgYnkgcnRfdGltZXJfcmVhZCBp
cyB0aGUgcmVsYXRpdmUgdGltZSBzaW5jZSB0aGUgc3lzdGVtIHN0YXJ0dXAuIFdoeSBkb2VzIHNj
ZW5hcmlvIGEgcmVhZCB0aW1lIGFzIGxvbmcgYXMgb3ZlciB0d28gaG91cnMsIHdoaWxlIHNjZW5h
cmlvIGIgaXMgbm9ybWFsPwoKLS0KVGhhbmtzLApZYW8gWW9uZ3hpYW4=
