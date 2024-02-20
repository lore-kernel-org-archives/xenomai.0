Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B85D5C90A
	for <xenomai@lists.linux.dev>; Tue, 20 Feb 2024 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417291; cv=none; b=GG971FW29L4aA8Db/Sf6V5FRJhZ1YFfi76JB0VnKUGaXvWT1l1DKVyADtYLvIqpmeYdndWM8TuL+tZFZ1HOKcyHx3Jx00qPqNWelrNB9ZLoOq4HuASuPViupAenUZph7fb4luvamQgM9/E6x6J23tip0DWEXllh56P32xx+fBlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417291; c=relaxed/simple;
	bh=fFK27F2SiILGmfOCHhv85tg2Xy+6G+/KVoJDSuhBV6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=VLsadRB0BtiSctMUgf+EZF2tAGjdV8dA7mJRRA09Hn/g76SZ7VWeoH0k2wJZnFXad1N9xb9uYvC808g0FCMPi60KTF/RVfgf2sbKH2C4R9FqQy8UqafTkudbexjdEDDgbA66Slllw2/U0Ky6gTWr1ORxvVQeISZuu16SXLmeWSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=WQ0ZLeal reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="WQ0ZLeal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=20rN9U6mzHHujbRNrnVW/hEAgTHTbK2HDBIRy4S9iY8=; b=W
	Q0ZLealz9d4Y9S+BJvYtd7uvWOqQDniKOf96Jdq9dJb/Qxk8TJr6PuT8mtJKQD9Q
	lfPQ8fllPzqvh8Ln9S2EesBZ3D8idd3fOsp5Z1AlMDKdn8ixd1XknEm8fL4TVr1k
	dInArrwGvXny9nc1xYnU1n1mO9yu6ePzNnOh7gcS7I=
Received: from mars_liu2023$163.com ( [103.161.254.5] ) by
 ajax-webmail-wmsvr-40-106 (Coremail) ; Tue, 20 Feb 2024 16:21:11 +0800
 (CST)
Date: Tue, 20 Feb 2024 16:21:11 +0800 (CST)
From: mars_liu2023  <mars_liu2023@163.com>
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Subject: Re:Re: Re: latency: pthread_create(latency): Operation not
 permitted
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <9933892442fcf9195f1ac75e23b9fee46b830ef2.camel@siemens.com>
References: <789c8c7f.87f2.18d1bd6752c.Coremail.mars_liu2023@163.com>
 <12402f4121aca76943a0dfadd02149f074aab801.camel@siemens.com>
 <5da66ea7.23e4.18d2c1eddae.Coremail.mars_liu2023@163.com>
 <9933892442fcf9195f1ac75e23b9fee46b830ef2.camel@siemens.com>
