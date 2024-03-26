Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D9012B82
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444430; cv=none; b=qyc6FAA4N3PeSV3qFb20n2/FnNwzHX0/kU4ecrMIv8Kedi1xY9/oesyYPBC67STuRKhAGMkcTKxp1gW5zlCUKidUleBOC60M1mIlh5PDpqqrjUId17M+qDpeXNz7AvynlCBaz/eDJhSScCKT/55uU6T4kUEwvNpZHKdSMauawp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444430; c=relaxed/simple;
	bh=CkwxptNIFwpp4Ci8Ms8f5pNSzD3x47Qmh9e5HUtIgiA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R09bJc1f0Wiko7YATpV/Qt2RzeD6zXyKMmUhgEfmc/KNo2upli7eGMySm8YDf+BSIvMkTZ8kEVw0+VQrUtI8c6f6TzkXFKG8Y5TSavCMbcNEh3QIuvQd1GQuxpLnGADRaOHi7nXxWjn9CdYJePeOQwiJRZREX5nCz89PNK1CEwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgD5X+sV; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgD5X+sV"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e782e955adso4525951b3a.3
        for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 02:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711444427; x=1712049227; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CkwxptNIFwpp4Ci8Ms8f5pNSzD3x47Qmh9e5HUtIgiA=;
        b=CgD5X+sVxwFhsm71T8JIzHnxmmjnYlGUXjY+cUH4/veuUPbtmcx91jG11Rozn4wqVH
         SQmpnKw0yTFERRR6b6f2ng6V+RkCliZqO/zCqrERlo7Zl9B7TAb9mX8v79fu4OTwOzzA
         VSGx3e6dZD7k0iEffaNqjtTav9+IgOpqy5/BpgaT4zxAx0uvgb7x2ihQBstpAzio24Yq
         XnqKpw87y+EK5T78gkzeyDUFQQMwXX0bcA2epIyL1qqVyBbl4QEeuTGmm+HF+cgwNOXf
         N4hHfNwNBwW/72Bu0cJU9gsFmTMksWwTMUeelme8eFot9Vi7j8DG4D5j64eEHVMFAME4
         sx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711444427; x=1712049227;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CkwxptNIFwpp4Ci8Ms8f5pNSzD3x47Qmh9e5HUtIgiA=;
        b=gKAkyJdjCfa715Bgu13xUrQMUhPUR+06KlQDCfi3GfCkhvOibu0pmD7UUGS/E+DmaU
         7DSGcuoDA5l07OU53QtiixMrCn3bu1B/QYqe3pUYUzJxkpMUmvY4HnhoH2p08Ma58JTR
         EdAxqkS4e6JfnlqoW2bWLwzqpOvzrl1z+XEcfR6egaXfvRVoQ1ejb/uGUA178doy2c1B
         YwVwZ9BtXzCxw4+4nVt2+HSBgSK+fHEkiSIHib+k3Hwujx5n2wwxMWZG2FUAvTjxkSl4
         5v/aKZaUi9l+p3tUJBhZ+2vWbBTgNebeFhWj5FS4fJ+PNo440FZyjg7fQJNWYTm83QKV
         EUtQ==
X-Gm-Message-State: AOJu0YzA828T7felnkw6EEAgyBTdYFe/ki13P5CN+xnVwQLOPNczw0OZ
	J/NpmlJq01eVvEdgntmDi1EmYZqtbBq/s13H8cffKq1pqhWngsw4MM2+gReH4u2HIw==
X-Google-Smtp-Source: AGHT+IESc2Q5RY51nhJPVMRCi60GlGu0QAUTF3iYb5IuEZJ32CM45cc9jaldtdqduoMo9HjZqRDi6w==
X-Received: by 2002:a05:6a20:d49a:b0:1a3:1972:450e with SMTP id im26-20020a056a20d49a00b001a31972450emr665953pzb.50.1711444426992;
        Tue, 26 Mar 2024 02:13:46 -0700 (PDT)
