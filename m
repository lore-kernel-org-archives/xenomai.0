Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEACB15B145
	for <xenomai@lists.linux.dev>; Thu, 18 Apr 2024 10:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435074; cv=none; b=kb3jNPzBNOR4M1BG3VYmcMZa9OdjCLq7ASFztuhN+gRoRzDTEOnJHZArjtCEJ5swR7z8/SUDhflcRByHZQU/9dsR2lmytxcgPZ3Qy10cde68vUWqyW20dNtliUNdPhe8OTD6wv3NV78CSrBqIOtjichJCigw7EtAtbmztcRMb4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435074; c=relaxed/simple;
	bh=MZVyeOV1eOGOgAWQUQpqfwVXKwGmdO54j2C7X/Zsi44=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=F8EhyOhvp6xKQjMKf2kb1E7wx1Scuc0P2BszUNNfOvs03NjlGHi+9gkSouYDYaIa5DDhhv/0uJuJxtR0g4YmiSIsBuieynHJ8i9/HieFQCu4TyFnERVZo+/6CqPSol0MVaA+vKZ+Spm5GylNGVC49Pmb3XvXDEcLrD8iBwixhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=fail (1024-bit key) header.d=126.com header.i=@126.com header.b=hbLct3ui reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="hbLct3ui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=pHYkrTHe+AjtKqcsRQCgd863WGKqtrwhx09Fr0lsMhw=; b=h
	bLct3uiQU2fi89Pp5MWQBvkFSLv7szoC83VbvaKbb0e+iikH2uLaYEgZBvCAdHzc
	ApNCFtN0DyPnHmXgLKk+dp1ZFbS43O4kVWU0pevEtFwwM5Wi1bLUNsgYjUN4E4a0
	JznpJIOVhRsQNukuI7VRYVpdP3FvsZdIn8FD2L6Guw=
Received: from yxianyao$126.com ( [103.161.254.5] ) by
 ajax-webmail-wmsvr-41-117 (Coremail) ; Thu, 18 Apr 2024 18:10:47 +0800
 (CST)
Date: Thu, 18 Apr 2024 18:10:47 +0800 (CST)
From: "Yao Yongxian" <yxianyao@126.com>
To: greg@embeddedgreg.com, jan.kiszka@siemens.com, xenomai@lists.linux.dev
Subject: MSI NOT pipeline-safe & Internal error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 126com
X-NTES-SC: AL_Qu2aAfiYukgv4SmfYOkWmEsQju45WMW0uPwu3YZTOJs0li7T+SceWVtYF1r3996TFRmTlDyofils1uZRVopmQqaKZm/vgqCVCpz1N4Ck7Rzl
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <61031e69.8c6e.18ef0aff82b.Coremail.yxianyao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3H5Oo8SBmky9WAA--.57603W
X-CM-SenderInfo: p10lt0x1drqiyswou0bp/1tbiGAjDs2VLauteXgAEsL
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGksCgo+T24gTW9uLCBKYW4gMTYsIDIwMjMgYXQgOTo0NCBBTSBKYW4gS2lzemthIDxqYW4ua2lz
emthQHNpZW1lbnMuY29tPiB3cm90ZToKPj4KPj4gT24gMTYuMDEuMjMgMDk6NDAsIFlhbyxZb25n
eGlhbiB3cm90ZToKPj4gPgo+PiA+IEhpLAo+PiA+Cj4+ID4gVGhlIGZvbGxvd2luZyBleGNlcHRp
b24gb2NjdXJyZWQgd2hlbiBydW5uaW5nIHRoZSBrZXJuZWwoTGludXgtNS40LjE4MCwgeGVub21h
aS0zLjIuMikgb24gYWFyY2g2NCBjb21wdXRlci4KPj4gPiBBdHRhY2htZW50IGlzIHN0YXJ0dXAg
aW5mb3JtYXRpb24gYW5kIGtlcm5lbCBjb25maWd1cmF0aW9uLgo+PiA+Cj4+ID4gV2hhdCBjYXVz
ZWQgdGhlIGV4Y2VwdGlvbj8gUGxlYXNlIGdpdmUgbWUgc29tZSBoaW50cyEKPj4KPj4gTWF5YmUg
anVzdCBzb21ldGhpbmcgbGlrZSB3ZSBoYXZlIGluIERvdmV0YWlsIGFscmVhZHk6Cj4+Cj4+IGh0
dHBzOi8vc291cmNlLmRlbnguZGUvWGVub21haS9saW51eC1kb3ZldGFpbC8tL2NvbW1pdC80MmY0
NGNmODU5ZTM1MjVlYjI2ZGMwOTBmZmZhOTdiZmMzNWU4NzBjCj4+Cj4+IEphbgo+Pgo+PiAtLQo+
PiBTaWVtZW5zIEFHLCBUZWNobm9sb2d5Cj4+IENvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExp
bnV4Cj4+Cgo+SGF2ZSB5b3UgcnVuIHRoZSBpcGlwZSBvbiB0aGlzIHBsYXRmb3JtIGJlZm9yZT8g
IEl0IGxvb2tzIGxpa2UgeW91Cj5oYXZlIGFuIElSUSBzb3VyY2UgdGhhdCBpc24ndCBpcGlwZSBz
YWZlLCBpdCBtYXkgYmUgY2F1c2luZyBpc3N1ZXMKPndoZW4gdGhlIElSUSBpcyB0cnlpbmcgdG8g
YmUgaGFuZGxlZC4gIEknbSBub3QgZmFtaWxpYXIgd2l0aCB0aGlzCj5wbGF0Zm9ybS4gRGlkIHlv
dSBwb3J0IGl0IHRvIGlwaXBlPwoKSXQgcnVucyBvbiBIdWF3ZWkgVGFpc2hhbiBTZXJ2ZXIoQ1BV
OiBhcm12OCBLdW5wZW5nOTIwKS4KRG9lcyB4ZW5vbWFpL2lwaXBlL2RvdmV0YWlsIG5vdCBzdXBw
b3J0IHRoaXMgQ1BVL3NlcnZlcqO/CkRvZXMgdGhlIGNvbW11bml0eSBoYXZlIGFueSBwbGFucyB0
byBzdXBwb3J0IGl0PwoKVGhhbmtzLgoKLS0KWWFvIFlvbmd4aWFuCgo=
