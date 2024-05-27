Received: from out198-10.us.a.mail.aliyun.com (out198-10.us.a.mail.aliyun.com [47.90.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71858F40
	for <xenomai@lists.linux.dev>; Mon, 27 May 2024 05:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716788716; cv=none; b=OoYruPs7Jyodwwyc0i8VOYcqyS25l6cOqQAyFo59edP6VBt+zScvzzyVpnFN152MzDouJpr0lr0raJYipJgYp7GyVKWWKOJiv9L3eH9PfhiCCEUZjecXMhSbhqHUt9bV1HeqGIKcUHUQuXPDX5jLlFd4DOIYNEJq1s7d+uTeU/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716788716; c=relaxed/simple;
	bh=ulIurVtyMU0XO9p8DegIt/8UEBD6n5amRkvJEkt+X7k=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=EcUy6VCdImN4MC+mT83lJ79jmCzC+5GDzVpYJKY2BRHrMUmSOrRqDagxdzo9y9Tj20658qVwB80dUVJip6iVOPg+1wSsPdrm/HH5IKA8I9Ol7i2Fv+tJHP1vNtfQTPfeCFHlOXZt1nvdkz/bONYQK8OunT+xxMgQ4UJGk0i2YRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=47.90.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08201527|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00651562-0.000499502-0.992985;FP=0|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033070021176;MF=chenjinhong@sinsegye.com.cn;NM=1;PH=DW;RN=6;RT=6;SR=0;TI=W4_0.2.3_v5ForWebDing_212DCBE7_1716551523027_o7001c154a;
Received: from WS-web (chenjinhong@sinsegye.com.cn[W4_0.2.3_v5ForWebDing_212DCBE7_1716551523027_o7001c154a]) at Mon, 27 May 2024 13:44:55 +0800
Date: Mon, 27 May 2024 13:44:55 +0800
From: "=?UTF-8?B?6ZmI5Yqy5a6P?=" <chenjinhong@sinsegye.com.cn>
To: "xenomai" <xenomai@lists.linux.dev>
Cc: "florian.bezdeka" <florian.bezdeka@siemens.com>,
  "jan.kiszka" <jan.kiszka@siemens.com>,
  "=?UTF-8?B?5a6L5YGl546u?=" <songjianwei@sinsegye.com.cn>,
  "=?UTF-8?B?5YiY5p2o?=" <liuyang@sinsegye.com.cn>,
  "=?UTF-8?B?5p2O6IOk6aKJ?=" <liyinjie@sinsegye.com.cn>
Reply-To: "=?UTF-8?B?6ZmI5Yqy5a6P?=" <chenjinhong@sinsegye.com.cn>
Message-ID: <c572a244-dc12-4b13-a159-373dfcd2d492.chenjinhong@sinsegye.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYxIDEvMV0gY29iYWx0L3RocmVhZDoga2VybmVsIGNtZGxpbmUgcGFyYW0gJ3N1?=
  =?UTF-8?B?cHBvcnRlZF9jcHVzJyBjYW5ub3QgVGFrZSBlZmZlY3QgIGluIGNyZWF0ZSBbUk9PVC8qXSBp?=
  =?UTF-8?B?ZGxlIHRocmVhZHMu?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][v5ForWebDing][Firefox]
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
x-aliyun-im-through: {"mailThroughImNew":true}
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_IHJTW96aWxsYS81LjAgKFgxMTsgVWJ1bnR1OyBMaW51eCB4ODZfNjQ7IHJ2OjEwOS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94LzExMy4wjQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTogSmluSG9uZyBDaGVuIDxjaGVuamluaG9uZ0BzaW5zZWd5ZS5jb20uY24+CkRhdGU6IEZy
aSwgMjQgTWF5IDIwMjQgMTU6NDg6MDIgKzA4MDAKU3ViamVjdDogW1BBVENIIHYxIDEvMV0gY29i
YWx0L3RocmVhZDogZ3J1YiBwYXJhbSAnc3VwcG9ydGVkX2NwdXMnIGNhbm5vdCBUYWtlCiBlZmZl
Y3QgaW4gY3JlYXRlIFtST09ULypdIGlkbGUgdGhyZWFkcy4KClRoaXMgaXMgdGhlIHBhdGNoIGZv
ciBzdXBwb3J0aW5nICdzdXBwb3J0ZWRfY3B1cycgcGFyYW0gb2Yga2VybmVsIGNtZGxpbmUuIEZv
ciBmb2xsb3dpbmcgdmVyc2lvbjoKLSBYZW5vbWFpIDMsIEhlYWQgb2Ygc3RhYmxlL3YzLjIueCBi
cmFuY2guCgpTaWduZWQtb2ZmLWJ5OiBKaW5Ib25nIENoZW4gPGNoZW5qaW5ob25nQHNpbnNlZ3ll
LmNvbS5jbj4KLS0tCiBrZXJuZWwveGVub21haS9zY2hlZC5jIHwgMiArKwogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC94ZW5vbWFpL3NjaGVkLmMg
Yi9rZXJuZWwveGVub21haS9zY2hlZC5jCmluZGV4IGFhNjVmZDdmNS4uMjk4Nzg5OWIxIDEwMDY0
NAotLS0gYS9rZXJuZWwveGVub21haS9zY2hlZC5jCisrKyBiL2tlcm5lbC94ZW5vbWFpL3NjaGVk
LmMKQEAgLTIzMSw2ICsyMzEsOCBAQCB2b2lkIHhuc2NoZWRfaW5pdF9hbGwodm9pZCkKIAlpbnQg
Y3B1OwogCiAJZm9yX2VhY2hfb25saW5lX2NwdShjcHUpIHsKICsgICAgaWYgKCFjcHVtYXNrX3Rl
c3RfY3B1KGNwdSwgJnhuc2NoZWRfcmVhbHRpbWVfY3B1cykpCiArICAgICAgY29udGludWU7CiAJ
CXNjaGVkID0gJnBlcl9jcHUobmtzY2hlZCwgY3B1KTsKIAkJeG5zY2hlZF9pbml0KHNjaGVkLCBj
cHUpOwogCX0KLS0gCjIuMTcuMQoKCg==
