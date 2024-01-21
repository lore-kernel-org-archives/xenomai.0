Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96399273FB
	for <xenomai@lists.linux.dev>; Sun, 21 Jan 2024 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705842257; cv=none; b=g0n0pSpBRY3EtTeWtsin8SPEtMQot1Q2xC0RKwfFMzRrhKKfAvF1Q6zIbFTMuHpfAeuaQRohXeMjbRTWnwlAx8uz+6wcWkyiOTFu3ElPs78LtBjmkZ8DCHWtdh23ZHigGvW4V8ZB2VL1RKlieFvqu8QJffdXQk2OFxzSxjnMBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705842257; c=relaxed/simple;
	bh=M5KXHZrU2Imx66UJBB2akMUsY8AQdKPvt2dEeodf5aM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=cBASY/iy4kMBec05ebV9cbz6zYNTG+tIwjFj9HrPRGufFuYLfoKi1+1Ra0ok1IdWUAzkiu5JBpt+SfMuw5BZe7fs/DoAnjosEAg2ikZTR6u06/BsEkfDlOfFM+I6WVzmqaVlD8/6jrVDe38McxwUnD+oV2dZoo6rWpayIiehsgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=D9TODeze reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="D9TODeze"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=yCjIWPM0kORsigXKOP2H5dvMCRuR9Hd0gU4lCc3J2iI=; b=D
	9TODezeRcErrgMWXEaNLRNSepVSb2tl3YLF5K4xOy5lM78JM9AzoPueoZVQeliSU
	cLck5Hkb60cgxu14lRaxhPU5WaVsInJYyMTmTiI2/vrz1se7S1ViR9vRVrAj/+IF
	1PooM0RzrwhLXMGT82uOvDZdAp4naG0J1S9FX8s5x0=
Received: from mars_liu2023$163.com ( [14.154.4.122] ) by
 ajax-webmail-wmsvr-40-109 (Coremail) ; Sun, 21 Jan 2024 21:03:56 +0800
 (CST)
Date: Sun, 21 Jan 2024 21:03:56 +0800 (CST)
From: mars_liu2023  <mars_liu2023@163.com>
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Subject: Re:Re: latency: pthread_create(latency): Operation not permitted
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <12402f4121aca76943a0dfadd02149f074aab801.camel@siemens.com>
References: <789c8c7f.87f2.18d1bd6752c.Coremail.mars_liu2023@163.com>
 <12402f4121aca76943a0dfadd02149f074aab801.camel@siemens.com>
