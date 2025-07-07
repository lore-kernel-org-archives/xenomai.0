Received: from out198-9.us.a.mail.aliyun.com (out198-9.us.a.mail.aliyun.com [47.90.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C266525C6FA
	for <xenomai@lists.linux.dev>; Mon,  7 Jul 2025 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751862547; cv=none; b=UZZsQ5fstuzX0Gl2tmAOyU6/vhqQgbuzkooMhxyMk2JYWxPfbNH7IKvXT6Zh3XEp4RHNnfhWYJ37qJBs5w2bsCGX2oBTA6aArtxhVwWlYv2GYKQ8ysnRKvg24PyUSildiEhquEdADSxmOCb10JqM7nPihbJ0xDKrCadCiqaY9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751862547; c=relaxed/simple;
	bh=BuZEHUglxv4rJCLNKzRHVky5wvSelOkaJBWxKjKGhrM=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=lk0SzzNU7ecnigtwE/cEO5+0MR0WO0+oRJ7B7kRuqn6+lxZM1o7NViNGdBf/U1jhYGWvk0A95eOShyyESRCxi+eBOkfJUFbebIbw8cQUKkhnI2bnNXY+V8wuHa0FqBrPJBYtw3DjI1whkAiiaGlsElLTRINNF5QebC9m93vsx8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apue.org; spf=pass smtp.mailfrom=apue.org; arc=none smtp.client-ip=47.90.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apue.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apue.org
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07699277|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.153888-0.00204124-0.844071;FP=17003755974166478841|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068241161;MF=luis@apue.org;NM=1;PH=DW;RN=1;RT=1;SR=0;TI=W4_0.2.3_v5ForWebDing_212508C1_1751861716019_o7001c960;
Received: from WS-web (luis@apue.org[W4_0.2.3_v5ForWebDing_212508C1_1751861716019_o7001c960] cluster:ay29) at Mon, 07 Jul 2025 12:28:51 +0800
Date: Mon, 07 Jul 2025 12:28:51 +0800
From: "Luis" <luis@apue.org>
To: "xenomai" <xenomai@lists.linux.dev>
Reply-To: "Luis" <luis@apue.org>
Message-ID: <e4529393-79f0-4579-a7c4-4424f348da29.luis@apue.org>
Subject: =?UTF-8?B?WGVub21haSAzLjIueCBpbiBkZWJpYW4xMiBzdHJuY3B5IHdhcm5pbmc=?=
X-Mailer: [Alimail-Mailagent revision 3][W4_0.2.3][v5ForWebDing][Chrome]
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <e936781c-3a9a-45a9-bf62-113cc0bf43d2.luis@apue.org>,<924e7b82-8695-496c-bbe3-fea195b6c05f.luis@apue.org>,<945a6b69-8a99-4b09-87a7-195683ea3540.luis@apue.org>
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_M3LTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzOC4wLjAuMCBTYWZhcmkvNTM3LjM2vN
In-Reply-To: <945a6b69-8a99-4b09-87a7-195683ea3540.luis@apue.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGlsIGFsbCwKCgpIZXJlIGFyZSB2ZXJzaW9ucyBhZmZlY3RlZCBieSBteSB0ZXN0aW5nOgprZXJu
ZWw6wqAKwqAgwqAgwqAgwqAgNC4xOS44OSB0byA0LjE5LjI5Miwgd2l0aCBpcGlwZQp4ZW5vbWFp
OsKgCsKgIMKgIMKgIMKgIDMuMi4yIHRvIDMuMi42Cnhlbm9tYWkgY29uZmlndXJlIGNtZGxpbmU6
CsKgIMKgIMKgIMKgIC0td2l0aC1jb3JlPWNvYmFsdCAtLXByZWZpeD0vWEVOT01BSV9QQVRIIC0t
ZW5hYmxlLXBzaGFyZWQgLS1lbmFibGUtc21wCmhvc3Qgc3lzdGVtOiBkZWJpYW4gMTIuMTAgYW1k
NjQKZ2xpYmM6IGRlYmlhbiBkZWZhdWx0IDIuMzYKZ2NjLCBnKys6IGRlYmlhbiBkZWZhdWx0IDEy
LjIuMAoKClRoZSBlcnJvciBtc2c6CmZzLWNvbW1vbi5jOiBJbiBmdW5jdGlvbiDigJhvcGVuX2hl
YXBz4oCZOgppbmNsdWRlL2JvaWxlcnBsYXRlL2FuY2lsbGFyaWVzLmg6Mzc6MzogZXJyb3I6IOKA
mHN0cm5jcHnigJkgb3V0cHV0IG1heSBiZSB0cnVuY2F0ZWQgY29weWluZyAzMSBieXRlcyBmcm9t
IGEgc3RyaW5nIG9mIGxlbmd0aCAzMSBbLVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0aW9uXQogwqAg
MzcgfCDCoCBzdHJuY3B5KChfX2RzdCksIF9fc3JjLCBzaXplb2YoX19kc3QpKTsgwqAgXArCoCDC
oCDCoCB8IMKgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogYWxs
IHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCgoKTXkgcGF0Y2g6Ckp1c3QgcmVwbGFj
ZSB0aGUgJ3N0cm5jcHknIHdpdGggJ21lbWNweScsIGFzIGZvbGxvd3M6Ci0gc3RybmNweSgoX19k
c3QpLCBfX3NyYywgc2l6ZW9mKF9fZHN0KSk7IFwKKyBtZW1jcHkoX19kc3QsIF9fc3JjLCBzaXpl
b2YoX19kc3QpKTsgXAoKCk9yIGFueSBiZXR0ZXIgc29sdXRpb24/CgoKVGhpcyB3YXJuaW5nIGFs
c28gZXhpc3RzIGluIHRoZSBkZWZhdWx0IGdjYyBpbiBEZWJpYW4xMSBBTUQ2NCwgd2l0aCBsaW51
eCA0LjE5LngreGVub21haSAzLjIueAoKClJlZ2FyZHMsCkx1aXMuS29vCgoKCgoKCgo=
