Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AA233953
	for <xenomai@lists.linux.dev>; Sat, 20 Jun 2026 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781973899; cv=none; b=K2OEn5KD+N26fsYSTNUq4Dq/ZMOHwLeYeB85LGw6lZPJ02XSV830mPiL2RTQaFfqVG1VI0Izol2XXXPQ0nrR+yLY8BoUCjTrHMz0xZ3SQOxyZem8LXYk5RzOdrvVeTziKzK1dtoi4JX1GT1p6lU00+iSc6rADsT4fH0Hkzvd+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781973899; c=relaxed/simple;
	bh=zn9XeWljI7z0DKCnhFk1cemFGN0j1LfLI5/7iaZaCs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ft4sZpNHPpeCdVo2XqLadih+w4jLLn5dKHNWub/4nRF0gLy/hc3yT/n5sI3bBMi5eF9meeUBLX+Z6Xz8IK2eNNUloKAKr4fF6O+ReL1UBP1pC64wItK2TORhyhip7NHm3dlWZ5L5RslOS3kseMg4kqqAvCmzVuPYoTqRyWK25v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=OIXle5B0; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="OIXle5B0"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 70F8F580D4F
	for <xenomai@lists.linux.dev>; Sat, 20 Jun 2026 16:16:36 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C1753F5D2;
	Sat, 20 Jun 2026 16:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781972189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qIoP7fkSdPv0lVfr4FGifMTbWr9VxwHTy8SjEs3hYBg=;
	b=OIXle5B0XLGGPeUIWyPOUrMeyvCP7eUbmYHcmBW5cZ0W8BlQ9qPtVCqkXliAwNirtG+ODC
	VZanEykcqv4JKYGDjN+I9ZXYhe2T+PZwqLtAJWR0yDenpDeatsrANOVo3464+8JO4S2JHp
	uqUh1IAct/PEbgELgn4WNf2FvxDoSeRg+ZS2ySitZxXrxgvNz4TfXR+X7XjhJynOwsfF+k
	SxBje/CePejtZF3W1lNxwLdEu+y7YxTB48Pydc26WY6H2vKBTIiKQ866uDiHVwheTE5ADZ
	klz/pgNaf+J/4AXnTR+aDaK99nNsx+Xj34XYmY3WlZlrVcIYTb2w+RSFNEeMpQ==
From: Philippe  Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH v3 0/2] Fix budget tracking on preemption of SCHED_QUOTA thread
Date: Sat, 20 Jun 2026 18:08:43 +0200
Message-ID: <20260620161531.422484-1-rpm@xenomai.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: 0
X-GND-Cause: dmFkZTFuYwiiSln8IAQSqKH0sG06jQWIWzpLEo253AuBczaA6rCXaGsRJ2qz8gdpHmA22IzVOYYEed/pZKY3xQoWgwSbD4LCx/sA3ET4EfYNBgqfY4PY7a8Kqs52yeAGXxIaSu7xzcyyQsrFGFdY9lULnMU/2aGkhJ7JaQqKJW+7xNtj56IXirngrmrRwANqWjkbdpn+twJI/kRx5/15N9mhllQg4lKMTvEqg6baob4jYM5UmHwZ2SjCDJC0Tjnl9/t5JltMBdzCvGqne8Lpt26ZuXxrqu7dWJjgFKL10Tpmw/zib14cV3LwtGROKS/guwngEM7shi67+LEDYvblI6WetTmMuCxXaJNCyf9IfA/HMjcd88BWS6gAFKMriHJunm/CREEjeEQETCC1QZGxTtyHzH2De4eiDvRb3Ui+nArZJmrxvR54wEIxjrpY2gjIUVmHrr3QJFLHqWtGmZo/VpTX6niqzEI5hwomBxKqP3Ho/mtVntZyxRbgeC1FpWbGxg+5iX1rZ6pXba8VYvAnTjczSbHR9VIeU6v9dKgSM7ebe2PF9hEGTnRtdPGXRAoEvbJGoy1aK2z4U2fTROzWTB0Fv5LMQMPDO4qn28dY0kOLCKx3+GiPxfJAz5HkNhYgXZ0lnPCjngX8lXpQGV2rPrY5okyTpRwHhX6JzT99pPuXYfNAnw
X-GND-State: clean

From: Philippe Gerum <rpm@xenomai.org>

Changes since v2:

Reverted the runqueue split, the SCHED_FIFO and SCHED_QUOTA threads
_must_ share the same runqueue in order for the quota-bound threads to
compete for the CPU with plain fifo ones (provided they have runtime
budget).

Philippe Gerum (2):
  evl/sched: core: introduce schedule out handler
  evl/sched: quota: fix budget tracking on preemption

 include/evl/sched.h      |   1 +
 kernel/evl/sched/core.c  |  12 ++-
 kernel/evl/sched/quota.c | 190 +++++++++++++++++++--------------------
 3 files changed, 105 insertions(+), 98 deletions(-)

-- 
2.54.0

