Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440A72110E
	for <xenomai@lists.linux.dev>; Sun, 28 Jun 2026 04:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782622273; cv=none; b=S/657bIYqolQcPBZF3qKQP06CV23c+0ONS/g1Xgf3wRMyBqtc3je2y00s5R36rnVOd3beu3NnkLmkt3aXkiP/QW8bQnb8Hjw4K27D/jDjSpgNhTqhu+MqhISdbvGR23KkiHwzniFueEccKy5MJQsVw8sgiXDNwikJ+L6b3ItHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782622273; c=relaxed/simple;
	bh=OPdBJPXssuD9c2TFJa+y1ai4tdM/ZZtZOE6tuIaPI3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PDJeuf1HPSSlSJiyG4j0Hk8uyFh87O3iTjNnqiCgR0zaVUeXN7wB4dciQnLC4GBC2YbwpZBwcZ+fK+uKjKE1FcHfg6dj13htpejrtze/2WqLpyXPDk2bQAE1x00QDGsPCt1lMculBsKIqFqshtT24YVB7YuXVs1xlT3Qb6/80pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SO9z52ur; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SO9z52ur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=x/
	YjXH0hyUDwuPBQT9aEWvoR4BhneusXuRP/EiXgBG0=; b=SO9z52urfi+cxJeNIV
	ajPANWF2P5scCzTBnylhaZRHbbRZokn4/CDK6AF1t0nJbCbPo7qqiTyAxVM5LIaF
	ORD7kU+d/R/x4Gbe2ceML1rJREUD6dv9xrAdq1dQ3YUgvmV5JbcSxyaQ0yKvWaDf
	XzDS41mERGTaCPk0s7Pg1L0eI=
Received: from wang-Xenomai.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCXYGc2qEBqjBkzGA--.59914S2;
	Sun, 28 Jun 2026 12:51:03 +0800 (CST)
From: guang_feng_wang@163.com
To: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	florian.bezdeka@siemens.com
Cc: xenomai@lists.linux.dev,
	guang feng wang <guang_feng_wang@163.com>
Subject: [PATCH website v1 0/5] doc: refresh Cobalt installation guide
Date: Sun, 28 Jun 2026 12:50:54 +0800
Message-Id: <cover.1782585785.git.guang_feng_wang@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXYGc2qEBqjBkzGA--.59914S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF13ZrW7ZF4fuw4xKr1kGrg_yoW3WFb_Xa
	4xJFWvkr40qF93Ca4jgF13XFWFg3ykKr48AFZxtFsrA393Jrs8Zrn5JrW3Zr10ga13WFW5
	trn8ZF10krnavjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiUGY3UUUUU==
X-CM-SenderInfo: xjxd0wxbih0wxbzd0wi6rwjhhfrp/xtbC3RfhW2pAqDfyowAA3U

From: guang feng wang <guang_feng_wang@163.com>

Hi,

This series updates a few stale I-pipe-era references in the Xenomai 3
installation guide, mainly around the Cobalt setup path.

The page already documents Dovetail as a Cobalt-specific requirement,
but a few examples still refer to legacy I-pipe references.

The changes are limited to the following patches:

guang feng wang (5):
  doc: replace legacy I-pipe usage with Dovetail
  doc: update stale Cobalt kernel preparation example
  doc: mark old PowerPC and ARM build examples as historical
  doc: generalize ARM64 Cobalt build notes
  doc: update Cobalt boot log

 content/installation/_index.md | 39 ++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 16 deletions(-)

-- 
2.34.1

