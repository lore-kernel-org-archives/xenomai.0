Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D8176231
	for <xenomai@lists.linux.dev>; Fri, 27 Sep 2024 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727434601; cv=none; b=kVxQ+x8TKLmz6WwGNIPIHMP27UlkuJjxYMp2NYQBbNvFtolK8e8ZihzLkC3Ur3G3clPH4B4Fjzo27ZvMTzZau62WN+fxqJLwNJ8EOb8dHXG2bMeIzq898d8gypRBf77r4T6M92Pj4roLZk9CYE3wDB2vkhfl66nAKfvWfYpDf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727434601; c=relaxed/simple;
	bh=eWAtuVAOHCvVtTpZF7OZlGBcd3qvDfCcudEnSmr8gdI=;
	h=Date:From:To:Subject:Mime-Version:Message-ID:Content-Type; b=V2lMpI6qH6Pe9p7aQljCCdCJpHpohwglL+DQCri6/fYZJKUgeyO4+LcMs7DI2eqezM7sUckiC+q/m/bVuToOFYCVKEP0YmLB+FeIIqCsVq69Zq2W5xhmr2RyqN6HbFKe6nAV2M7/EBqxFlYugYkl6zh1gBFaDGQg6vaMYHr/dhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from Liu(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.ZUZiWVA_1727434586)
          by smtp.aliyun-inc.com;
          Fri, 27 Sep 2024 18:56:27 +0800
Date: Fri, 27 Sep 2024 18:56:27 +0800
From: "liuyang@sinsegye.com.cn" <liuyang@sinsegye.com.cn>
To: xenomai <xenomai@lists.linux.dev>
Subject: f81601 rtcan driver issue
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.301[cn]
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Message-ID: <2024092718562729740211@sinsegye.com.cn>
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: base64

SGkgeGVub21haToKICAgIEkgdXNlIHRoZSB4ZW5vbWFpIDMuMi4zIHdpdGggdGhlIGludGVsIEo2
NDEyIHBsYXRmb3JtLHRoZSBrZXJuZWwgdmVyc2lvbiBpcyA1LjE1LjUxoaMKICAgIHdoZW4gaSBw
b3J0ZWQgdGhlIGY4MTYwMSBjYW4gZHJpdmVyIGludCBSVERNIGZyYW1ld29ya6GjIEkgdXNlIGJs
b3cgY29tbWFuZCB0ZXN0IHRoZSBjYW4uCiAgICAjcnRjYW5jb25maWcgcnRjYW4wIC0tYmF1ZHJh
dGU9NTAwMDAwIHN0YXJ0CiAgICAjcnRjYW5zZW5kIHJ0Y2FuMCAtLXZlcmJvc2UgLS10aW1lb3V0
PTEwIC0taWRlbnRpZmllcj0weDEyMyAweDEgMHgyIDB4MyAweDQgMHg1IDB4NiAweDcgMHg4CiAg
ICB0aGVuIGkgc2VuZCB0aGUgb3NjaWxsb3Njb3BlLCBObyB3YXZlZm9ybS4gYW5kIHRoZSBpbnRl
cnJ1cHQgc3RhdHVzIHJlZ2lzdGVyIEVycm9yIFdhcm5pbmcgSW50ZXJydXB0LCBFcnJvciBQYXNz
aXZlIEludGVycnVwdCBFbmFibGUgYW5kIEJ1cyBFcnJvciBJbnRlcnJ1cHQgRW5hYmxlLgogICAg
dGhlbiBJIGNoYW5nZSB0aGUgcnRjYW5fc2phMTAwMC5jIGNoaXBfaW5pdCBjb2RlLCB0aGlzIGlz
c3VlIGlzIHNvbHZlZC4gQmxvdyBpcyB0aGUgY2hhbmdlZCBjb2RlLgoKICAgIGRpZmYgLS1naXQg
YS9rZXJuZWwvZHJpdmVycy9jYW4vc2phMTAwMC9ydGNhbl9zamExMDAwLmMgYi9rZXJuZWwvZHJp
dmVycy9jYW4vc2phMTAwMC9ydGNhbl9zamExMDAwLmMKICAgIGluZGV4IDA3M2EzNDMyNS4uOTBm
NmIzMDY2IDEwMDY0NAogICAgLS0tIGEva2VybmVsL2RyaXZlcnMvY2FuL3NqYTEwMDAvcnRjYW5f
c2phMTAwMC5jCiAgICArKysgYi9rZXJuZWwvZHJpdmVycy9jYW4vc2phMTAwMC9ydGNhbl9zamEx
MDAwLmMKICAgIEBAIC03MzcsNyArNzM3LDcgQEAgc3RhdGljIHZvaWQgc2phMTAwMF9jaGlwX2Nv
bmZpZyhzdHJ1Y3QgcnRjYW5fZGV2aWNlICpkZXYpCiAgICAgc3RydWN0IHJ0Y2FuX3NqYTEwMDAg
KmNoaXAgPSAoc3RydWN0IHJ0Y2FuX3NqYTEwMDAqIClkZXYtPnByaXY7CgogICAgIGNoaXAtPndy
aXRlX3JlZyhkZXYsIFNKQV9DRFIsIGNoaXAtPmNkcik7CiAtICAgIGNoaXAtPndyaXRlX3JlZyhk
ZXYsIFNKQV9PQ1IsIGNoaXAtPm9jcik7CisgICAgY2hpcC0+d3JpdGVfcmVnKGRldiwgU0pBX09D
UiwgY2hpcC0+b2NyIHwgU0pBX09DUl9NT0RFX05PUk1BTCk7CgogICAgIGNoaXAtPndyaXRlX3Jl
ZyhkZXYsIFNKQV9BTVIwLCAweEZGKTsKICAgICBjaGlwLT53cml0ZV9yZWcoZGV2LCBTSkFfQU1S
MSwgMHhGRik7CgoKCgoKCi0tLS0tLS0tLS0tLS0tCgoKCmxpdXlhbmdAc2luc2VneWUuY29tLmNu
CgoK

