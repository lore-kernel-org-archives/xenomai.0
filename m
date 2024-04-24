Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B340158A0B
	for <xenomai@lists.linux.dev>; Wed, 24 Apr 2024 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959821; cv=none; b=r86HbKntQNlPiyty69z7KybX/CcwfKlMPVAXp9KGNVdZx/LBQOswI63GyKNsF1cuKtAmVxqCQHUcx8lSAQHesH9XiuzDjg99cNQL4qCiYCFZJTxwx8Iy3QkiOnaffozAoF4yEd572PniNLM0zGTfIGwdXImiU8T1X8evxRybfM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959821; c=relaxed/simple;
	bh=hQaILNDArtNvt5gwwpesW6ocDf8p3fFE/q5UwqQa1CM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=YUYVdzn9mbYfIck68UrvH6UULMBxJkvEq3tjh41vMD0EDqPymyvZNSoCPNQHT9d4E1R5ajRMdl4EExZpM0NdkqzbfhyXC+xZECL7WvpFqZuifMBgJSywgZ2NUBqg0jypddm43D3X4ItNgCNTiD1TyBUu1BXQxo+JXRN/VPCYbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=fail (1024-bit key) header.d=126.com header.i=@126.com header.b=AtuS8jFc reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="AtuS8jFc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=oiHxmIoQzFhQ/EDU1yMMzuyf+yw20ProDydj2L88BCc=; b=A
	tuS8jFc4xnbI/e9laL+cUBX2kJ36Yjv9rfqe1/KcF8hqf4WuomKL/SjohDQUJuFn
	djL5ux/zPraJFTkhGlp9lw6kRsr24J7uw82mlXZtgkLZtMoW2ahZ5dz6dga2PFZD
	t6fXMZqU6jDfuqLNOGthql0tXy7m5A91Z8kbCiEk+M=
Received: from yxianyao$126.com ( [103.161.254.5] ) by
 ajax-webmail-wmsvr-41-111 (Coremail) ; Wed, 24 Apr 2024 19:56:43 +0800
 (CST)
Date: Wed, 24 Apr 2024 19:56:43 +0800 (CST)
From: "Yao Yongxian" <yxianyao@126.com>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: greg@embeddedgreg.com, xenomai@lists.linux.dev
Subject: Re:Re: MSI NOT pipeline-safe & Internal error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 126com
In-Reply-To: <6644bcdb-5867-452a-9c11-c82014e50b7d@siemens.com>
References: <61031e69.8c6e.18ef0aff82b.Coremail.yxianyao@126.com>
 <6644bcdb-5867-452a-9c11-c82014e50b7d@siemens.com>
