Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFB4208D0
	for <xenomai@lists.linux.dev>; Sat,  4 Jul 2026 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783188323; cv=none; b=LycyQO0nuFNDVlJivQyUpBAHOp+8/07R8V8JK+JkeJ69U2cSzH8uDEHoH+zek8KTAQ/kQux75rjDMFnpKV1s1bUVl+LpC+YaPAdX0vf5g3qYXj85GTgLzXH2w7mOewIFblrat+LW7NGvvB0D6kPPOzHA9GhKe1yxJHblncaz1Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783188323; c=relaxed/simple;
	bh=9dNJiusMB8UJsr/bVtV5IqIUs11jrjgI7aSyAj9JF0U=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=hGVCowkvh94eeC3UvtVMr3hnCKlW3UKEHYDuvIcUIQ/kmExDiFdvgwjFbWXWCh8VDcEKISjSlYpou723aGRWMyAHU5gBmEm1w5vMKIlS4/Ohk0hYKbPu4ZPtQP2r3EeVelw9lDPn062IlE9OUYvSpm8RVHg2f0QoHGi+mNFYMGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvXhlqbZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvXhlqbZ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso1679520f8f.0
        for <xenomai@lists.linux.dev>; Sat, 04 Jul 2026 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783188320; x=1783793120; darn=lists.linux.dev;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dNJiusMB8UJsr/bVtV5IqIUs11jrjgI7aSyAj9JF0U=;
        b=HvXhlqbZhdYEWHkNh3ey67yqh0eFrj8rzgDOlUhvsfejoESmbP18pDLmoreh00wkET
         6Shq7OT2XmBEjxZeKadqUmUv9pLAPJhr5P3txH0huaQaTu6MPSoacQAJ9t6HcgiJt2sp
         bWVtWPAwLT6i2NFceMhpXgQQC5ck2sEytt2PMKk9Zuqp2qrg/h+Y6I3I2TPAFOxcV9/5
         OU0JTJILmzhIbtp/+FRJKvNeDYmb8v5UlZzCx7x0kRqVWsrmuDfmtN29x4X1AiK5uTpI
         lRW3IZzYqxgzGcpfEjHZrAv24Gd4Jov7hQiTshFvf94AZ9nO9XHFYmMI5yrvfbWEhoSp
         Cfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783188320; x=1783793120;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9dNJiusMB8UJsr/bVtV5IqIUs11jrjgI7aSyAj9JF0U=;
        b=Lm8iArpk7Ukcs/UHjSFAgS/mymtG/+8K+9riI2kdQtSmzoJJIvptaS+2SgVqk4NdXL
         kJTl9akQ6brhXTXXW1ZscSBFOrQv0xMs0XWfeq1yaQjNE1VH9qtlCDuNDrFb58s8iSyt
         QoiqeB5h5UBSFW7mgHpnjq5cHoSaiYSDYvbC2z+IrpCVWtG4aBnFhTAqzSrQwe/KbSN/
         9ZT7SOtg/Y/uggRzVIpPvYPEhIcsv35tqEvmLcWP9yKev+yAnomf7wnxhJTzJaUrdADK
         kWaVxmjmBR41zfVa7vCcx8/QqVI2t9i2INiHFq+FL8BfFYKg3rOUPFNzta/3KR+LzJuX
         LZYQ==
X-Gm-Message-State: AOJu0YwtIY4rxSeVJM+S2B5rzTzwyKs5cJzShuCIX0AXAe9RdGj3YNZD
	Uq2MVghYwhiEvlrAzioYfGt2rkBtcoST6LwxgqSGh+KtiM7uETJXvbuClp8Wcw==
X-Gm-Gg: AfdE7cnasWChxXxglcMfqSAGwjhYlMs5MSqpIIlxiqQKkxXqF7PHewKM8RGPPTzxIVR
	tLKcGsrBg8ZYENlXfrhw00SRmVAoivURf8A/wU+MCdinibKb7WG8AqDneR1l8aIduuli9ZvOb9C
	dMCSB1PDgrLXJ5yW3RXcP/MnlGt6JAmgfe248nwkGogzAWUf5f0T90RWVngnqmCLgVU0SYxVbPz
	WbZXXGCluMpXGKHFxy+gAi6bGwTZban05uaRH+q/Os7716Sj8vG6QlG3rHa8DQo3qAiFAGQYGFf
	mSaoXsXgGJTCoONoDj24CQXo1Pbco/XZXxoGOnGXK0Pgr34EVn3QRGVAAq6gIzwP+VDqK1xyah8
	yIVNPWwYq1Q6FzpOfLky0a05OmfoDMIWTYK9BeNQ5LWPdtDz/ue/OY+Ljw/CIpTiAhWwD+IFXCW
	ekcJIrqxRnAnICD8fLYy+D
