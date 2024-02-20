Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B5260DF6
	for <xenomai@lists.linux.dev>; Tue, 20 Feb 2024 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419551; cv=none; b=tb7YXQw2vAusmLCD2pOxyEHDz3k4rTTOYhEPIKhvTcmWlCoMwxQxzBxzO/K+HIYpH4q07BFMUzuGW+1pfX2i/L4kYiIRV8EnZReQYFCTT+YvuktWhHNbhuPWvRHWEyzoaY3aJaGVEO56iH9Mfvz/065D4ZSAT1g8Kjgg/7oFeSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419551; c=relaxed/simple;
	bh=f+Mt87qF4x5cbeZR7IOu9ia84ZbzdNINmpBFFg3/+X0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=RhAHxO6Zc/DbTqfeJXjHiCbT6hIgyLS44VTpXQyV9A7DnXAdpx3pAxtGhbqw0AmiT2UTtvu3nijR4+X+QH0UpeFOqm1X4G1hXvdI7Bw0z+i4gB+H1SVer2GWNC4qm+ia4GGMOSgQ6VCd2qzmr6TdfeU8rTopMo0yL9Er9aALtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=lBo8dU4k reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="lBo8dU4k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=676a14sx/wu5bgVEk4PYHDA/TmepTqjg7R4H71HgynU=; b=l
	Bo8dU4k10fQN7S4KHe1N9+R3yyP29TwWznhYHU8t9FaNQkpqqODIyxnTk0JEA2Es
	eKfP5mOs05HDv4NCMjIfD5FfWGfqujXoJrKdCgF3Avb1zSHqtBP2ZaJtpW9sFXp/
	EyKDnmkxUoqGQABu7O/Q//Hlu2OHGlC5RafF4eFxxU=
Received: from mars_liu2023$163.com ( [103.161.254.5] ) by
 ajax-webmail-wmsvr-40-106 (Coremail) ; Tue, 20 Feb 2024 16:59:02 +0800
 (CST)
Date: Tue, 20 Feb 2024 16:59:02 +0800 (CST)
From: mars_liu2023  <mars_liu2023@163.com>
To: "Jan Kiszka" <jan.kiszka@web.de>
Cc: "Florian Bezdeka" <florian.bezdeka@siemens.com>, 
	xenomai <xenomai@lists.linux.dev>
Subject: Re:Re: latency: pthread_create(latency): Operation not permitted
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <eeca8d27-c3b7-4a89-8bbb-55a5a188a287@web.de>
References: <789c8c7f.87f2.18d1bd6752c.Coremail.mars_liu2023@163.com>
 <12402f4121aca76943a0dfadd02149f074aab801.camel@siemens.com>
 <5da66ea7.23e4.18d2c1eddae.Coremail.mars_liu2023@163.com>
 <9933892442fcf9195f1ac75e23b9fee46b830ef2.camel@siemens.com>
 <eeca8d27-c3b7-4a89-8bbb-55a5a188a287@web.de>
