Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D380F37D12E
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424600; cv=none; b=UdSoOT83lV2VQu+PLm839tVkL3olrDx+sYZNZw8V3agnWmNfyMBAOQS1PUh7OpumlFNNGBXykXCX8P9rumyqONQDTm+kXdezrB/BB/nR3zWvXUJrJHRTmzwNGLJ3I1EOCkYWW1DETtc6NoBIAgw8R41lTH7Fdjo9qarImMxo6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424600; c=relaxed/simple;
	bh=bVodHhlc5baoKQCLNui3kE93BXGZMLMmydu85O+2ekY=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=QnCUPixuaHPl286ze8+90Pv28AvesMNfyjHvyhYElXFED0MTG/z4hP6qLCKBrKojvozTSr8+TGXcUH9zIOLAnxndWJj+KJjn1rgrD1efSv4HgtigtclxqqpBAEEHsrK6i8MemHq/3qBk/Hb88yXUnFGzKTZ4A5OYKIiywHvryLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVskrgqO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVskrgqO"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so3411905e9.1
        for <xenomai@lists.linux.dev>; Tue, 07 Jul 2026 04:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783424597; x=1784029397; darn=lists.linux.dev;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVodHhlc5baoKQCLNui3kE93BXGZMLMmydu85O+2ekY=;
        b=NVskrgqOMLJxCN1AiNdk05GetSj07QJWekQjCgF15UCyHeVK/IvlJbUZo57RN1H2ii
         OyBmp9vl3pi/e3zn3xa0LMY1x58m25J4763pgS0VJlDiVSCK9DHSNXCNpKcXNfkg3POv
         uZQ/tViLAJAMLJNx3h7s7oRDRs8HEtCYLvVkAoRPWQTwcM5CA6pnQ+N0dIpGbLsKbnpZ
         qnEYlRSDW2kyS+oCYdavxITiy1uIc6iNVLPc4uMcg+sj3aXE62kktGxLrnXC5MrFXzWb
         srpFUcWiMi0ZaAFaP9cHxijcFpFa3sP64sX/eRx8sGKOOPe1F59VUxTZBXNKyMi5ylIJ
         +n6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783424597; x=1784029397;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVodHhlc5baoKQCLNui3kE93BXGZMLMmydu85O+2ekY=;
        b=sAArSicSL/faa87seXxl2T/rlwuQ6cOwpnmWsnIH2hTLct/Wd3FbGYq/rXdahS9Qwd
         G3D8zEYBSDA/PCBT4e0Gsn25mnk6myNeygsWkGeChK7mQusV6ljfoF9dOv0u9jz2rgbc
         rJb4EHpZ2nX5HO+qLHyc/7wOOzu6URaZat8qUJJJLs8yyQwwFIu56Hu5kaESN4W7xlw2
         RpMXLYuFiaAeA4KSJV4shs5QdhI6G8LzB0gJP7JGplAKFnzH55eAPoDFPmtF/xZ65XuO
         xf436dzUFqxRRgRSV6QdAQiX+SKFcndS4qhztqkT6bKU8sfX6FaIvWs4if+PR76HGZSt
         qbRQ==
X-Gm-Message-State: AOJu0Ywq6lcXI8rCqMhGHHCZR8PRe6/D8Wx5P9u5fRR4uLf1LMdxaPs9
	AWV2GKCVDW/lP0bmSFyJ4EX86etSiauGbMvCN8y8M4ABQW4n4N3/av2eBlos1wdF
X-Gm-Gg: AfdE7ckO+4qlT/2v4W6ppjTLyWIEgl4+QJRX+W64Ow90P+AC+Prnrh9uG/k/g6CLbOr
	IANoeQqtXDXu/uKFE9Q3Ara69u3c5kT1t3QCZA/O/+Geq+6Z4Zkx+fehxDi1+ktEHAuMxd7qPt/
	Teen3KvpRrn1bi7Ou/b5m1ypnJTclSfwVEfRx4P0t/d+a1jy3Pxtgx9fEthvEQwjrTp4RzsKA4Y
	rirnRD/d9+YI/eHwxTw8EapBYkx6DhA45kHs5frnn4ve67fsifJbvf3mwbaRl84vIDQg/ovrCw6
	GM8oASyZ3nIDj0q8p6S3u7Xmfa9fgsFqNcHROMd4mi763mWlbZs/BRyho/Hq7Vw1LKQ4uTqm+rb
	4fVnF1x4UaUDxou/Ga+0MR4Pr7PtmxVdREot+Q2IMT12bT81p74cxZd/vTDUZOWYz3uDlWVFOp9
	2uR8AIOFJlJ4SHVxPjz/2aZ5oNlEN8lNw=
