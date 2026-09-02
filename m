Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2823D7C2
	for <xenomai@lists.linux.dev>; Wed,  2 Sep 2026 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331649; cv=none; b=hE6o2EFRcarJB4+5ru+OVPKsvgiENk4wruXbrhMudjzohcr4ebeuFhrk467xHGkJGLwiaCFPDAJkHkvi8XozgZBJA7Kt+nJ6dmiboJd8U9L7z1whvL7QSFProp3g3lXau5DUvw2+PxVV7XC56yVtNzTWP5+/lcxvRc+8GW7c1BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331649; c=relaxed/simple;
	bh=hnOXPoSBtEi6Q0kZrVMYJ/7HnlTNp1pcgCZuKKF2lcY=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=kXmaPHcvM648nyLUoJsmIUi69h/optwHvg104JrQEuCE5ec1hAPfUqzXqFnZAmuTUeNVlbdwk+diawz02hoRhmwQYhO4qpSXeqkzSKpT9h3Hmm9mKGr6uImVa9WrBS1LlTaRrW4Qhf+plP+kVSkslCsZdmGsZyTR78/zwA/spck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=B1Pj3DN7; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="B1Pj3DN7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=hnOXPoSBtEi6Q0kZrVMYJ/7HnlTNp1pcgCZuKKF2lcY=; b=B
	1Pj3DN7UmTSIxFhXI/bYdcdIdd0bGVxNpIdojBHUaeRwvFNgDMHZ4f3TsDZ1U64P
	auLtxFaERNSjAGhMH2nyXbn+06Sq+6Hj+PNiVmi9O/1JVpYGcxTnqOuaLgcgP/yc
	ffn4uALUGG9WfDsnxh1wcBtw6CRfG4MwNZgB49RT1c=
Date: Wed, 2 Sep 2026 14:47:09 +0800 (CST)
From: "Yongxian Yao" <yxianyao@126.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: dd keeps the CPU fully loaded
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <e0f650d2-95ce-469b-af87-25de450ef43e@siemens.com>
References: <5990240f.1ddd.18c8f7bf237.Coremail.yxianyao@126.com>
 <c8491c64-f8d7-4136-8552-8ac1fb111170@siemens.com>
 <6e6d5f0a.3f41.18ce78d31f5.Coremail.yxianyao@126.com>
 <5a675ae.2fa0.19927496712.Coremail.yxianyao@126.com>
 <f293b971-906c-41e2-a966-a39b65e1e587@siemens.com>
 <267d379d.51f8.199280f6d63.Coremail.yxianyao@126.com>
 <e0f650d2-95ce-469b-af87-25de450ef43e@siemens.com>
X-NTES-SC: AL_Qu2TCv+Yvk4p7yGdZukdnk4Ugu89Wsa2ufsi1YBfc88OtSLGwy8OYWZuJWDy98W2NgOjiDWHejxCysJHeI1yVKEa1XBNr8jWMRbykGA27Q==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <2f1eee02.4b46.1a060df1a66.Coremail.yxianyao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dSkvCgD3n35txpdqIcE4AA--.14816W
X-CM-SenderInfo: p10lt0x1drqiyswou0bp/xtbBqA1NAWqXxm0+iQAA3I
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