X-NTES-SC: AL_Qu2bB/SfvUoo4CicZ+kfm0oWgO02W8e1ufkj1IFQPpl8jCPp6zsLbXtHHXno4v6JCTi+oByTfj5TzPtFV7dWT7A3vSaPShKoUXBVABJVM+4igw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <5da66ea7.23e4.18d2c1eddae.Coremail.mars_liu2023@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3v7c9Fq1l3+NgAA--.40394W
X-CM-SenderInfo: 5pdu2sholxjiist6il2tof0z/1tbiqBhpD2VOBx6Y6AAKse
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpUb8KgRmxvcmlhbgpUaGlzIGVycm9yIGlzIHJ1bm5pbmcgdGhlIGxhdGVuY3nCoHV0aWxpdHnC
oG91dHNpZGUgdGhlIGNvbnRhaW5lci4KSSBpbnN0YWxsZWQgdGhlIGNvbnRhaW5lcmQuaW8gcGFj
a2FnZSB0aHJvdWdoIHRoZSBkcGtnIC1pIGNvbW1hbmQg77yMdGhlbiBydW5uaW5nIGxhdGVuY3kg
dXRpbGl0ecKgIG91dHNpZGUgdGhlIGNvbnRhaW5lciBhbmQgdGhpcyBlcnJvciB3aWxsIG9jY3Vy
LgoKClNldHRpbmcga2VybmVsLnNjaGVkX3J0X3J1bnRpbWVfdXM9LTEgY2FuIGF2b2lkIHRoaXMg
ZXJyb3IuCkZvciB0aGUgbm9ybWFsIG9wZXJhdGlvbiBvZiBydCBhcHBsaWNhdGlvbnMsc2hvdWxk
IEkgwqBkbyB0aGlzIHNldHRpbmcgYWZ0ZXIgaW5zdGFsbGluZyBjb250YWluZXJkLmlvID/CoApJ
cyB0aGVyZSBhbiBhYnNvbHV0ZWx5IGNvcnJlY3QgYXBwcm9hY2ggb3Igb2ZmaWNpYWwgc2V0dGlu
Z3Mgb2YgeGVub21haSDvvJ8KCgpMb29raW5nIGZvcndhcmQgdG8geW91ciBzdWdnZXN0aW9ucwpC
ZXN0IHJlZ2FyZHMKCgoKCgoKCgrlnKggMjAyNC0wMS0xOCAxOTo1ODoxMO+8jCJGbG9yaWFuIEJl
emRla2EiIDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5jb20+IOWGmemBk++8mgo+T24gVGh1LCAy
MDI0LTAxLTE4IGF0IDE3OjEwICswODAwLCBtYXJzX2xpdTIwMjNAMTYzLmNvbSB3cm90ZToKPj4g
aGkgeGVub21haSwKPj4gCj4+IEkgaGFkIGEgcHJvYmxlbSB3aGVuIHJ1bm5pbmcgL3Vzci9saWIv
eGVub21haS90ZXN0c3VpdGUvbGF0ZW5jeTrCoCA9PSBTYW1wbGluZyBwZXJpb2Q6IDEwMCB1cwo+
PiDCoCA9PSBUZXN0IG1vZGU6IHBlcmlvZGljIHVzZXItbW9kZSB0YXNrCj4+IMKgID09IEFsbCBy
ZXN1bHRzIGluIG1pY3Jvc2Vjb25kcwo+PiDCoCAvdXNyL2xpYi94ZW5vbWFpL3Rlc3RzdWl0ZS9s
YXRlbmN5OiBwdGhyZWFkX2NyZWF0ZShsYXRlbmN5KTogT3BlcmF0aW9uIG5vdCBwZXJtaXR0ZWQK
Pj4gCj4+IAo+PiAKPj4geGVub21haSB2ZXJzaW9uOnYzLjIuNDsga2VybmVsIHZlcnNpb246IDUu
MTAuMTk5LXhlbm9tYWkuMy4yLjQKPj4gCj4+IAo+PiBJIGhhcHBlbmVkIHRvIGZpbmQgdGhpcyBw
cm9ibGVtIGlzIHJlbGF0ZWQgdG8gaW5zdGFsbCBjb250YWluZXJkLmlvXzEuNi4yNC0xX2FtZDY0
LmRlYi4KPj4gaWbCoCBkcGtnIC1yIGNvbnRhaW5lcmQuaW9feHguZGViIHRoZW4gdGhlIGxhdGVu
Y3kgdGVzdCBpcyBvayAuCj4+IGhvdyBjYW4gaSBtYWtlIGxhdGVuY3kgd29yayB3aXRoIGNvbnRh
aW5lcmQuaW8uCj4+IGRvZXMgY29udGFpbmVyZC5pbyBlZmZlY3QgdGhlIGVudiBvZiB4ZW5vbWFp
IGFwcGxpY3Rpb24/Cj4KPkFyZSB5b3UgdHJ5aW5nIHRvIHJ1biB0aGUgbGF0ZW5jeSB1dGlsaXR5
IGZyb20gaW5zaWRlIG9yIG91dHNpZGUgdGhlCj5jb250YWluZXI/Cj4KPkluIGNhc2UgeW91J3Jl
IHRyeWluZyB0byBydW4gaXQgaW5zaWRlIGEgY29udGFpbmVyOiBXZSBtaWdodCBoYXZlIGEKPm5h
bWVzcGFjaW5nIGlzc3VlIGhlcmUuIEkgY2FuIHJlbWVtYmVyIHRoYXQgd2UgaGFkIGZpeGVkIHNv
bWUgb2YgdGhlbSwKPmJ1dCBtYXliZSB0aGVyZSBpcyBtb3JlLgo+Cj5GbG9yaWFuCj4KPj4gCj4+
IAo+PiB0aGFua3PCoGFuZCByZWdhcmRzCg==
