Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A7E402429
	for <xenomai@lists.linux.dev>; Wed, 17 Jun 2026 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706128; cv=none; b=M2szORMRKyMGLluSUAaO8HFRAa/LH+sbVmU7f+cGpzy6k8okWYirbaLH6xMXVLsHz4eggNC1pppuXmbJeUXPRnLReD+qGYON7pPcFiZZVHpzbI83a2o8eU4veKb2QgNLR5MScO1XB53DWvM/JjxA6QiE/fX63Dr8l6cbb+9p6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706128; c=relaxed/simple;
	bh=XINKmpoU8Fs/QSFWkazcxyqS/LXx9p24LbNMsmx0kzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tmQq1+YB3HUd8ZBm/6zr7/9RSuBo0aqgbvsdrKYfCUob21uGiapzNs86ofqbHfMy05Ki0+f97iF3/agxNCgEAQCzRiC/1vTnqtlJSnWaSx7CFS67e5Q+aSASxLMH7CDfb+nlszswL3jwkCgQ9eBHMND5uHxrTmGmf84mfu8ACJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Oj1a4CVl; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Oj1a4CVl"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0AE793F67F;
	Wed, 17 Jun 2026 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781706124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x0aVciLTFykBxH3tzEQj5MBU+tAln6Y3LujBRPjE3/g=;
	b=Oj1a4CVlLlxrG5c53wUi5fqMkQ9TxLxqEi0EeVFyYOBmh68yvPjs5pXnBfNF7oEjyzCDWg
	19UMcV7WEI1OQdHg58ph1ueAkchLm45doaOJ6e4Vz7lVm8AyfYykmah0u4KF7geOBZ6xoH
	YcG4XmrsLjc2mLaas9Lc62ilR1ki8QltUpg6+KOwl/YsVDmDTUHHZ5ZXsoSpkUc+ivs9ty
	HRELmR4pcHNTnfIiTyQk6D9kEhzdO23FZluDLsmUzdpvIA8+x3NcyBEtfuZj6wJhxP00tJ
	7dRHYaSUY2eMxdeG+cSnLFTEVNI5PDTql0MWDLF0zTCou6dUTwMXnWKSdBsNLQ==
From: Philippe  Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH v1 0/2] Fix budget tracking on preemption of SCHED_QUOTA thread
Date: Wed, 17 Jun 2026 16:20:09 +0200
Message-ID: <20260617142050.477809-1-rpm@xenomai.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTFq7K0BBxwPI70Il+JNAQZ49wytXfwdH46FWj8lFsZ+sRcxIn0dgklGNRF2tRPf391a/s2MQF7V17sfHcajZTEXeQs1tRozvxrwKoJN191tzNkFkkUh7jmcgFgBi4sgyRQL+FrEvduJAYxoKNyz2WPd3Z65/AA696P7XLataKCyyMYYn9mLVEvg8vZ7jq0sZ4u4npyfp21UwU8dsglypoj7MZk4v7A2CCBWb4Fg7i8ePKfqrMzemGBcXHfI61DSoWxeR2Qcfmwz6RK381gTrjmAmmZj9gTkmJVOfKBe5NZNt15AUWp4qv3gj3XBGyWb8Nbqyr3BlZgHLZB5k20nj6TERelB4GTJftI669+Y4zDn/6PDEdxnB41wM7fINydEp1VS0HtTSyLSZcOllbEr6Csr/CvuSdlS4SIur45QpEt9hLt2cOJPHR9//Dp+KoG8SbmJ6lVyDtSudJbzmxcuae/kbZprOc5nMyeu18stai7ac9YctVDh+nEKAtQQIjKNP7VtwLM2c06FrsD3T0j+OrCirWiKFSVpR//lz6ABD0DqpFIqUlm178Gx0BMJ+V70KDFm1HQSiWwFlZ+ChQHaJ10ujwJbGf1484/BlFEf5fMBbfky7n3pngokDgluFk/SJ90I8IjU8meC40JbCb1SYNtaJtwh0ZYIT5V29f/nWJQYiA

From: Philippe Gerum <rpm@xenomai.org>

Consolidated version of the patch series following the recent
discussion.

Philippe Gerum (2):
  evl/sched: core: introduce schedule out handler
  evl/sched: quota: fix budget tracking on preemption

 include/evl/sched.h       |   1 +
 include/evl/sched/quota.h |   1 +
 kernel/evl/sched/core.c   |  20 ++--
 kernel/evl/sched/quota.c  | 201 ++++++++++++++++++--------------------
 4 files changed, 110 insertions(+), 113 deletions(-)

-- 
2.54.0

