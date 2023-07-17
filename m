Received: from m1561.mail.126.com (m1561.mail.126.com [220.181.15.61])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA19117C5
	for <xenomai@lists.linux.dev>; Mon, 17 Jul 2023 03:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=eIFRcmqISWxyFlXgWeq3IHDuc5eYWqx5LqHi8fVwGrc=; b=m
	zZw+WSAVYWaTpTAbJxOUYzRbQCNdVGhJcrjEdtCTPR9M7njJEVTBxdgkfLz/tS2A
	7C0TCFL7MDfE5P1udsSl0tAedE3Zyt1CRkWBXqNgCcIbZy6KSq96DM6pqI6RDYbQ
	SROOOIa2gVcD3ejekna5yJsO44CjiNTP1C/C+xe3Ec=
Received: from yxianyao$126.com ( [103.161.254.5] ) by ajax-webmail-wmsvr61
 (Coremail) ; Mon, 17 Jul 2023 11:21:36 +0800 (CST)
X-Originating-IP: [103.161.254.5]
Date: Mon, 17 Jul 2023 11:21:36 +0800 (CST)
From: "Yao Yongxian" <yxianyao@126.com>
To: xenomai@lists.linux.dev
Subject: The issue of high CPU load
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 126com
X-NTES-SC: AL_QuyTC/mdu0gi4CiYZ+kWmEsQju45WMW0uPwu3YZTOJs0oyr06C4cU1FvI0b73++sOQa0njaWWyJczft0bbV0T7qfvUQ4o4zy+wT1pBefaHvg
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <19116d90.26f0.18961de2924.Coremail.yxianyao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:PcqowADnVWzBs7RkeiIEAA--.35596W
X-CM-SenderInfo: p10lt0x1drqiyswou0bp/1tbiHAevs1pEKhbQswABsH
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

Ckhp77yMCgpIaWdoIENQVSBsb2FkIG9uIHRoZSByZWFsLXRpbWUgdGhyZWFkIG9yIGlmIGEgWGVu
b21haSB0aHJlYWQgcnVucyBmb3IgYSBsb25nIHRpbWUgY2FuIGNhdXNlIHRoZSBzeXN0ZW0gdG8g
YmVjb21lIHVucmVzcG9uc2l2ZSBvciBldmVuIGNyYXNoLsKgClRoaXMgaXMgYmVjYXVzZSB0aGUg
cmVhbC10aW1lIHRocmVhZCBtYXkgY29uc3VtZSBhbGwgYXZhaWxhYmxlIENQVSByZXNvdXJjZXMs
IGxlYXZpbmcgbm8gcmVzb3VyY2VzIGZvciBvdGhlciB0aHJlYWRzIG9yIHN5c3RlbSBwcm9jZXNz
ZXMuCgpXaWxsIGhpZ2ggQ1BVIGxvYWQgY2F1c2VkIGJ5IG5vbiByZWFsLXRpbWUgcHJvY2Vzc2Vz
IGFmZmVjdCB0aGUgeGVub21haSByZWFsLXRpbWUgc3lzdGVtIHN0YWJpbGl0eSBvciBsZWFkIHRv
IG90aGVyIGlzc3Vlcz8KQ291bGQgeW91IHBsZWFzZSBnaXZlIG1lIHNvbWUgZGV0YWlsZWQgZXhw
bGFuYXRpb24/CgpMb29raW5nIGZvcndhcmQgdG8geW91ciByZXBseS4gCgpUaGFuayB5b3UuCgoK
Cg==