Received: from TYZPR04MB6425.apcprd04.prod.outlook.com ([2603:1046:c09:198f::5])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b001dc05535632sm6390703pla.170.2024.03.26.02.13.45
        for <xenomai@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 02:13:46 -0700 (PDT)
From: Sam Chiu <ruiqurm@gmail.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject:  Issue with std::mutex when porting POSIX program to Xenomai 3
Thread-Topic:  Issue with std::mutex when porting POSIX program to Xenomai 3
Thread-Index: AQHaf13iQgHYOIIxfUSpkjGBcU538Q==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 26 Mar 2024 09:13:44 +0000
Message-ID:
	<TYZPR04MB642556FC09A8013E8B51B9FDAA352@TYZPR04MB6425.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

RGVhciBYZW5vbWFpIENvbW11bml0eSwKCkkgYW0gaW4gdGhlIHByb2Nlc3Mgb2YgcG9ydGluZyBh
IFBPU0lYIHByb2dyYW0oc3JzUkFOKSB0byBYZW5vbWFpIGFuZCBlbmNvdW50ZXJlZCBhbiBpc3N1
ZSByZWxhdGVkIHRvIHN0ZDo6bXV0ZXjCoHdoZW4gY29tcGlsaW5nIHRoZSBwcm9qZWN0IHdpdGgg
dGhlIGZvbGxvd2luZyBjb21tYW5kOgoKYGBgCmNtYWtlIC4uLyAtRENNQUtFX0JVSUxEX1RZUEU9
RGVidWcgLURDTUFLRV9DX0ZMQUdTPSItSS91c3IveGVub21haS9pbmNsdWRlL2NvYmFsdCAtSS91
c3IveGVub21haS9pbmNsdWRlIC1EX0dOVV9TT1VSQ0UgLURfUkVFTlRSQU5UIC1mYXN5bmNocm9u
b3VzLXVud2luZC10YWJsZXMgLURfX0NPQkFMVF9fIC1EX19DT0JBTFRfV1JBUF9fIiAtRENNQUtF
X0VYRV9MSU5LRVJfRkxBR1M9Ii1XbCwtLW5vLWFzLW5lZWRlZCAtV2wsQC91c3IveGVub21haS9s
aWIvY29iYWx0LndyYXBwZXJzIC1XbCxAL3Vzci94ZW5vbWFpL2xpYi9tb2RlY2hrLndyYXBwZXJz
IMKgL3Vzci94ZW5vbWFpL2xpYi94ZW5vbWFpL2Jvb3RzdHJhcC5vIC1XbCwtLXdyYXA9bWFpbiAt
V2wsLS1keW5hbWljLWxpc3Q9L3Vzci94ZW5vbWFpL2xpYi9keW5saXN0LmxkIC1ML3Vzci94ZW5v
bWFpL2xpYiAtbGNvYmFsdCAtbG1vZGVjaGsgLXB0aHJlYWQgLWxydCIKYGBgCgpVcG9uIHJ1bm5p
bmcgdGhlIHRlc3QgcHJvZ3JhbSwgaXQgY3Jhc2hlZCwgZGlzcGxheWluZyB0aGUgZm9sbG93aW5n
IGVycm9yIG1lc3NhZ2U6CgpgYGAKdGVybWluYXRlIGNhbGxlZCBhZnRlciB0aHJvd2luZyBhbiBp
bnN0YW5jZSBvZiAnc3RkOjpzeXN0ZW1fZXJyb3InCsKgIHdoYXQoKTogwqBPcGVyYXRpb24gbm90
IHBlcm1pdHRlZApgYGAKClRvIGRpYWdub3NlIHRoZSBpc3N1ZSwgSSByZWNvbXBpbGVkIHRoZSBw
cm9ncmFtIHdpdGggZGVidWcgc3ltYm9scyBhbmQgb2JzZXJ2ZWQgdGhlIHByb2JsZW0gbWlnaHQg
YmUgcmVsYXRlZCB0byB0aGUgdXNlIG9mIHN0ZDo6bXV0ZXguwqAKCkEgYmFja3RyYWNlIGNhcHR1
cmVkIGFmdGVyIHRoZSBjcmFzaCBpbmRpY2F0ZXMgYSBmYWlsdXJlIHdpdGhpbiB0aGUgbXV0ZXgg
b3BlcmF0aW9uczoKCmBgYAojMCDCoF9fcHRocmVhZF9raWxsX2ltcGxlbWVudGF0aW9uICh0aHJl
YWRpZD0yODE0NzQ4NDI0MTUxNjgsIHNpZ25vPXNpZ25vQGVudHJ5PTYsIG5vX3RpZD1ub190aWRA
ZW50cnk9MCkKwqAgwqAgYXQgLi9ucHRsL3B0aHJlYWRfa2lsbC5jOjQ0CiMxIMKgMHgwMDAwZmZm
ZmY3YTkwYTI0IGluIF9fcHRocmVhZF9raWxsX2ludGVybmFsIChzaWdubz02LCB0aHJlYWRpZD08
b3B0aW1pemVkIG91dD4pIGF0IC4vbnB0bC9wdGhyZWFkX2tpbGwuYzo3OAojMiDCoDB4MDAwMGZm
ZmZmN2E0YTc2YyBpbiBfX0dJX3JhaXNlIChzaWc9c2lnQGVudHJ5PTYpIGF0IC4uL3N5c2RlcHMv
cG9zaXgvcmFpc2UuYzoyNgojMyDCoDB4MDAwMGZmZmZmN2EzNzRiYyBpbiBfX0dJX2Fib3J0ICgp
IGF0IC4vc3RkbGliL2Fib3J0LmM6NzkKIzQgwqAweDAwMDBmZmZmZjdkNDQ5YzggaW4gX19nbnVf
Y3h4OjpfX3ZlcmJvc2VfdGVybWluYXRlX2hhbmRsZXIoKSAoKSBmcm9tIC9saWIvYWFyY2g2NC1s
aW51eC1nbnUvbGlic3RkYysrLnNvLjYKIzUgwqAweDAwMDBmZmZmZjdkNDIzYmMgaW4gPz8gKCkg
ZnJvbSAvbGliL2FhcmNoNjQtbGludXgtZ251L2xpYnN0ZGMrKy5zby42CiM2IMKgMHgwMDAwZmZm
ZmY3ZDQxMmI0IGluID8/ICgpIGZyb20gL2xpYi9hYXJjaDY0LWxpbnV4LWdudS9saWJzdGRjKysu
c28uNgojNyDCoDB4MDAwMGZmZmZmN2Q0MWFiOCBpbiBfX2d4eF9wZXJzb25hbGl0eV92MCAoKSBm
cm9tIC9saWIvYWFyY2g2NC1saW51eC1nbnUvbGlic3RkYysrLnNvLjYKIzggwqAweDAwMDBmZmZm
ZjdiY2U0N2MgaW4gPz8gKCkgZnJvbSAvbGliL2FhcmNoNjQtbGludXgtZ251L2xpYmdjY19zLnNv
LjEKIzkgwqAweDAwMDBmZmZmZjdiY2U4NzQgaW4gX1Vud2luZF9SYWlzZUV4Y2VwdGlvbiAoKSBm
cm9tIC9saWIvYWFyY2g2NC1saW51eC1nbnUvbGliZ2NjX3Muc28uMQojMTAgMHgwMDAwZmZmZmY3
ZDQyNmY4IGluIF9fY3hhX3Rocm93ICgpIGZyb20gL2xpYi9hYXJjaDY0LWxpbnV4LWdudS9saWJz
dGRjKysuc28uNgojMTEgMHgwMDAwZmZmZmY3ZDNlMzY0IGluIHN0ZDo6X190aHJvd19zeXN0ZW1f
ZXJyb3IoaW50KSAoKSBmcm9tIC9saWIvYWFyY2g2NC1saW51eC1nbnUvbGlic3RkYysrLnNvLjYK
IzEyIDB4MDAwMGFhYWFhYWI0MDMyMCBpbiBzdGQ6Om11dGV4Ojpsb2NrICh0aGlzPTB4ZmZmZmZm
ZmZlYjU4KSBhdCAvdXNyL2luY2x1ZGUvYysrLzEyL2JpdHMvc3RkX211dGV4Lmg6MTA0CiMxMyAw
eDAwMDBhYWFhYWFiNWIyYjggaW4gc3RkOjp1bmlxdWVfbG9jazxzdGQ6Om11dGV4Pjo6bG9jayAo
dGhpcz0weGZmZmZmZmZjNWMxMCkKwqAgwqAgYXQgL3Vzci9pbmNsdWRlL2MrKy8xMi9iaXRzL3Vu
aXF1ZV9sb2NrLmg6MTM5CiMxNCAweDAwMDBhYWFhYWFiNGRlMmMgaW4gc3RkOjp1bmlxdWVfbG9j
azxzdGQ6Om11dGV4Pjo6dW5pcXVlX2xvY2sgKHRoaXM9MHhmZmZmZmZmYzVjMTAsIF9fbT0uLi4p
CsKgIMKgIGF0IC91c3IvaW5jbHVkZS9jKysvMTIvYml0cy91bmlxdWVfbG9jay5oOjY5CiMxNSAw
eDAwMDBhYWFhYWI1ZGNlYjQgaW4gc3JzcmFuOjpkZXRhaWw6OnF1ZXVlX2ltcGw8c3JzcmFuOjp1
bmlxdWVfZnVuY3Rpb248dm9pZCAoKSwgNjR1bCwgZmFsc2U+LCAoc3JzcmFuOjpjb25jdXJyZW50
X3F1ZXVlX3BvbGljeSkzLCAoc3JzcmFuOjpjb25jdXJyZW50X3F1ZXVlX3dhaXRfcG9saWN5KTA+
Ojp0cnlfcHVzaDxzcnNyYW46OnVuaXF1ZV9mdW5jdGlvbjx2b2lkICgpLCA2NHVsLCBmYWxzZT4g
PihzcnNyYW46OnVuaXF1ZV9mdW5jdGlvbjx2b2lkICgpLCA2NHVsLCBmYWxzZT4mJikgKHRoaXM9
MHhmZmZmZmZmZmViMDAsIGVsZW09Li4uKQpgYGAKCkFmdGVyIHJlYWRpbmcgdGhlIHRpcHMgZm9y
IHBvcnRpbmcgUE9TSVggcHJvZ3JhbXMgdG8gWGVub21haSBvbiB0aGUgb2ZmaWNpYWwgd2Vic2l0
ZSwgSSBsZWFybmVkIHRoYXQgbXV0ZXhlcyBzaG91bGQgYmUgZHluYW1pY2FsbHkgaW5pdGlhbGl6
ZWQuwqAKCkl0IHNlZW1zIHRoZSBDKysgc3RkOjptdXRleMKgaXMgYmVpbmcgaW5pdGlhbGl6ZWQg
c3RhdGljYWxseS7CoENoZWNraW5nIHRoZSBHTlUgbGlicmFyeSwgdGhlIGRlZmF1bHQgaW5pdGlh
bGl6YXRpb24gZm9yIGxvY2tzIHNlZW1zIHRvIGJlIHN0YXRpYy7CoApgYGAKI2lmZGVmIF9HTElC
Q1hYX0hBU19HVEhSRUFEUwrCoCAvLy8gQGNvbmQgdW5kb2N1bWVudGVkCsKgIC8vIENvbW1vbiBi
YXNlIGNsYXNzIGZvciBzdGQ6Om11dGV4IGFuZCBzdGQ6OnRpbWVkX211dGV4CsKgIGNsYXNzIF9f
bXV0ZXhfYmFzZQrCoCB7CsKgIHByb3RlY3RlZDoKwqAgwqAgdHlwZWRlZiBfX2d0aHJlYWRfbXV0
ZXhfdOKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgl9fbmF0aXZlX3R5cGU7
CiNpZmRlZiBfX0dUSFJFQURfTVVURVhfSU5JVArCoCDCoCBfX25hdGl2ZV90eXBlIMKgX01fbXV0
ZXggPSBfX0dUSFJFQURfTVVURVhfSU5JVDsKwqAgwqAgY29uc3RleHByIF9fbXV0ZXhfYmFzZSgp
IG5vZXhjZXB0ID0gZGVmYXVsdDsKI2Vsc2UKwqAgwqAgX19uYXRpdmVfdHlwZSDCoF9NX211dGV4
OwrCoCDCoCBfX211dGV4X2Jhc2UoKSBub2V4Y2VwdArCoCDCoCB7CsKgIMKgIMKgIC8vIFhYWCBF
QUdBSU4sIEVOT01FTSwgRVBFUk0sIEVCVVNZKG1heSksIEVJTlZBTChtYXkpCsKgIMKgIMKgIF9f
R1RIUkVBRF9NVVRFWF9JTklUX0ZVTkNUSU9OKCZfTV9tdXRleCk7CsKgIMKgIH0KwqAgwqAgfl9f
bXV0ZXhfYmFzZSgpIG5vZXhjZXB0IHsgX19ndGhyZWFkX211dGV4X2Rlc3Ryb3koJl9NX211dGV4
KTsgfQojZW5kaWYKYGBgCkFuZCB0aGUgbWFjcm8gb2YgYF9fR1RIUkVBRF9NVVRFWF9JTklUYCBp
cyBkZWZpbmVkIGFzIGAjZGVmaW5lIF9fR1RIUkVBRF9NVVRFWF9JTklUIFBUSFJFQURfTVVURVhf
SU5JVElBTElaRVJgLgoKU28gbWF5YmUgSSBzaG91bGQgY29uc2lkZXIgcmVwbGFjaW5nIHN0ZDo6
bXV0ZXjCoHdpdGggcHRocmVhZF9tdXRleC7CoCBIb3dldmVyLCBiZWZvcmUgcHJvY2VlZGluZywg
SSB3b3VsZCBsaWtlIHRvIGlucXVpcmUgaWYgdGhlcmUgYXJlIGJldHRlcgrCoGFwcHJvYWNoZXMg
b3Igc29sdXRpb25zIGZvciBwb3J0aW5nIFBPU0lYIEMrKyBwcm9ncmFtcyB0aGF0IHV0aWxpemUg
c3RkOjptdXRleC4KClNvbWUgZGV0YWlscyBhYm91dCBteSBlbnZpcm9ubWVudDoKKiBYZW5vbWFp
IHZlcnNpb24gOiBYZW5vbWFpL2NvYmFsdCB2My4yLjEKKiBLZXJuZWwgdmVyc2lvbiA6IExpbnV4
IHJhc3BiZXJyeXBpIDUuMTUuNTl4ZW5vbWFpIGFhcmNoNjQgR05VL0xpbnV4CiogRGV2aWNlIDog
cmFzcGliZXJyeSBQaSA0YgoqIENvYmFsdCBidWlsZGluZyBhcmdzIDogLS1lbmFibGUtc21wCiog
VGhlIHByb2plY3QgcmVwbyA6IGh0dHBzOi8vZ2l0aHViLmNvbS9zcnNyYW4vc3JzUkFOX1Byb2pl
Y3QKCgpJIGdyZWF0bHkgYXBwcmVjaWF0ZSBhbnkgc3VnZ2VzdGlvbnMgb3IgaGVscC7CoAoKCkJl
c3QgcmVnYXJkcywKU2FtCgo=