X-NTES-SC: AL_Qu2aAfWetkAr5SiYY+kWmEsQju45WMW0uPwu3YZTOJs0qi7n2z0SeHptNmvf7tKsDh6HtR2tVhpJwOV/Ra5ybppuXwa3jc0JNA6Dk8xSWstE
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <6c251ca.986e.18f0ff71ba2.Coremail.yxianyao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3vwR88yhm1ghnAA--.50092W
X-CM-SenderInfo: p10lt0x1drqiyswou0bp/1tbiGADJs2VLa1zMMAADsE
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpLAoKPkF0IDIwMjQtMDQtMjQgMDQ6NTU6NDYsICJKYW4gS2lzemthIiA8amFuLmtpc3prYUBz
aWVtZW5zLmNvbT4gd3JvdGU6Cj5PbiAxOC4wNC4yNCAxMjoxMCwgWWFvIFlvbmd4aWFuIHdyb3Rl
Ogo+PiBIaSwKPj4gCj4+PiBPbiBNb24sIEphbiAxNiwgMjAyMyBhdCA5OjQ0IEFNIEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+IHdyb3RlOgo+Pj4+Cj4+Pj4gT24gMTYuMDEuMjMg
MDk6NDAsIFlhbyxZb25neGlhbiB3cm90ZToKPj4+Pj4KPj4+Pj4gSGksCj4+Pj4+Cj4+Pj4+IFRo
ZSBmb2xsb3dpbmcgZXhjZXB0aW9uIG9jY3VycmVkIHdoZW4gcnVubmluZyB0aGUga2VybmVsKExp
bnV4LTUuNC4xODAsIHhlbm9tYWktMy4yLjIpIG9uIGFhcmNoNjQgY29tcHV0ZXIuCj4+Pj4+IEF0
dGFjaG1lbnQgaXMgc3RhcnR1cCBpbmZvcm1hdGlvbiBhbmQga2VybmVsIGNvbmZpZ3VyYXRpb24u
Cj4+Pj4+Cj4+Pj4+IFdoYXQgY2F1c2VkIHRoZSBleGNlcHRpb24/IFBsZWFzZSBnaXZlIG1lIHNv
bWUgaGludHMhCj4+Pj4KPj4+PiBNYXliZSBqdXN0IHNvbWV0aGluZyBsaWtlIHdlIGhhdmUgaW4g
RG92ZXRhaWwgYWxyZWFkeToKPj4+Pgo+Pj4+IGh0dHBzOi8vc291cmNlLmRlbnguZGUvWGVub21h
aS9saW51eC1kb3ZldGFpbC8tL2NvbW1pdC80MmY0NGNmODU5ZTM1MjVlYjI2ZGMwOTBmZmZhOTdi
ZmMzNWU4NzBjCj4+Pj4KPj4+PiBKYW4KPj4+Pgo+Pj4+IC0tCj4+Pj4gU2llbWVucyBBRywgVGVj
aG5vbG9neQo+Pj4+IENvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4Cj4+Pj4KPj4gCj4+
PiBIYXZlIHlvdSBydW4gdGhlIGlwaXBlIG9uIHRoaXMgcGxhdGZvcm0gYmVmb3JlPyAgSXQgbG9v
a3MgbGlrZSB5b3UKPj4+IGhhdmUgYW4gSVJRIHNvdXJjZSB0aGF0IGlzbid0IGlwaXBlIHNhZmUs
IGl0IG1heSBiZSBjYXVzaW5nIGlzc3Vlcwo+Pj4gd2hlbiB0aGUgSVJRIGlzIHRyeWluZyB0byBi
ZSBoYW5kbGVkLiAgSSdtIG5vdCBmYW1pbGlhciB3aXRoIHRoaXMKPj4+IHBsYXRmb3JtLiBEaWQg
eW91IHBvcnQgaXQgdG8gaXBpcGU/Cj4+IAo+PiBJdCBydW5zIG9uIEh1YXdlaSBUYWlzaGFuIFNl
cnZlcihDUFU6IGFybXY4IEt1bnBlbmc5MjApLgo+PiBEb2VzIHhlbm9tYWkvaXBpcGUvZG92ZXRh
aWwgbm90IHN1cHBvcnQgdGhpcyBDUFUvc2VydmVyo78KPj4gRG9lcyB0aGUgY29tbXVuaXR5IGhh
dmUgYW55IHBsYW5zIHRvIHN1cHBvcnQgaXQ/Cj4+IAo+Cj5JJ20gbm90IGF3YXJlIG9mIGFueW9u
ZSBoYXZpbmcgdHJpZWQgWGVub21haSBvbiBzdWNoIGEgc2VydmVyLiBGb3Igc29tZQo+aW4gdGhp
cyBjb21tdW5pdHksIGl0IG1heSBldmVuIGJlLi4uIHRyaWNreSB0byBnZXQgb25lIGV2ZW4gaWYg
dGhleQo+d2FudGVkIHRvLgo+Cj5CdXQgSSdtIHN1cmUgdGhhdCBhbnkgcGF0Y2ggd3JpdHRlbiB0
byBlbmFibGUgdGhpcyBzdXBwb3J0IHdpbGwgYmUKPndlbGNvbWUgdG8gdGhlIGRvdmV0YWlsIHRy
ZWUgLSBwcm92aWRlZCB0aGF0IGdlbmVyYWwgc3VwcG9ydCBpcyBhbHJlYWR5Cj5pbiB0aGUgdXBz
dHJlYW0ga2VybmVsLgoKVGhlIHVwc3RyZWFtIGtlcm5lbCBzaG91bGQgYWxyZWFkeSBzdXBwb3J0
IHRoaXMgaGFyZHdhcmUgcGxhdGZvcm0uCgpVc2luZyB0aGUgdXBzdHJlYW0ga2VybmVsIG9uIHRo
aXMgaGFyZHdhcmUgcGxhdGZvcm0gaXMgb2ssIApidXQgYXBwbHlpbmcgaXBpcGUvZG92ZXRhaWwg
YW5kIHhlbm9tYWkgcGF0Y2hlcyB0byB0aGUgdXBzdHJlYW0ga2VybmVsIGlzIHByb2JsZW1hdGlj
LgoKPkphbgo+Cj4tLSAKPlNpZW1lbnMgQUcsIFRlY2hub2xvZ3kKPkxpbnV4IEV4cGVydCBDZW50
ZXIKCi0tCllhbyBZb25neGlhbgoK
