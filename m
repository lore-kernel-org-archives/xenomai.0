Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685344;
	b=INPojfeSqwVy18R4C4FQMHCD2No8qDv7s3wvzzsnnKdC7zBERrUQPUX7nHINgXxjWVUb
	 0xrhEkfhR/qKiIP5QggcGMY2JB8qiqt3Omfu0f4tfdr/2pocqE9P6tbZtGcLgtFIVDexR
	 NLsCBzd46RjEmhQhd5SCb43XkR1hnnwVKhCf7K/V12NwMuhm7SwlGsPJTZh5/pXfYdVoz
	 +NXL+2rCNvUScjkSqyXpECMzGdnwoZaXwEXJ+kT9uWsihz75n1C+oC+7wIVXBK9AP286D
	 EHBnFxfDNP1T3y7Bv22pI0F+O1iJmsIUm8DcvSPQvKNkSBsuFjYBgDVj5slZyrR1awQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685344;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:In-Reply-To:References:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=GM2E/gKHVOxH2Qnss7UEPhxNY2JqifSohouGv2dmjr8=;
	b=SqS9CP4UAYxx+ymtKdIB5uzPqjMsDCSQkF940EQz4d3fVaRQgxjLjmylKIU5HOpzYZGq
	 YTUP88YYUjobXNFyd58escG3HbDx5VBdO3+F0knaJ11nJ9iNIb2+WSbotNLEKrxtKTWjo
	 4XO423iGordOoRU3toriZ7OXNIbnkdXGEEqW0M0gGPpx3d4QAGKHfeQBcmwQqj9i1ckZ6
	 nNtE4+/n3B2ILSklWUuCnRAnEqrPScclx2fHLUMwoWtuPG5QyKjthUfOQhPRVY/pSvTel
	 TWvZyqkItuN4pK/7yXTqBXdmutpbQ3SIb+NylU2NL0+k7/1wZ7hCUraOsBqAcwKtrNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nvXfDgOe;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A56606A31B
	for <xenomai@lists.linux.dev>; Thu, 22 Oct 2026 16:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1A56606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nvXfDgOe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=GM2E/gKHVOxH2Qnss7UEPhxNY2JqifSohouGv2dmjr8=; b=n
	vXfDgOei7W2IbXmUa+wpj3r0C5PnDq6PCNyNqTAXU2U1HI9VzgQBVq33nZII9rMn
	DgOCOn4fPw43PUy3tlrMgOrkcqdXBbu5FGdnHoXjtsORYbl8ek2qFp0DTEtO+5MV
	aGBK2BXjO+3XFS+X5sTGBzZMyUpPxzAmwtoXvkQvVo=
Date: Fri, 23 Oct 2026 00:08:56 +0800 (CST)
From: "guangfeng.wang" <guang_feng_wang@163.com>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,
	"Florian Bezdeka" <florian.bezdeka@siemens.com>
