Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212BAB67F
	for <xenomai@lists.linux.dev>; Thu, 18 Jan 2024 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705569066; cv=none; b=aaiF0Xq7SycHRXaxh0uBdfHWxfaEZf0jNLk21kcSo+flhX4M3wbSNZtpybGDtXGbzsalwqmJ6oBV1qT8bbLnMAgq42c5X6bjwG54lp8z7Yi2vPV2+uFqEXFmlPqfv9qOE1YewSxPR91DCjjU1nmh8fwxgZxgtHxxbEmB+cAk8Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705569066; c=relaxed/simple;
	bh=NnnHakAUah+dU3i40OqjYQbKKD/2M2E4q5uxHF58SSM=;
	h=DKIM-Signature:Received:X-Originating-IP:Date:From:To:Subject:
	 X-Priority:X-Mailer:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:
	 X-CM-TRANSID:X-CM-SenderInfo:X-Coremail-Antispam; b=TUMGTZBNl71rKgOpokvSWRloxVaZ6KG6vqZtYVhRN15tNIsAgfOOdNBvbyqtDhgR6lPQ8iHRL+xep1n7Bf3Xn85patETB4f4M2qR6KNxvVobP5HKw5CpU9QgWz3b+c8CHC4E9WTR1bN19TTeNg4cxFTUEUUhcecWPOaQUVzYegw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=hDEVAYwn reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="hDEVAYwn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=S13UNXdp+QjwySBmQxii3ApODYGfnambfhlD6jtIzpY=; b=h
	DEVAYwnS1SFdlz45fa+nJXIaTInEm/i3MDj9cw4S/QuO0XwdT4lwXdKugez1qB7/
	9elfxi7sTEtBwCuuZOAp6LxQzH47AtqYZ4JMSJTB1enHECUY586mPqhMXOLnDAtG
	1njrhTNCDec3qALHpZk85dmotyGcxy5Dix7nkqCQmM=
Received: from mars_liu2023$163.com ( [103.161.254.5] ) by
 ajax-webmail-wmsvr-40-127 (Coremail) ; Thu, 18 Jan 2024 17:10:56 +0800
 (CST)
Date: Thu, 18 Jan 2024 17:10:56 +0800 (CST)
From: "mars_liu2023@163.com" <mars_liu2023@163.com>
To: xenomai <xenomai@lists.linux.dev>
Subject: latency: pthread_create(latency): Operation not permitted
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2bB/mdtkgu4CCcZOkWmEsQju45WMW0uPwu3YZTOJs0lyTH2Cwyd3VlNHH54tuQIh+ruhKKcBl34ON3ZLRkdaSOSYN5as40IO/axlg950Y1
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <789c8c7f.87f2.18d1bd6752c.Coremail.mars_liu2023@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD33y4g66hllNFPAA--.2820W
X-CM-SenderInfo: 5pdu2sholxjiist6il2tof0z/xtbBEBxVD2VOBQ6ARQAJs6
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CmhpIHhlbm9tYWksCgpJIGhhZCBhIHByb2JsZW0gd2hlbiBydW5uaW5nIC91c3IvbGliL3hlbm9t
YWkvdGVzdHN1aXRlL2xhdGVuY3k6wqAgPT0gU2FtcGxpbmcgcGVyaW9kOiAxMDAgdXMKwqAgPT0g
VGVzdCBtb2RlOiBwZXJpb2RpYyB1c2VyLW1vZGUgdGFzawrCoCA9PSBBbGwgcmVzdWx0cyBpbiBt
aWNyb3NlY29uZHMKwqAgL3Vzci9saWIveGVub21haS90ZXN0c3VpdGUvbGF0ZW5jeTogcHRocmVh
ZF9jcmVhdGUobGF0ZW5jeSk6IE9wZXJhdGlvbiBub3QgcGVybWl0dGVkCgoKCnhlbm9tYWkgdmVy
c2lvbjp2My4yLjQ7IGtlcm5lbCB2ZXJzaW9uOiA1LjEwLjE5OS14ZW5vbWFpLjMuMi40CgoKSSBo
YXBwZW5lZCB0byBmaW5kIHRoaXMgcHJvYmxlbSBpcyByZWxhdGVkIHRvIGluc3RhbGwgY29udGFp
bmVyZC5pb18xLjYuMjQtMV9hbWQ2NC5kZWIuCmlmwqAgZHBrZyAtciBjb250YWluZXJkLmlvX3h4
LmRlYiB0aGVuIHRoZSBsYXRlbmN5IHRlc3QgaXMgb2sgLgpob3cgY2FuIGkgbWFrZSBsYXRlbmN5
IHdvcmsgd2l0aCBjb250YWluZXJkLmlvLgpkb2VzIGNvbnRhaW5lcmQuaW8gZWZmZWN0IHRoZSBl
bnYgb2YgeGVub21haSBhcHBsaWN0aW9uPwoKCnRoYW5rc8KgYW5kIHJlZ2FyZHM=