X-NTES-SC: AL_Qu2bCviauEos5yeYZ+kWmEsQju45WMW0uPwu3YZTOJs0uCTO6yEAQVBJBln1y96oAimdnzeXfBds88B+frVRT5NmgtOJJI5LEtfvCts+dU0o
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <4038884f.9223.18dc59ac79c.Coremail.mars_liu2023@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3f2L3YNRlb+jMAA--.61255W
X-CM-SenderInfo: 5pdu2sholxjiist6il2tof0z/xtbB0giKD2WXwGV8NwACsB
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKQXQgMjAyNC0wMS0yNSAwMDozOToxNywgIkZsb3JpYW4gQmV6ZGVrYSIgPGZsb3JpYW4uYmV6
ZGVrYUBzaWVtZW5zLmNvbT4gd3JvdGU6Cj5PbiBTdW4sIDIwMjQtMDEtMjEgYXQgMjE6MDMgKzA4
MDAsIG1hcnNfbGl1MjAyMyB3cm90ZToKPj4gCj4+IFRvwqBGbG9yaWFuCj4+IFRoaXMgZXJyb3Ig
aXMgcnVubmluZyB0aGUgbGF0ZW5jecKgdXRpbGl0ecKgb3V0c2lkZSB0aGUgY29udGFpbmVyLgo+
PiBJIGluc3RhbGxlZCB0aGUgY29udGFpbmVyZC5pbyBwYWNrYWdlIHRocm91Z2ggdGhlIGRwa2cg
LWkgY29tbWFuZCDvvIx0aGVuIHJ1bm5pbmcgbGF0ZW5jeSB1dGlsaXR5wqAgb3V0c2lkZSB0aGUg
Y29udGFpbmVyIGFuZCB0aGlzIGVycm9yIHdpbGwgb2NjdXIuCj4+IAo+Cj5JIHRyaWVkIHRvIHJl
cHJvZHVjZSB0aGF0IGhlcmUgaW4gdGhyZWUgZGlmZmVyZW50IGNvbWJpbmF0aW9uczoKPgo+YSkK
Pi0gZG9ja2VyIDIwLjEwLjI0K2Rmc2cxIChkb2NrZXIuaW8gcGFja2FnZSBmcm9tIERlYmlhbiAx
MikKPi0gWGVub21haSAzLjIuNAo+LSBEb3ZldGFpbC9LZXJuZWwgNS4xMC4KPgo+YikKPi0gRG92
ZXRhaWwvS2VybmVsIDYuMSBpbnN0ZWFkIG9mIDUuMTAKPgo+YykKPi0gWGVub21haSAzLjMtZGV2
IChuZXh0IGJyYW5jaCkgaW5zdGVhZCBvZiBzdGFibGUKPi0gRG92ZXRhaWwvS2VybmVsIDYuNiBp
bnN0ZWFkIG9mIDYuMS81LjEwCj4KPmEpIGlzIHJ1bm5pbmcgZmluZSBoZXJlCj5iKSBzaG93ZWQg
dGhlIHByb2JsZW0KPiAgIC91c3IvbGliL3hlbm9tYWkvdGVzdHN1aXRlL2xhdGVuY3k6IHB0aHJl
YWRfY3JlYXRlKGxhdGVuY3kpOiBPcGVyYXRpb24gbm90IHBlcm1pdHRlZAo+YykgU2FtZSByZXN1
bHQgYXMgYikKPgo+RGlzYWJsaW5nIHRoZSBzeXN0ZW1kIHVuaXRzIGRvY2tlciwgZG9ja2VyLnNv
Y2tldCBhbmQgY29udGFpbmVyZAo+Zm9sbG93ZWQgYnkgYSByZWJvb3QgInNvbHZlcyIgdGhpcyBw
cm9ibGVtLiBJIGhhdmUgbm8gaWRlYSB3aGF0J3MgZ29pbmcKPm9uLCBidXQgSSBndWVzcyBpdCdz
IHNvbWV0aGluZyByZWxhdGVkIHRvIGNncm91cHMgb3IgYW55IHJlc291cmNlIGxpbWl0Cj50aGF0
IGlzIGNoYW5nZWQgYnkgb25lIG9mIHRoZSBkYWVtb25zIG9uIHN0YXJ0dXAuCj4KPkZ1cnRoZXIg
aW52ZXN0aWdhdGlvbnMgbmVjZXNzYXJ5LCB1bmNsZWFyIGlmIEkgd2lsbCBsb29rIGludG8gdGhh
dAo+c29vbi4KCj4KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5IGFuZCBjb21tZW50cwpBZnRlciBz
b21lIHRpbWUgd2Ugc3RpbGwgY2FuJ3QgZ2V0IGFyb3VuZCB0aGUgYWJvdmUgcHJvYmxlbSAuIEhh
cyB0aGUgc29sdXRpb24gdG8gdGhpcyBwcm9ibGVtIGJlZW4gZm91bmTvvJ8KClJlZ2FyZHMKCj5G
bG9yaWFuCj4KPgo+PiAKPj4gU2V0dGluZyBrZXJuZWwuc2NoZWRfcnRfcnVudGltZV91cz0tMSBj
YW4gYXZvaWQgdGhpcyBlcnJvci4KPj4gRm9yIHRoZSBub3JtYWwgb3BlcmF0aW9uIG9mIHJ0IGFw
cGxpY2F0aW9ucyxzaG91bGQgSSDCoGRvIHRoaXMgc2V0dGluZyBhZnRlciBpbnN0YWxsaW5nIGNv
bnRhaW5lcmQuaW8gP8KgCj4+IElzIHRoZXJlIGFuIGFic29sdXRlbHkgY29ycmVjdCBhcHByb2Fj
aCBvciBvZmZpY2lhbCBzZXR0aW5ncyBvZiB4ZW5vbWFpIO+8nwo+PiAKPj4gCj4+IExvb2tpbmcg
Zm9yd2FyZCB0byB5b3VyIHN1Z2dlc3Rpb25zCj4+IEJlc3QgcmVnYXJkcwo+PiAKPj4gCj4+IOWc
qCAyMDI0LTAxLTE4IDE5OjU4OjEw77yMIkZsb3JpYW4gQmV6ZGVrYSIgPGZsb3JpYW4uYmV6ZGVr
YUBzaWVtZW5zLmNvbT4g5YaZ6YGT77yaCj4+ID4gT24gVGh1LCAyMDI0LTAxLTE4IGF0IDE3OjEw
ICswODAwLCBtYXJzX2xpdTIwMjNAMTYzLmNvbSB3cm90ZToKPj4gPiA+IGhpIHhlbm9tYWksCj4+
ID4gPiAKPj4gPiA+IEkgaGFkIGEgcHJvYmxlbSB3aGVuIHJ1bm5pbmcgL3Vzci9saWIveGVub21h
aS90ZXN0c3VpdGUvbGF0ZW5jeTrCoCA9PSBTYW1wbGluZyBwZXJpb2Q6IDEwMCB1cwo+PiA+ID4g
wqAgPT0gVGVzdCBtb2RlOiBwZXJpb2RpYyB1c2VyLW1vZGUgdGFzawo+PiA+ID4gwqAgPT0gQWxs
IHJlc3VsdHMgaW4gbWljcm9zZWNvbmRzCj4+ID4gPiDCoCAvdXNyL2xpYi94ZW5vbWFpL3Rlc3Rz
dWl0ZS9sYXRlbmN5OiBwdGhyZWFkX2NyZWF0ZShsYXRlbmN5KTogT3BlcmF0aW9uIG5vdCBwZXJt
aXR0ZWQKPj4gPiA+IAo+PiA+ID4gCj4+ID4gPiAKPj4gPiA+IHhlbm9tYWkgdmVyc2lvbjp2My4y
LjQ7IGtlcm5lbCB2ZXJzaW9uOiA1LjEwLjE5OS14ZW5vbWFpLjMuMi40Cj4+ID4gPiAKPj4gPiA+
IAo+PiA+ID4gSSBoYXBwZW5lZCB0byBmaW5kIHRoaXMgcHJvYmxlbSBpcyByZWxhdGVkIHRvIGlu
c3RhbGwgY29udGFpbmVyZC5pb18xLjYuMjQtMV9hbWQ2NC5kZWIuCj4+ID4gPiBpZsKgIGRwa2cg
LXIgY29udGFpbmVyZC5pb194eC5kZWIgdGhlbiB0aGUgbGF0ZW5jeSB0ZXN0IGlzIG9rIC4KPj4g
PiA+IGhvdyBjYW4gaSBtYWtlIGxhdGVuY3kgd29yayB3aXRoIGNvbnRhaW5lcmQuaW8uCj4+ID4g
PiBkb2VzIGNvbnRhaW5lcmQuaW8gZWZmZWN0IHRoZSBlbnYgb2YgeGVub21haSBhcHBsaWN0aW9u
Pwo+PiA+IAo+PiA+IEFyZSB5b3UgdHJ5aW5nIHRvIHJ1biB0aGUgbGF0ZW5jeSB1dGlsaXR5IGZy
b20gaW5zaWRlIG9yIG91dHNpZGUgdGhlCj4+ID4gY29udGFpbmVyPwo+PiA+IAo+PiA+IEluIGNh
c2UgeW91J3JlIHRyeWluZyB0byBydW4gaXQgaW5zaWRlIGEgY29udGFpbmVyOiBXZSBtaWdodCBo
YXZlIGEKPj4gPiBuYW1lc3BhY2luZyBpc3N1ZSBoZXJlLiBJIGNhbiByZW1lbWJlciB0aGF0IHdl
IGhhZCBmaXhlZCBzb21lIG9mIHRoZW0sCj4+ID4gYnV0IG1heWJlIHRoZXJlIGlzIG1vcmUuCj4+
ID4gCj4+ID4gRmxvcmlhbgo+PiA+IAo+PiA+ID4gCj4+ID4gPiAKPj4gPiA+IHRoYW5rc8KgYW5k
IHJlZ2FyZHMK