Subject: Re:Call today
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <98caad22-455d-41ca-bfaa-f32289c7c8e8@siemens.com>
References: <98caad22-455d-41ca-bfaa-f32289c7c8e8@siemens.com>
X-NTES-SC: AL_Qu2SAPqTukso4CmbZukckkwQh+Y9Wsa3ufUj24FQc8EFnxn90D8rW3JGPkb4/96XNxy0rh2wVRpS+NlneYNAKdPFsgQj5h2vCcQkBOoZkQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-ID: <3f47b992.2269.1a1645f696d.Coremail.guang_feng_wang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gigvCgDXHzUZNdpq2kheAA--.342W
X-CM-SenderInfo: xjxd0wxbih0wxbzd0wi6rwjhhfrp/xtbC+hmkHmraNRm6TwAA3w
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpwqBhbGwsCgpGb2xsb3dpbmfCoEphbidzwqBlYXJsaWVywqBub3RlLMKgSSdkwqBsaWtlwqB0
b8Kgc2hhcmXCoHRoZcKgYWdlbmRhwqBmb3LCoHRoZcKgdXBjb21pbmfCoFhlbm9tYWnCoENoaW5h
wqBDb21tdW5pdHnCoE1lZXR1cMKgaW7CoEJlaWppbmfCoG9uwqBPY3RvYmVywqAyOC4KClRoZcKg
bWVldHVwwqB3aWxswqBicmluZ8KgdG9nZXRoZXLCoFhlbm9tYWnCoGRldmVsb3BlcnMswqByZXNl
YXJjaGVycyzCoGFuZMKgaW5kdXN0cnnCoGV4cGVydHPCoHRvwqBkaXNjdXNzwqByZWFsLXRpbWXC
oExpbnV4LMKgY3liZXJzZWN1cml0eSzCoGhhcmR3YXJlwqBhbmTCoE9TwqBjby1kZXNpZ24swqBh
bmTCoGluZHVzdHJpYWzCoGFwcGxpY2F0aW9ucy4KCkRhdGU6wqBXZWRuZXNkYXkswqBPY3RvYmVy
wqAyOCzCoDIwMjYKVGltZTrCoDE0OjAw4oCTMTY6MDDCoEJlaWppbmfCoHRpbWXCoChVVEMrOCkK
Q2hlY2staW46wqBGcm9twqAxMzozMApWZW51ZTrCoERvbmdjaGVuZ8KgQ3VsdHVyYWzCoFRhbGVu
dMKgKEludGVybmF0aW9uYWwpwqBFbnRyZXByZW5ldXJzaGlwwqBQYXJrLMKgMm5kwqBGbG9vcizC
oE5vLsKgMUHCoFFpbmdsb25nwqBIdXRvbmcswqBCZWlqaW5nwqAobmVhcsKgWW9uZ2hlZ29uZykK
Ckd1aWRlZMKgYnk6wqBEb25nY2hlbmfCoERpc3RyaWN0wqBBc3NvY2lhdGlvbsKgZm9ywqBTY2ll
bmNlwqBhbmTCoFRlY2hub2xvZ3kswqBCZWlqaW5nCk9yZ2FuaXplZMKgYnk6wqBYZW5vbWFpwqBD
aGluYcKgQ29tbXVuaXR5LMKgTmV4dXNMaW5rCgpMb2NhbMKgT3JnYW5pemVyczrCoFpob25nZ3Vh
bmN1bsKgWW9uZ2hlwqBIYW5neGluZ8KgU2NpZW5jZcKgUGFyayzCoEJlaWppbmfCoERpZ2l0YWzC
oENyZWF0aXZlwqBJbmR1c3RyaWVzwqBBc3NvY2lhdGlvbgoKQWdlbmRhOgoKMTQ6MDDigJMxNDoy
NcKg4oCUwqBPcGVuaW5nwqBhbmTCoENvbW11bml0ecKgVXBkYXRlCi3CoFByb3Bvc2VkwqBvcGVu
aW5nwqBzcGVha2VyOsKgUWluZ2d1b8KgWmhvdcKgKExhbnpob3XCoFVuaXZlcnNpdHkpCi3CoFhl
bm9tYWnCoENoaW5hwqBDb21tdW5pdHnCoHVwZGF0ZTrCoEd1YW5nZmVuZ8KgV2FuZ8KgKE5leHVz
TGluaykKLcKgQ29tbXVuaXR5wqBjZXJlbW9uecKgYW5kwqBncm91cMKgcGhvdG8KCjE0OjI14oCT
MTQ6MzXCoOKAlMKgQ3liZXJzZWN1cml0ecKgaW7CoFJlYWwtVGltZcKgU3lzdGVtcwotwqBXZWnC
oFpob3XCoChIdWF6aG9uZ8KgVW5pdmVyc2l0ecKgb2bCoFNjaWVuY2XCoGFuZMKgVGVjaG5vbG9n
eSkKLcKgU2h1amlhbmfCoFd1wqAoQmVpaGFuZ8KgVW5pdmVyc2l0eSkKCjE0OjM14oCTMTQ6NTDC
oOKAlMKgRmlyZXNpZGXCoENoYXTCoHdpdGjCoEphbsKgS2lzemthCgoxNDo1MOKAkzE2OjAwwqDi
gJTCoEludGVyYWN0aXZlwqBUZWNobmljYWzCoFJvdW5kdGFibGUKClRvcGljc8KgaW5jbHVkZcKg
cmVhbC10aW1lwqBMaW51eCzCoGhhcmR3YXJlwqBhbmTCoE9TwqBjby1kZXNpZ24swqBBScKgYW5k
wqBkZXRlcm1pbmlzdGljwqBjb250cm9sLMKgYW5kwqBpbmR1c3RyaWFswqBhcHBsaWNhdGlvbnMu
CgpQbGFubmVkwqByb3VuZHRhYmxlwqBwYXJ0aWNpcGFudHM6Ci3CoFl1wqBDaGVuwqAoVHNpbmdo
dWHCoFVuaXZlcnNpdHkpCi3CoEphbsKgS2lzemthwqAoU2llbWVucykKLcKgWGlsb25nwqBQZWnC
oChUb25namnCoFVuaXZlcnNpdHkpCi3CoEFubGnCoER1wqAoTG9vbmdzb24pCi3CoEppYW53ZWnC
oFNvbmfCoChTaW5zZWd5ZSkKCk1lZXR1cMKgTW9kZXJhdG9yOsKgR3VhbmdmZW5nwqBXYW5nCgpN
b3JlwqB0aGFuwqA2MMKgcGVvcGxlwqBoYXZlwqBleHByZXNzZWTCoGludGVyZXN0wqBpbsKgYXR0
ZW5kaW5nwqBzb8KgZmFyLsKgQWN0dWFswqBhdHRlbmRhbmNlwqBtYXnCoHZhcnkswqBhbmTCoHRo
ZcKgZmluYWzCoHNwZWFrZXLCoGxpc3TCoGlzwqBzdGlsbMKgYmVpbmfCoGNvbmZpcm1lZC4KCldl
wqB3ZWxjb21lwqBxdWVzdGlvbnPCoGFuZMKgdGVjaG5pY2FswqBkaXNjdXNzaW9uc8KgZnJvbcKg
YWxswqBwYXJ0aWNpcGFudHMuCgpJZsKgeW91wqBoYXBwZW7CoHRvwqBiZcKgaW7CoEJlaWppbmfC
oGFuZMKgd291bGTCoGxpa2XCoHRvwqBqb2luwqB1cyzCoHBsZWFzZcKgZmVlbMKgZnJlZcKgdG/C
oGdldMKgaW7CoHRvdWNoLgoKTG9va2luZ8KgZm9yd2FyZMKgdG/CoG1lZXRpbmfCoHlvdcKgaW7C
oEJlaWppbmchCgpCZXN0wqByZWdhcmRzLApHdWFuZ2ZlbmfCoFdhbmcKCgpBdMKgMjAyNi0xMC0x
NMKgMTM6MTA6MzUswqAiSmFuwqBLaXN6a2EiwqA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT7CoHdy
b3RlOgo+SGnCoGFsbCwKPgo+c29ycnnCoGFsbCzCoEnCoHdvbid0wqBtYWtlwqBpdMKgYWdhaW7C
oHRvZGF5wqBmb3LCoG91csKgcmVndWxhcsKgY2FsbC7CoElmwqB0aGVyZQo+YXJlwqB0b3BpY3Ms
wqBwbGVhc2XCoGRyb3DCoGHCoG5vdGXCoGlmwqBzb21lb25lwqB3b3VsZMKgc3RpbGzCoGxpa2XC
oHRvwqBob2xkwqB0aGXCoGNhbGwuCj4KPknCoHdpbGzCoGFsc2/CoGhhdmXCoHRyb3VibGVzwqB0
b8KgYXJyYW5nZcKgdGhlwqBjYWxswqBpbsKgdHdvwqB3ZWVrc8KgZHVlwqB0bwo+dHJhdmVsaW5n
wqBmYXLCoEVhc3QuwqBCdXTCoHRoZXJlwqBpc8KgYW7CoGluLXBlcnNvbsKgbWVldHVwwqBpbsKg
cHJlcGFyYXRpb27CoGlmCj55b3XCoGhhcHBlbsKgdG/CoGJlwqBpbsKgQmVpamluZ8Kgb27CoHRo
ZcKgMjh0aMKgLcKgZGV0YWlsc8Kgd2lsbMKgZm9sbG93Lgo+Cj5KYW4KPgo+LS3CoAo+U2llbWVu
c8KgQUcswqBGb3VuZGF0aW9uYWzCoFRlY2hub2xvZ2llcwo+TGludXjCoEV4cGVydMKgQ2VudGVy
Cj4K
