Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C026DDC3
	for <xenomai@lists.linux.dev>; Mon, 21 Jul 2025 02:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753065901; cv=none; b=YlkWxlNfgeTTTHbY8KGCcU0phQJ1RQmnt12j/6N+yqxktvvS0lIs5/Gb5FAjPDLYwy4RCeANHRIrjwMF+8sIwc40hhUbyzRQe5pcoUCuVw2+MZjyCI4Vd6Z9XZsTXHZO+FVhDIFGuLR7Fd6+LfsZzBshsOkPCRvjTI07HfvJ6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753065901; c=relaxed/simple;
	bh=+XqIjqqaZtnv3dgyRp9f7Cn9o6WQ37JREJCAxKsXKaQ=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=trPESeuzHPdMQRGQ0WeyFZDGAYH6C2avPsFdt7fu0zXRhwqaHkMGShA8pfG9MBPtLdJ92Pois7gezI1ae9NDU6dZGYlUzWExPfZ7mj7ED9xby/FsPGCOuT0MQuVNwurwHM7spwdddnoapiMRE2CiA8s/NvWhxHBk60UlLd6zYc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apue.org; spf=pass smtp.mailfrom=apue.org; arc=none smtp.client-ip=115.124.28.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apue.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apue.org
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3083803|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0328768-0.00108951-0.966034;FP=16955630277272811992|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=luis@apue.org;NM=1;PH=DW;RN=1;RT=1;SR=0;TI=W4_0.2.3_v5ForWebDing_2144949E_1753065887264_o7001c175p;
Received: from WS-web (luis@apue.org[W4_0.2.3_v5ForWebDing_2144949E_1753065887264_o7001c175p] cluster:ay29) at Mon, 21 Jul 2025 10:44:47 +0800
Date: Mon, 21 Jul 2025 10:44:47 +0800
From: "Luis" <luis@apue.org>
To: "xenomai" <xenomai@lists.linux.dev>
Reply-To: "Luis" <luis@apue.org>
Message-ID: <7ec1afca-5d28-4763-a091-886e1c31412f.luis@apue.org>
Subject: =?UTF-8?B?eGVub21haS5vcmcgZG93bj8=?=
X-Mailer: [Alimail-Mailagent revision 3][W4_0.2.3][v5ForWebDing][Chrome]
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_M3LTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzOC4wLjAuMCBTYWZhcmkvNTM3LjM2vN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

aHR0cHM6Ly94ZW5vbWFpLm9yZwoKR2l0TGFiIExvZ28KNTAyCldob29wcywgc29tZXRoaW5nIHdl
bnQgd3Jvbmcgb24gb3VyIGVuZC4KVHJ5IHJlZnJlc2hpbmcgdGhlIHBhZ2UsIG9yIGdvaW5nIGJh
Y2sgYW5kIGF0dGVtcHRpbmcgdGhlIGFjdGlvbiBhZ2Fpbi4KClBsZWFzZSBjb250YWN0IHlvdXIg
R2l0TGFiIGFkbWluaXN0cmF0b3IgaWYgdGhpcyBwcm9ibGVtIHBlcnNpc3RzLgoKR28gYmFjaw==