X-Received: by 2002:a05:600c:6d42:b0:493:a63b:1f62 with SMTP id 5b1f17b1804b1-493e1044096mr21130995e9.16.1783424597236;
        Tue, 07 Jul 2026 04:43:17 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae44sm32225862f8f.23.2026.07.07.04.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 04:43:16 -0700 (PDT)
Message-ID: <2a2e5b00-ef70-4de5-865b-c8d00c87104b@gmail.com>
Date: Tue, 7 Jul 2026 13:43:15 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hannes Diethelm <hannes.diethelm@gmail.com>
Content-Language: de-CH, en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Subject: EVL: hectic test fails when to many CPUs are available
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8NCg0KVGhpcyBpcyB0aGUgcmVhc29uIGZvciB0aGUgcGF0Y2ggZm9yIGV2bC10ZXN0
LiBJIGd1ZXNzIGEgYmVnaW5uZXJzIG1pc3Rha2UgLyBlZGdlIGNhc2UgYnV0DQppZiB5b3Ug
d2FudCB0byBsb29rIGludG8gaXQ6DQoNCklmIEkgZG9uJ3Qgc2V0IGV2bC5vb2JjcHVzIGlu
IG15IFZNIG9yIGp1c3QgdXNlIHRvIG1hbnkgT09CIENQVXMsIHRoZSBoZWN0aWMgdGVzdCBj
cmFzaGVzIGFuZA0KbmV2ZXIgZXhpdHMuIEkgaGF2ZSB0byB1c2Uga2lsbCAtOSB0byBzdG9w
IGl0Lg0KDQpldmxfYXR0YWNoKCk6IFJlc291cmNlIHRlbXBvcmFyaWx5IHVuYXZhaWxhYmxl
OiBUaGlzIGlzIHByb2JhYmx5IG5vdCBoYW5kbGVkIGNvcnJlY3RseS4NCg0KZXZsLm9vYmNw
dXM9MC0xNSAtPiBGcmVlemUNCmV2bC5vb2JjcHVzPTEtMTUgLT4gRnJlZXplDQpldmwub29i
Y3B1cz0yLTE1IC0+IE9rDQoNCi91c3IvbGliZXhlYy9ldmwvdGVzdHMvaGVjdGljIC1UIDUN
Cg0KPT0gVGVzdGluZyBGUFUgY2hlY2sgcm91dGluZXMuLi4NCj09IEZQVSBjaGVjayByb3V0
aW5lczogT0suDQo9PSBUaHJlYWRzOiBzd2l0Y2hlcl91ZnBzMC0wIHJ0azAtMSBydGswLTIg
cnR1cDAtMyBydHVwMC00IHJ0dXBfdWZwcDAtNSBydHVwX3VmcHAwLTYgcnR1czAtNyBydHVz
MC04IHJ0dXNfdWZwczAtOSBydHVzX3VmcHMwLTEwIHJ0dW8wLTExIHJ0dW8wLTEyIHJ0dW9f
dWZwcDAtMTMgcnR1b191ZnBwMC0xNCBydHVvX3VmcHMwLTE1IHJ0dW9fdWZwczAtMTYgcnR1
b191ZnBwX3VmcHMwLTE3IHJ0dW9fdWZwcF91ZnBzMC0xOCBmcHVfc3RyZXNzX3VmcHMwLTE5
IHN3aXRjaGVyX3VmcHMxLTAgcnRrMS0xIHJ0azEtMiBydHVwMS0zIHJ0dXAxLTQgcnR1cF91
ZnBwMS01IHJ0dXBfdWZwcDEtNiBydHVzMS03IHJ0dXMxLTggcnR1c191ZnBzMS05IHJ0dXNf
dWZwczEtMTAgcnR1bzEtMTEgcnR1bzEtMTIgcnR1b191ZnBwMS0xMyBydHVvX3VmcHAxLTE0
IHJ0dW9fdWZwczEtMTUgcnR1b191ZnBzMS0xNiBydHVvX3VmcHBfdWZwczEtMTcgcnR1b191
ZnBwX3VmcHMxLTE4IGZwdV9zdHJlc3NfdWZwczEtMTkgc3dpdGNoZXJfdWZwczItMCBydGsy
LTEgcnRrMi0yIHJ0dXAyLTMgcnR1cDItNCBydHVwX3VmcHAyLTUgcnR1cF91ZnBwMi02IHJ0
dXMyLTcgcnR1czItOCBydHVzX3VmcHMyLTkgcnR1c191ZnBzMi0xMCBydHVvMi0xMSBydHVv
Mi0xMiBydHVvX3VmcHAyLTEzIHJ0dW9fdWZwcDItMTQgcnR1b191ZnBzMi0xNSBydHVvX3Vm
cHMyLTE2IHJ0dW9fdWZwcF91ZnBzMi0xNyBydHVvX3VmcHBfdWZwczItMTggZnB1X3N0cmVz
c191ZnBzMi0xOSBzd2l0Y2hlcl91ZnBzMy0wIHJ0azMtMSBydGszLTIgcnR1cDMtMyBydHVw
My00IHJ0dXBfdWZwcDMtNSBydHVwX3VmcHAzLTYgcnR1czMtNyBydHVzMy04IHJ0dXNfdWZw
czMtOSBydHVzX3VmcHMzLTEwIHJ0dW8zLTExIHJ0dW8zLTEyIHJ0dW9fdWZwcDMtMTMgcnR1
b191ZnBwMy0xNCBydHVvX3VmcHMzLTE1IHJ0dW9fdWZwczMtMTYgcnR1b191ZnBwX3VmcHMz
LTE3IHJ0dW9fdWZwcF91ZnBzMy0xOCBmcHVfc3RyZXNzX3VmcHMzLTE5IHN3aXRjaGVyX3Vm
cHM0LTAgcnRrNC0xIHJ0azQtMiBydHVwNC0zIHJ0dXA0LTQgcnR1cF91ZnBwNC01IHJ0dXBf
dWZwcDQtNiBydHVzNC03IHJ0dXM0LTggcnR1c191ZnBzNC05IHJ0dXNfdWZwczQtMTAgcnR1
bzQtMTEgcnR1bzQtMTIgcnR1b191ZnBwNC0xMyBydHVvX3VmcHA0LTE0IHJ0dW9fdWZwczQt
MTUgcnR1b191ZnBzNC0xNiBydHVvX3VmcHBfdWZwczQtMTcgcnR1b191ZnBwX3VmcHM0LTE4
IGZwdV9zdHJlc3NfdWZwczQtMTkgc3dpdGNoZXJfdWZwczUtMCBydGs1LTEgcnRrNS0yIHJ0
dXA1LTMgcnR1cDUtNCBydHVwX3VmcHA1LTUgcnR1cF91ZnBwNS02IHJ0dXM1LTcgcnR1czUt
OCBydHVzX3VmcHM1LTkgcnR1c191ZnBzNS0xMCBydHVvNS0xMSBydHVvNS0xMiBydHVvX3Vm
cHA1LTEzIHJ0dW9fdWZwcDUtMTQgcnR1b191ZnBzNS0xNSBydHVvX3VmcHM1LTE2IHJ0dW9f
dWZwcF91ZnBzNS0xNyBydHVvX3VmcHBfdWZwczUtMTggZnB1X3N0cmVzc191ZnBzNS0xOSBz
d2l0Y2hlcl91ZnBzNi0wIHJ0azYtMSBydGs2LTIgcnR1cDYtMyBydHVwNi00IHJ0dXBfdWZw
cDYtNSBydHVwX3VmcHA2LTYgcnR1czYtNyBydHVzNi04IHJ0dXNfdWZwczYtOSBydHVzX3Vm
cHM2LTEwIHJ0dW82LTExIHJ0dW82LTEyIHJ0dW9fdWZwcDYtMTMgcnR1b191ZnBwNi0xNCBy
dHVvX3VmcHM2LTE1IHJ0dW9fdWZwczYtMTYgcnR1b191ZnBwX3VmcHM2LTE3IHJ0dW9fdWZw
cF91ZnBzNi0xOCBmcHVfc3RyZXNzX3VmcHM2LTE5IHN3aXRjaGVyX3VmcHM3LTAgcnRrNy0x
IHJ0azctMiBydHVwNy0zIHJ0dXA3LTQgcnR1cF91ZnBwNy01IHJ0dXBfdWZwcDctNiBydHVz
Ny03IHJ0dXM3LTggcnR1c191ZnBzNy05IHJ0dXNfdWZwczctMTAgcnR1bzctMTEgcnR1bzct
MTIgcnR1b191ZnBwNy0xMyBydHVvX3VmcHA3LTE0IHJ0dW9fdWZwczctMTUgcnR1b191ZnBz
Ny0xNiBydHVvX3VmcHBfdWZwczctMTcgcnR1b191ZnBwX3VmcHM3LTE4IGZwdV9zdHJlc3Nf
dWZwczctMTkgc3dpdGNoZXJfdWZwczgtMCBydGs4LTEgcnRrOC0yIHJ0dXA4LTMgcnR1cDgt
NCBydHVwX3VmcHA4LTUgcnR1cF91ZnBwOC02IHJ0dXM4LTcgcnR1czgtOCBydHVzX3VmcHM4
LTkgcnR1c191ZnBzOC0xMCBydHVvOC0xMSBydHVvOC0xMiBydHVvX3VmcHA4LTEzIHJ0dW9f
dWZwcDgtMTQgcnR1b191ZnBzOC0xNSBydHVvX3VmcHM4LTE2IHJ0dW9fdWZwcF91ZnBzOC0x
NyBydHVvX3VmcHBfdWZwczgtMTggZnB1X3N0cmVzc191ZnBzOC0xOSBzd2l0Y2hlcl91ZnBz
OS0wIHJ0azktMSBydGs5LTIgcnR1cDktMyBydHVwOS00IHJ0dXBfdWZwcDktNSBydHVwX3Vm
cHA5LTYgcnR1czktNyBydHVzOS04IHJ0dXNfdWZwczktOSBydHVzX3VmcHM5LTEwIHJ0dW85
LTExIHJ0dW85LTEyIHJ0dW9fdWZwcDktMTMgcnR1b191ZnBwOS0xNCBydHVvX3VmcHM5LTE1
IHJ0dW9fdWZwczktMTYgcnR1b191ZnBwX3VmcHM5LTE3IHJ0dW9fdWZwcF91ZnBzOS0xOCBm
cHVfc3RyZXNzX3VmcHM5LTE5IHN3aXRjaGVyX3VmcHMxMC0wIHJ0azEwLTEgcnRrMTAtMiBy
dHVwMTAtMyBydHVwMTAtNCBydHVwX3VmcHAxMC01IHJ0dXBfdWZwcDEwLTYgcnR1czEwLTcg
cnR1czEwLTggcnR1c191ZnBzMTAtOSBydHVzX3VmcHMxMC0xMCBydHVvMTAtMTEgcnR1bzEw
LTEyIHJ0dW9fdWZwcDEwLTEzIHJ0dW9fdWZwcDEwLTE0IHJ0dW9fdWZwczEwLTE1IHJ0dW9f
dWZwczEwLTE2IHJ0dW9fdWZwcF91ZnBzMTAtMTcgcnR1b191ZnBwX3VmcHMxMC0xOCBmcHVf
c3RyZXNzX3VmcHMxMC0xOSBzd2l0Y2hlcl91ZnBzMTEtMCBydGsxMS0xIHJ0azExLTIgcnR1
cDExLTMgcnR1cDExLTQgcnR1cF91ZnBwMTEtNSBydHVwX3VmcHAxMS02IHJ0dXMxMS03IHJ0
dXMxMS04IHJ0dXNfdWZwczExLTkgcnR1c191ZnBzMTEtMTAgcnR1bzExLTExIHJ0dW8xMS0x
MiBydHVvX3VmcHAxMS0xMyBydHVvX3VmcHAxMS0xNCBydHVvX3VmcHMxMS0xNSBydHVvX3Vm
cHMxMS0xNiBydHVvX3VmcHBfdWZwczExLTE3IHJ0dW9fdWZwcF91ZnBzMTEtMTggZnB1X3N0
cmVzc191ZnBzMTEtMTkgc3dpdGNoZXJfdWZwczEyLTAgcnRrMTItMSBydGsxMi0yIHJ0dXAx
Mi0zIHJldmxfYXR0YWNoKCk6IFJlc291cmNlIHRlbXBvcmFyaWx5IHVuYXZhaWxhYmxlDQoN
ClJlZ2FyZHMNCkhhbm5lcw0K
