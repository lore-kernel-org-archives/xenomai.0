Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2B92560
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 08:21:27 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 739A510000B;
	Fri, 26 Aug 2022 08:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1661502083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36j9bDDfPCQwhzS9Lls9KppPtNDxGfJXEYOg/k26VpM=;
	b=QpuQfi9JmwzlC75LQJszMbRW4e566iT8o65rIiobJN3didvOm3X8VkAYW4MuN0TNGiOcHp
	/EGkHIOEFG9e6XUELVJMhJXRZa21IuVt+Qtbdy9XNNs4Zk5AnNe18kyG+/BfpF90HfgGdg
	wfS519vMP0UYsbLo+FwUT8hUApCsuhSKoe8gV3moO1+g9Hrp6ijxc5ySsaCSwFXzLtmauz
	tuDzMXKTuJJYLMrpPrh5nitnKr+DI0pbvJTnKR/VJ6rPEGzOQsqTVXsyhncmFYMSZniQln
	gqhPhFf0rkqOEDW8PnlisDeEtXQVENkLiMaq+8Mr0oQDNNX9kkISqs84fL/nDw==
References: <0990af90-25f5-fdb7-8438-3d65d7dfe528@iki.fi>
 <cacc03cf-7bf6-2e48-caf1-63bbdd40b2aa@iki.fi>
 <991bd323-c5b4-a9c4-a052-f30411e2c4a9@iki.fi>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Jussi Viiri <ilmai@iki.fi>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] revl: Add empty Send + Sync implementations for Event
Date: Fri, 26 Aug 2022 10:21:12 +0200
In-reply-to: <991bd323-c5b4-a9c4-a052-f30411e2c4a9@iki.fi>
Message-ID: <87tu5zo1od.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQpKdXNzaSBWaWlyaSA8aWxtYWlAaWtpLmZpPiB3cml0ZXM6DQoNCj4gRXZlbnTCoHdhc24ndMKg
c2FmZcKgdG/CoHNlbmTCoGFjcm9zc8KgdGhyZWFkcy7CoEZpeGVkLg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBKdXNzaSBWaWlyaSA8aWxtYWlAaWtpLmZpPg0KPg0KPiAtLS0NCj4NCj4gRnJvbcKgMDc4
MmU3ZDZjNWY5MTg5ZmU4NWY4ZjM0MDcyMWUxYmNlYzNkMTZiMsKgTW9uwqBTZXDCoDE3wqAwMDow
MDowMMKgMjAwMQ0KPiBGcm9tOsKgSnVzc2nCoFZpaXJpIDxpbG1haUBpa2kuZmk+DQo+IERhdGU6
wqBUdWUswqAyM8KgQXVnwqAyMDIywqAyMjo0OTowMcKgKzAzMDANCj4gU3ViamVjdDrCoFtQQVRD
SMKgMy8zXcKgQWRkwqBlbXB0ecKgU2VuZMKgK8KgU3luY8KgaW1wbGVtZW50YXRpb25zwqBmb3LC
oEV2ZW50DQo+DQo+IC0tLQ0KPiDCoHNyYy9ldmVudC5yc8KgfMKgM8KgKysrDQo+IMKgMcKgZmls
ZcKgY2hhbmdlZCzCoDPCoGluc2VydGlvbnMoKykNCj4NCj4gZGlmZsKgLS1naXTCoGEvc3JjL2V2
ZW50LnJzwqBiL3NyYy9ldmVudC5ycw0KPiBpbmRleMKgN2ZkZmQyMy4uZjQ2OWM0M8KgMTAwNjQ0
DQo+IC0tLcKgYS9zcmMvZXZlbnQucnMNCj4gKysrwqBiL3NyYy9ldmVudC5ycw0KPiBAQMKgLTc2
LDbCoCs3Niw5wqBAQMKgaW1wbMKgV2FpdFRpbWVvdXRSZXN1bHTCoHsNCj4NCj4gwqBwdWLCoHN0
cnVjdMKgRXZlbnQoVW5zYWZlQ2VsbDxldmxfZXZlbnQ+KTsNCj4NCj4gK3Vuc2FmZcKgaW1wbMKg
U2VuZMKgZm9ywqBFdmVudMKge30NCj4gK3Vuc2FmZcKgaW1wbMKgU3luY8KgZm9ywqBFdmVudMKg
e30NCj4gKw0KPiDCoGltcGzCoEV2ZW50wqB7DQo+IMKgwqDCoMKgwqBwdWLCoGZuwqBuZXcoYnVp
bGRlcjrCoEJ1aWxkZXIpwqAtPsKgUmVzdWx0PFNlbGYswqBFcnJvcj7CoHsNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgbGV0wqB0aGlzwqA9wqBTZWxmKFVuc2FmZUNlbGw6Om5ldyh1bnNhZmXCoHsNCg0K
TWVyZ2VkLCB0aGFua3MuDQoNCi0tIA0KUGhpbGlwcGUuDQo=