X-Received: by 2002:a05:6000:4691:b0:475:f0c2:75a3 with SMTP id ffacd0b85a97d-47aace8ea7fmr3167196f8f.52.1783188319712;
        Sat, 04 Jul 2026 11:05:19 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f21543sm9125638f8f.35.2026.07.04.11.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2026 11:05:18 -0700 (PDT)
Message-ID: <c88ccba0-23fd-4f4c-a182-0967e79adefb@gmail.com>
Date: Sat, 4 Jul 2026 20:05:18 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-CH, en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Subject: EVL: Kernel WARNING
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQWZ0ZXIgdXBkYXRpbmcgdG8gdGhlIGxhc3Rlc3QgdjYuMTIueS1jaXAtZXZsLXJl
YmFzZSwgSSBoYXZlIGEga2VybmVsIFdBUk5JTkcgaW4gdGhlIGlnYiBkcml2ZXIgaWYgSSB1
c2UgbXkgb29iLW5ldC1pY21wLmMgKFBhdGNoIHN1Ym1pdHRlZCkNCg0KRXhhY3QgY29tbWl0
cyBnb29kLi4uYmFkOg0KbGludXgtZXZsIGVmZWQ2MTIuLi41NTU5MWQ0DQpsaWJldmwgM2U1
NTc3ZC4uZjdiN2RmNA0KDQpSZWdhcmRzDQpIYW5uZXMNCg0KWzE3MDIyLjU1ODQ4MV0gLS0t
LS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQpbMTcwMjIuNTU4NDgyXSBXQVJO
SU5HOiBDUFU6IDMgUElEOiAxMDQyNSBhdCBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Z2IvaWdiX21haW4uYzo5NTEzIGlnYl9hbGxvY19yeF9idWZmZXJzKzB4ZDMvMHgyMzAgW2ln
Yl0NClsxNzAyMi41NTg0OTddIE1vZHVsZXMgbGlua2VkIGluOiBpcHRfUkVKRUNUIG5mX3Jl
amVjdF9pcHY0IHh0X3RjcHVkcCBuZnRfY29tcGF0IG5mX3RhYmxlcyBsaWJjcmMzMmMgaW50
ZWxfcmFwbF9tc3IgYmluZm10X21pc2MgaW50ZWxfcmFwbF9jb21tb24gc25kX3NvY19hdnMg
eDg2X3BrZ190ZW1wX3RoZXJtYWwgaW50ZWxfcG93ZXJjbGFtcCBjb3JldGVtcCBzbmRfc29j
X2hkYV9jb2RlYyBjcmN0MTBkaWZfcGNsbXVsIGdoYXNoX2NsbXVsbmlfaW50ZWwgc25kX2hk
YV9leHRfY29yZSBubHNfYXNjaWkgc2hhNTEyX3Nzc2UzIG5sc19jcDQzNyB2ZmF0IHNoYTI1
Nl9zc3NlMyBzbmRfc29jX2NvcmUgc2hhMV9zc3NlMyBmYXQgc25kX2hkYV9jb2RlY19yZWFs
dGVrIG1laV9weHAgc25kX2hkYV9jb2RlY19nZW5lcmljIGVlZXBjX3dtaSBzbmRfY29tcHJl
c3Mgc25kX3BjbV9kbWFlbmdpbmUgc25kX2hkYV9zY29kZWNfY29tcG9uZW50IHNuZF9oZGFf
Y29kZWNfaGRtaSBtZWlfaGRjcCBhZXNuaV9pbnRlbCBzbmRfaGRhX2ludGVsIHNuZF9pbnRl
bF9kc3BjZmcgc25kX2ludGVsX3Nkd19hY3BpIGdmMTI4bXVsIHNuZF9oZGFfY29kZWMgY3J5
cHRvX3NpbWQgYXN1c193bWkgY3J5cHRkIHNwYXJzZV9rZXltYXAgcmFwbCBpbnRlbF9jc3Rh
dGUgcGxhdGZvcm1fcHJvZmlsZSBzbmRfaGRhX2NvcmUgZWUxMDA0IGJhdHRlcnkgaW50ZWxf
dW5jb3JlIHNuZF9od2RlcCBzbmRfcGNtIHdtaV9ibW9mIHJma2lsbCBtZWlfbWUgbWVpIHNu
ZF90aW1lciBzbmQgc291bmRjb3JlIGludGVsX3BtY19jb3JlIGludGVsX3ZzZWMgcG10X3Rl
bGVtZXRyeSBwbXRfY2xhc3MgYWNwaV9wYWQgam95ZGV2IGV2ZGV2IHNnIHBhcnBvcnRfcGMg
cHBkZXYgbHAgcGFycG9ydCBlZmlfcHN0b3JlIGNvbmZpZ2ZzIG5mbmV0bGluayBlZml2YXJm
cyBpcF90YWJsZXMgeF90YWJsZXMgYXV0b2ZzNCBleHQ0IGNyYzMyY19nZW5lcmljIG1iY2Fj
aGUgamJkMiBtbHg0X2liIGliX3V2ZXJicyBpYl9jb3JlIG1seDRfZW4gaGlkX211bHRpdG91
Y2ggdWFzDQpbMTcwMjIuNTU4NTMzXSAgdXNiX3N0b3JhZ2UgYW1kZ3B1IGhpZF9nZW5lcmlj
IHNyX21vZCBzZF9tb2QgY2Ryb20gdXNiaGlkIGFtZHhjcCBkcm1fZXhlYyBoaWQgZ3B1X3Nj
aGVkIGRybV9idWRkeSBkcm1fc3ViYWxsb2NfaGVscGVyIGRybV9kaXNwbGF5X2hlbHBlciBj
ZWMgcmNfY29yZSBkcm1fdHRtX2hlbHBlciB0dG0gZHJtX2ttc19oZWxwZXIgYWhjaSBsaWJh
aGNpIGRybSBsaWJhdGEgbWx4NF9jb3JlIGlUQ09fd2R0IGludGVsX3BtY19ieHQgaVRDT192
ZW5kb3Jfc3VwcG9ydCB4aGNpX3BjaSB4aGNpX2hjZCB3YXRjaGRvZyBteG1fd21pIHVzYmNv
cmUgaWdiIHNjc2lfbW9kIGkyY19pODAxIGNyYzMyX3BjbG11bCByODE2OChPRSkgY3JjMzJj
X2ludGVsIGkyY19zbWJ1cyBpMmNfYWxnb19iaXQgZmFuIGRjYSBzY3NpX2NvbW1vbiBjcmMx
NiB1c2JfY29tbW9uIHZpZGVvIHdtaSBidXR0b24NClsxNzAyMi41NTg1NTRdIENQVTogMyBV
SUQ6IDAgUElEOiAxMDQyNSBDb21tOiBlbnAyczBmMC5yeCBUYWludGVkOiBHICAgICAgICAg
ICBPRSAgICAgIDYuMTIuOTAtY2lwMjQteGVub21haTQgIzENClsxNzAyMi41NTg1NTddIFRh
aW50ZWQ6IFtPXT1PT1RfTU9EVUxFLCBbRV09VU5TSUdORURfTU9EVUxFDQpbMTcwMjIuNTU4
NTU4XSBIYXJkd2FyZSBuYW1lOiBTeXN0ZW0gbWFudWZhY3R1cmVyIFN5c3RlbSBQcm9kdWN0
IE5hbWUvSDExME0tQSwgQklPUyAzODA1IDA1LzA3LzIwMTgNClsxNzAyMi41NTg1NTldIElS
USBzdGFnZTogRVZMDQpbMTcwMjIuNTU4NTYwXSBSSVA6IDAwMTA6aWdiX2FsbG9jX3J4X2J1
ZmZlcnMrMHhkMy8weDIzMCBbaWdiXQ0KWzE3MDIyLjU1ODU2OV0gQ29kZTogNzMgMTAgNDgg
OGIgMDMgNDkgOGIgN2UgMTggNDggMDEgYzYgZjYgODcgZmMgMDIgMDAgMDAgMjAgNzUgYmUg
YjkgMDIgMDAgMDAgMDAgNGMgODkgZWEgZTggNTUgMzcgZmYgYzkgOGIgNzMgMTAgNDggMDMg
MzMgZWIgYTkgPDBmPiAwYiA0OSA4MyA4NiBkMCAwMCAwMCAwMCAwMSA2NiA0MSAwMyBhZSA4
MCAwMCAwMCAwMCA2NiA0MSAzOSBhZQ0KWzE3MDIyLjU1ODU3MF0gUlNQOiAwMDE4OmZmZmZj
OTBkMDlhZGZjYjAgRUZMQUdTOiAwMDAxMDI0Ng0KWzE3MDIyLjU1ODU3Ml0gUkFYOiAwMDAw
MDAwMDAwMDAwMDAwIFJCWDogZmZmZmM5MGQwMGZlNTc2OCBSQ1g6IGZmZmY4OGFlMmVkZTJi
MDANClsxNzAyMi41NTg1NzNdIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAw
MDAwMDI4MjAgUkRJOiBmZmZmODhhZDAzNWU1MTEwDQpbMTcwMjIuNTU4NTc0XSBSQlA6IDAw
MDAwMDAwMDAwMGZmNGYgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAw
MDAwMA0KWzE3MDIyLjU1ODU3NV0gUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogZmZmZjg4
YWQxNDRmZTA1MCBSMTI6IGZmZmY4OGFkMWIxMTg0ZjANClsxNzAyMi41NTg1NzZdIFIxMzog
MDAwMDAwMDAwMDAwMDYwMCBSMTQ6IGZmZmY4OGFkMTQ0ZmUyNDAgUjE1OiAwMDAwMDAwMDAw
MDAwMDAxDQpbMTcwMjIuNTU4NTc3XSBGUzogIDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6
ZmZmZjg4YWUyZWQ4MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQpbMTcwMjIu
NTU4NTc5XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUw
MDMzDQpbMTcwMjIuNTU4NTgwXSBDUjI6IDAwMDAwMDAwMDAwMDAwMDAgQ1IzOiAwMDAwMDAw
MTdjNmVjMDAxIENSNDogMDAwMDAwMDAwMDM3MDZmMA0KWzE3MDIyLjU1ODU4MV0gQ2FsbCBU
cmFjZToNClsxNzAyMi41NTg1ODNdICA8VEFTSz4NClsxNzAyMi41NTg1ODVdICBpZ2JfcG9s
bCsweDEwOTYvMHgxNjMwIFtpZ2JdDQpbMTcwMjIuNTU4NTk1XSAgPyBfX3N3aXRjaF90b19h
c20rMHgzNy8weDcwDQpbMTcwMjIuNTU4NTk4XSAgPyBfX3N3aXRjaF90bysweDExMy8weDRi
MA0KWzE3MDIyLjU1ODYwMl0gIF9fbmFwaV9wb2xsKzB4MjgvMHgxNjANClsxNzAyMi41NTg2
MDVdICBuYXBpX3BvbGwrMHgxMjIvMHgxNDANClsxNzAyMi41NTg2MDhdICBldmxfbmV0X2Rv
X3J4KzB4MmRjLzB4NTQwDQpbMTcwMjIuNTU4NjEzXSAgPyBfX3BmeF9rdGhyZWFkX3RyYW1w
b2xpbmUrMHgxMC8weDEwDQpbMTcwMjIuNTU4NjE1XSAga3RocmVhZF90cmFtcG9saW5lKzB4
MTA3LzB4MjEwDQpbMTcwMjIuNTU4NjE4XSAga3RocmVhZCsweGNmLzB4MTAwDQpbMTcwMjIu
NTU4NjIwXSAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMA0KWzE3MDIyLjU1ODYyM10gIHJl
dF9mcm9tX2ZvcmsrMHgzMS8weDUwDQpbMTcwMjIuNTU4NjI1XSAgPyBfX3BmeF9rdGhyZWFk
KzB4MTAvMHgxMA0KWzE3MDIyLjU1ODYyNl0gIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgz
MA0KWzE3MDIyLjU1ODYzMV0gIDwvVEFTSz4NClsxNzAyMi41NTg2MzFdIC0tLVsgZW5kIHRy
YWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0K