X-NTES-SC: AL_Qu2bCviatk0v5CWRY+kWmEsQju45WMW0uPwu3YZTOJs0uCTO6yEAQVBJBln1y96oAimdnzeXfBds88B+frVRT5NIi9VQ5a1xJRlTG4ryE8Qo
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <309ca5a7.a0ac.18dc5bd6e47.Coremail.mars_liu2023@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wCnb2nWadRlCtTmAA--.8920W
X-CM-SenderInfo: 5pdu2sholxjiist6il2tof0z/xtbB0giKD2WXwGV8NwAKsJ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjQtMDEtMjUgMTc6Mzg6MzcsICJKYW4gS2lzemthIiA8amFu
Lmtpc3prYUB3ZWIuZGU+IHdyb3RlOgo+T24gMjQuMDEuMjQgMTc6MzksIEZsb3JpYW4gQmV6ZGVr
YSB3cm90ZToKPj4gT24gU3VuLCAyMDI0LTAxLTIxIGF0IDIxOjAzICswODAwLCBtYXJzX2xpdTIw
MjMgd3JvdGU6Cj4+Pgo+Pj4gVG/CoEZsb3JpYW4KPj4+IFRoaXMgZXJyb3IgaXMgcnVubmluZyB0
aGUgbGF0ZW5jecKgdXRpbGl0ecKgb3V0c2lkZSB0aGUgY29udGFpbmVyLgo+Pj4gSSBpbnN0YWxs
ZWQgdGhlIGNvbnRhaW5lcmQuaW8gcGFja2FnZSB0aHJvdWdoIHRoZSBkcGtnIC1pIGNvbW1hbmQg
77yMdGhlbiBydW5uaW5nIGxhdGVuY3kgdXRpbGl0ecKgIG91dHNpZGUgdGhlIGNvbnRhaW5lciBh
bmQgdGhpcyBlcnJvciB3aWxsIG9jY3VyLgo+Pj4KPj4KPj4gSSB0cmllZCB0byByZXByb2R1Y2Ug
dGhhdCBoZXJlIGluIHRocmVlIGRpZmZlcmVudCBjb21iaW5hdGlvbnM6Cj4+Cj4+IGEpCj4+IC0g
ZG9ja2VyIDIwLjEwLjI0K2Rmc2cxIChkb2NrZXIuaW8gcGFja2FnZSBmcm9tIERlYmlhbiAxMikK
Pj4gLSBYZW5vbWFpIDMuMi40Cj4+IC0gRG92ZXRhaWwvS2VybmVsIDUuMTAuCj4+Cj4+IGIpCj4+
IC0gRG92ZXRhaWwvS2VybmVsIDYuMSBpbnN0ZWFkIG9mIDUuMTAKPj4KPj4gYykKPj4gLSBYZW5v
bWFpIDMuMy1kZXYgKG5leHQgYnJhbmNoKSBpbnN0ZWFkIG9mIHN0YWJsZQo+PiAtIERvdmV0YWls
L0tlcm5lbCA2LjYgaW5zdGVhZCBvZiA2LjEvNS4xMAo+Pgo+PiBhKSBpcyBydW5uaW5nIGZpbmUg
aGVyZQo+PiBiKSBzaG93ZWQgdGhlIHByb2JsZW0KPj4gICAgL3Vzci9saWIveGVub21haS90ZXN0
c3VpdGUvbGF0ZW5jeTogcHRocmVhZF9jcmVhdGUobGF0ZW5jeSk6IE9wZXJhdGlvbiBub3QgcGVy
bWl0dGVkCj4+IGMpIFNhbWUgcmVzdWx0IGFzIGIpCj4+Cj4+IERpc2FibGluZyB0aGUgc3lzdGVt
ZCB1bml0cyBkb2NrZXIsIGRvY2tlci5zb2NrZXQgYW5kIGNvbnRhaW5lcmQKPj4gZm9sbG93ZWQg
YnkgYSByZWJvb3QgInNvbHZlcyIgdGhpcyBwcm9ibGVtLiBJIGhhdmUgbm8gaWRlYSB3aGF0J3Mg
Z29pbmcKPj4gb24sIGJ1dCBJIGd1ZXNzIGl0J3Mgc29tZXRoaW5nIHJlbGF0ZWQgdG8gY2dyb3Vw
cyBvciBhbnkgcmVzb3VyY2UgbGltaXQKPj4gdGhhdCBpcyBjaGFuZ2VkIGJ5IG9uZSBvZiB0aGUg
ZGFlbW9ucyBvbiBzdGFydHVwLgo+Pgo+PiBGdXJ0aGVyIGludmVzdGlnYXRpb25zIG5lY2Vzc2Fy
eSwgdW5jbGVhciBpZiBJIHdpbGwgbG9vayBpbnRvIHRoYXQKPj4gc29vbi4KPgo+SSB2YWd1ZWx5
IHJlY2FsbCBzdWNoIGFuIGlzc3VlLi4uIE9uY2UgeW91IHJ1biBhIGRvY2tlciBydW50aW1lLCB0
aGVyZQo+aXMgYSBwb2xpY3kgY2hhbmdlIGFwcGxpZWQgdGhhdCBldmVuIHByZXZlbnRzIG5vcm1h
bCBjeWNsaWN0ZXN0IHRvIGJlCj5zdGFydGVkIHVuZGVyIHByZWVtcHQtcnQgb3V0c2lkZSBvZiBh
bnkgY29udGFpbmVyLiBJIGRvbid0IHJlY2FsbCB0aGUKPm5lZWRlZCBjaGFuZ2VzIHRvIG1ha2Ug
dGhhdCB3b3JrIGFnYWluIEFUTS4KCj4KSG93IGFib3V0IG5vdyA/IGRvIHlvdSByZWNhbGwgdGhl
IGNoYW5nZXMgb3Igd2hhdCBjYW4gaSBkbyB0byBnZXQgY2xvc2VyIHRvIHRoZSBzb2x1dGlvbi4K
TG9va2luZyBmb3J3YXJkIHRvIHlvdXIgcHJvbXB0CgpSZWdhcmRzCgo+SmFuCg==