Ckhp77yMCgpXaGVuIHRlc3RpbmcgbGF0ZW5jeShsYXRlbmN5IC1QIDEgLXAgMTAwIC1UIDQzMjAw
KSwgdXNlIHRoZSBkZCBjb21tYW5kIHRvIGZ1bGx5IGxvYWQgYWxsIENQVSBjb3Jlcy4KCjEuIGJz
PTE2TSwgdGhlIG1heGltdW0gZGVsYXkgZXhjZWVkcyAxMDAgzrxzCgrCoCDCoCBkZCBpZj0vZGV2
L3plcm8gb2Y9L2Rldi9udWxsIGJzPTE2TQoKUlRUfCAgMDA6MDQ6NTUgIChwZXJpb2RpYyB1c2Vy
LW1vZGUgdGFzaywgMTAwIHVzIHBlcmlvZCwgcHJpb3JpdHkgMSkKUlRIfC0tLS1sYXQgbWlufC0t
LS1sYXQgYXZnfC0tLS1sYXQgbWF4fC1vdmVycnVufC0tLW1zd3wtLS1sYXQgYmVzdHwtLWxhdCB3
b3JzdApSVER8wqAgwqAgwqAgIMKgMS4xMjl8wqAgICDCoCDCoCA3LjEwOHzCoCAgIMKgIMKgNjYu
NDg0fMKgIMKgIMKgIMKgICDCoCDCoDF8wqAgwqAgwqAgwqAgwqAwIHzCoCAgwqAgwqAwLjg3OSB8
wqAgwqAgwqAxMDMuNTk0ClJURHzCoCDCoCDCoCDCoCAxLjI2MHzCoCAgIMKgIMKgIDcuMjk0fMKg
ICAgwqAgwqA3MS4wNjR8wqAgwqAgwqAgwqAgIMKgIMKgMXzCoCDCoCDCoCDCoCDCoDAgfMKgICDC
oCDCoDAuODc5IHzCoCDCoCDCoDEwMy41OTQKUlREfMKgIMKgIMKgICDCoDEuMTg3fMKgICAgwqAg
wqAgNy4wMTV8wqAgICDCoCDCoDU4LjcwM3zCoCDCoCDCoCAgwqAgwqAgwqAxfMKgIMKgIMKgIMKg
IMKgMCB8wqAgIMKgIMKgMC44NzkgfMKgIMKgIMKgMTAzLjU5NApSVER8wqAgwqAgwqAgwqAgMS4x
MDN8wqAgICDCoCDCoCA2LjkwOXzCoCAgIMKgIMKgNTcuODMwfMKgIMKgIMKgICDCoCDCoCDCoDF8
wqAgwqAgwqAgwqAgwqAwIHzCoCAgwqAgwqAwLjg3OSB8wqAgwqAgwqAxMDMuNTk0CgoyLiBicz0x
TSwgdGhlIG1heGltdW0gZGVsYXkgaXMgbGVzcyB0aGFuIDEwIM68cy4KwqAgwqAgZGQgaWY9L2Rl
di96ZXJvIG9mPS9kZXYvbnVsbCBicz0xTQoKUlRUfCAgMDE6NDA6MjggIChwZXJpb2RpYyB1c2Vy
LW1vZGUgdGFzaywgMTAwIHVzIHBlcmlvZCwgcHJpb3JpdHkgMSkKUlRIfC0tLS1sYXQgbWlufC0t
LS1sYXQgYXZnfC0tLS1sYXQgbWF4fC1vdmVycnVufC0tLW1zd3wtLS1sYXQgYmVzdHwtLWxhdCB3
b3JzdApSVER8wqAgICDCoCDCoCAxLjQxNXzCoCDCoCAgwqAgwqAxLjc1M3zCoCAgIMKgIMKgIMKg
Mi4xMjV8wqAgwqAgIMKgIMKgIMKgIMKgMHzCoCDCoCAgwqAgwqAgwqAwfMKgIMKgICDCoCDCoDAu
ODU2fMKgIMKgICDCoCDCoDYuMjU1ClJURHzCoCDCoCAgIMKgIDEuNDY1fMKgIMKgICDCoCDCoDEu
NzU2fMKgICAgwqAgwqAgwqAyLjUzM3zCoCDCoCAgwqAgwqAgwqAgwqAwfMKgIMKgIMKgICDCoCDC
oDB8wqAgwqAgIMKgIMKgMC44NTZ8wqAgwqAgIMKgIMKgNi4yNTUKUlREfMKgIMKgICAgwqAgMS40
MTd8wqAgIMKgIMKgIMKgMS43NTF8wqAgICDCoCDCoCDCoDIuMTYzfMKgICDCoCDCoCDCoCDCoCDC
oDB8wqAgwqAgwqAgIMKgIMKgMHzCoCDCoCAgwqAgwqAwLjg1NnzCoCDCoCAgwqAgwqA2LjI1NQpS
VER8wqAgICDCoCDCoCAxLjQzMnzCoCAgwqAgwqAgwqAxLjc1MnzCoCAgIMKgIMKgIMKgMi4xNzl8
wqAgIMKgIMKgIMKgIMKgIMKgMHzCoCDCoCDCoCAgwqAgwqAwfMKgIMKgICDCoCDCoDAuODU2fMKg
IMKgICDCoCDCoDYuMjU1CgpXaHkgaXMgdGhlcmUgc3VjaCBhIGJpZyBkaWZmZXJlbmNlPwoKVGhh
bmtzCgotLQpZb25neGlhbiBZYW8K
