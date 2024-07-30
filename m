Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6309B147C86
	for <xenomai@lists.linux.dev>; Tue, 30 Jul 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352413; cv=none; b=G/9OyT6EUG3/LiElL4IUSvH57KNmJG67cE7IC5GXYHe9o5y4xPgFmYQjnOxKs+hlaqbCVRs0ed3xBksrq6DBHdygOnLksy66AGc1BjEvG+m1yz7nfxFfn8KGG7QcdWsuV4JCrb5Z8c23LfupG1HEVA+Knw2NofYOqYpVARDZ688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352413; c=relaxed/simple;
	bh=ulIFygMhafHXzalSiesZ3V20/IhbBAd7wptigxSLD0g=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=b0NW42AT0nrnU3X4521n6OSbqP+/pe2TxJszaCPY/SdemZwJxvlNFqAISwXjyDRpLphD2vdSFaupkgpGde4Rk3u1pZ2CFeyRXeW/8idQ/R5nGkIoR/14ywn0wfUJzJJg0dAgSR0NPgadq7tFd8A9M9pl4oHOznn3gmQaeGsN10c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=QDc6FAXq reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="QDc6FAXq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=qK869Lxm8ezS17ToTxUzR6f2rq1ce3dqeiyLULbHd7Q=; b=Q
	Dc6FAXqQL+3ff21jgdfZEw1POZp6l9NqNfStnkyQd+BswNgTYdoclau0RmB0wi4P
	ilI4J6QEFgONPhptklXtPlhGap0j2++rIK9w2P1hrv7sn1x4Y9mAJRyhDTdfVCc8
	Cbef68ocIhzPVhqh0nivKqEIIWGZpwg/fn82i675WU=
Received: from jerryjun123$163.com ( [119.123.131.120] ) by
 ajax-webmail-wmsvr-40-129 (Coremail) ; Tue, 30 Jul 2024 23:13:21 +0800
 (CST)
Date: Tue, 30 Jul 2024 23:13:21 +0800 (CST)
From: JerryJun <jerryjun123@163.com>
To: xenomai@lists.linux.dev
Subject: open failed blocked driver rmmod
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2ZAP+evUwr5yKRZOkfm0gag+05XMa3vf4v2Y9XP598jADpwAAnYHNnBlDry+eBCgC9nTyzaSJ/9e55f5Z8Ubg0YjUorJmGMachOa4ANGNbdA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <324a7073.a9d1.1910433fb8f.Coremail.jerryjun123@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3f+ERA6lmjOpjAA--.58424W
X-CM-SenderInfo: xmhu25pmxqijqt6rljoofrz/1tbiLgHkLGV4JEi-VwACs8
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CmhpLCB4ZW5vbWFpOgpJJ20gYSBsaXR0bGUgY29uZnVzZWQuIHdoZW4geW91IGZhaWwgdG8gb3Bl
biBhbiBydGRtIGRldmljZSBmcm9tIGRldi0+b3BzLm9wZW4sIHRoZSBydGRtIGRyaXZlciBjYW5u
b3QgYmUgcm1tb2QuCkFzIGlmIGNsZWFudXBfaW5zdGFuY2UgYW5kIF9fcnRkbV9wdXRfZGV2aWNl
IGluIF9fcnRkbV9kZXZfb3BlbiBleGVjdXRlIGF0b21pY19kZWMoJmRldi0+cmVmY291bnQpIHR3
aWNlLCBkZXYtPnJlZmNvdW50IGJlY29tZXMgYSBuZWdhdGl2ZSB2YWx1ZSBub3QgZXF1YWwgdG8g
MD8KVGhlIHdhaXRfZXZlbnQoZGV2LT5wdXR3cSwgYXRvbWljX3JlYWQoJmRldi0+cmVmY291bnQp
ID09IDApIGNvbmRpdGlvbiBpbiBydGRtX2Rldl91bnJlZ2lzdGVyIGNhbm5vdCBiZSBzYXRpc2Zp
ZWQuIHRoZSB0YXNrIG9mIHJtbW9kIGlzIGFsd2F5cyBpbiBUQVNLX1VOSU5URVJSVVBUSUJMRSBz
dGF0ZS4KCnhlbm9tYWk6My4yLjQga2VybmVsOjUuMTAuMTk5Cl9fcnRkbV9kZXZfb3BlbiAtPgpm
YWlsX29wZW46CmNsZWFudXBfaW5zdGFuY2UoZGV2LCBjb250ZXh0KTsKZmFpbF9jcmVhdGU6CmZp
bHBfY2xvc2UoZmlscCwgY3VycmVudC0+ZmlsZXMpOwpmYWlsX2ZvcGVuOgpwdXRfdW51c2VkX2Zk
KHVmZCk7CmZhaWxfZmQ6Cl9fcnRkbV9wdXRfZGV2aWNlKGRldik7CgpbIDEwODguNTgxOTE3XSBJ
TkZPOiB0YXNrIHJtbW9kOjI1MDMgYmxvY2tlZCBmb3IgbW9yZSB0aGFuIDEyMCBzZWNvbmRzLgpb
IDEwODguNTgyMjMxXSBUYWludGVkOiBHIE8gNS4xMC4xOTktZG92ZXRhaWwteGVub21haS0zLjIu
NC0yMDI0MDIyOCAjMQpbIDEwODguNTgyNDM2XSAiZWNobyAwID4gL3Byb2Mvc3lzL2tlcm5lbC9o
dW5nX3Rhc2tfdGltZW91dF9zZWNzIiBkaXNhYmxlcyB0aGlzIG1lc3NhZ2UuClsgMTA4OC41ODI2
NDJdIHRhc2s6cm1tb2Qgc3RhdGU6RCBzdGFjazogMCBwaWQ6IDI1MDMgcHBpZDogMjUwMiBmbGFn
czoweDAwMDA0MDA0ClsgMTA4OC41ODI4NTBdIENhbGwgVHJhY2U6ClsgMTA4OC41ODMwNTldIF9f
c2NoZWR1bGUrMHgyZWUvMHg3ODAKWyAxMDg4LjU4MzI2NF0gc2NoZWR1bGUrMHg0MC8weGUwClsg
MTA4OC41ODM0NjddIHJ0ZG1fZGV2X3VucmVnaXN0ZXIrMHhlYS8weDE3MApbIDEwODguNTgzNjY0
XSA/IHdhaXRfd29rZW4rMHg4MC8weDgwClsgMTA4OC41ODM4NTJdIFVucmVnaXN0ZXJEZXZpY2Ur
MHhmLzB4MjAgW21vZF90ZXN0XQpbIDEwODguNTg0MDM4XSA/IEV4aXRBbGwrMHg2NC8weDFmZiBb
bW9kX3Rlc3RdClsgMTA4OC41ODQyMjRdID8gTW9kdWxlRXhpdCsweDUvMHhlZjUgW21vZF90ZXN0
XQpbIDEwODguNTg0NDEyXSA/IF9fZG9fc3lzX2RlbGV0ZV9tb2R1bGUrMHgxOWEvMHgyNDAKWyAx
MDg4LjU4NDU5OF0gPyBmcHJlZ3NfYXNzZXJ0X3N0YXRlX2NvbnNpc3RlbnQrMHgxOS8weDQwClsg
MTA4OC41ODQ3OTBdID8gZG9fc3lzY2FsbF82NCsweDMzLzB4NTAKWyAxMDg4LjU4NDk4Ml0gPyBl
bnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2MS8weGM2
