Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2BF55C3B
	for <xenomai@lists.linux.dev>; Tue, 14 May 2024 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715693595; cv=none; b=bZK7MmAaBPYUp51isZe+s98kj8C/nSUA2BOLm9ibtJgxQ0uMZRwGSeje7va0rcu9BU7vM7tmv24r+OZR38Ya/Dm0ofHOrvbORVpqM4quNzs1egN7uaEGyNg+CObReU3mOB8YQuMY4U+Qpogqs9VHq7YyYI9kNm/sDmYqPbX8aPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715693595; c=relaxed/simple;
	bh=jRepRRleX/cKxB0zznDomsEUT2wtBTPM7omAHLOdYyU=;
	h=From:To:MIME-Version:Date:Subject:Message-ID:Content-Type; b=NhJvjOdQ/XjDdEQnWd75Oh+Un+9CLr+imOyLuydWguXGwLuvVtafCLiMj3Gb93wHMzeSoBCxWg5pZ/Eg1wryFFpg9r0qFj/Vzm9Lf+4OQN6zLmRcN1X9nfF2cKlQ9BegujW8tJ5BKOWiNhzshz1BhxPj4/wRLvZE6u9xUsFyxJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=thom.fr.eu.org; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=MRuS+j8x; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="MRuS+j8x"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 87AE8850806
	for <xenomai@lists.linux.dev>; Tue, 14 May 2024 15:33:01 +0200 (CEST)
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 2E3A05FFC0
	for <xenomai@lists.linux.dev>; Tue, 14 May 2024 15:32:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 44EDWrLj145890
	for <xenomai@lists.linux.dev>; Tue, 14 May 2024 15:32:53 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1715693573;
	bh=jRepRRleX/cKxB0zznDomsEUT2wtBTPM7omAHLOdYyU=;
	h=From:To:Date:Subject;
	b=MRuS+j8xY1JEdHKvpwpu6eZ4j482GBL68qeXPeNIjYpy78ySLycWQBuYMoL1WJJhQ
	 tfezy86y8YDoCsrzYHjrDXLNUlPktU02NViSdnFaWLWmTx9ZKO5Qk34yHows2RMLLM
	 Q0iIFXB0RKBKHHCQ5oxhHdARpPtJ6VGr2mHb6MStQlgkyNmXG6UV4mEOuxecJcFuCD
	 HBaJg9w6kwyeWHvJXFdxgFaWmNacoh5vVc8kskpjSa5xoDnIsdQC0fUWJxYtuQXajb
	 NH8YwxAKAw57j5///1plOLsZwxtip/dBflzxjWQ8noFweMh7bScFkTYzbMv2YK5oUV
	 K2KfO2M+kOCEQ==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
To: xenomai@lists.linux.dev
User-Agent: SOGoMail 5.0.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 14 May 2024 15:32:52 +0200
Subject: Dovetailxenomai handling of heterogenous cores on AARCH64 architecture
Message-ID: <11ec-66436800-89-7933f400@102269812>
X-Forward: 217.109.173.233, 165.225.204.99
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Hello,

for a future project, I was wondering how/if dovetail/xenomai could han=
dle scheduling RT threads on heterogenous cores (A55/A76) on AARCH64 So=
C.

Thanks in advance

Fran=C3=A7ois

