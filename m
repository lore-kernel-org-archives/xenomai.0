Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EBA49620
	for <xenomai@lists.linux.dev>; Sun, 28 Jun 2026 04:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782622283; cv=none; b=U680RckwPQdrkj4qyYVtSpOGgPYJlx7vCJ6+r7bMIGge2YX/u/axqwjlsaERGFRUVz3aVhg7lnvzoTp3qJlTUzdMwnz+7g+h2iX1TCpQ+fYKll+Zym1ZH5WvtAAcUVXaqoO3+aRAu1voDsND2yvkMp/JqeNi46P5d1TEh6njv88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782622283; c=relaxed/simple;
	bh=BCMBB7GHskrD78QwR1nT09GRsidz9++Yt8xScOYG8bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S3+s268Z87nV4yuEqMr3JcdJB56SXkw2GYq5+yP4L8dgMjOiUJ/RdUdt/ck2mjkKGa1fFQYE+Bip7Olxf8BcirH5MrbtW83b8syqWlAPHikYQbgdMRcWHqq4Jn2mXg5eEq6Ddc3v593o7ZQo3qWCC+Z2cfUJCPusQXuLfdmNp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=caXl6dDu; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="caXl6dDu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=WM
	d8Ql6Vw4nGBfIlwAhJn3DHDR5app+96NgECFixjoo=; b=caXl6dDuSDhHkjBiwb
	6WceQyhctchCX0zEJwY1niBMGMRLp3THDKdCL8I6fV40RdjmfZqJG64TGptEqd5l
	ERQhJ/P2BHWVHCrFxJYe8nAliUWq51lfe/ljYfeDaMw3/YTXbDO0DDHWqlDuQgnE
	y3T882pT8znmwGZAmk8z5zVJQ=
Received: from wang-Xenomai.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCXYGc2qEBqjBkzGA--.59914S7;
	Sun, 28 Jun 2026 12:51:18 +0800 (CST)
From: guang_feng_wang@163.com
To: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	florian.bezdeka@siemens.com
Cc: xenomai@lists.linux.dev,
	guang feng wang <guang_feng_wang@163.com>
Subject: [PATCH website v1 5/5] doc: update Cobalt boot log
Date: Sun, 28 Jun 2026 12:50:59 +0800
Message-Id: <6f8921003f90f662522700933867074755602bbb.1782585785.git.guang_feng_wang@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782585785.git.guang_feng_wang@163.com>
References: <cover.1782585785.git.guang_feng_wang@163.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXYGc2qEBqjBkzGA--.59914S7
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw4kWrWDAF13KrykCryUZFb_yoWktFc_X3
	W8KrWvvr45JF9rCrW09F1xZF9Y9ay8JryrJ3yIvF12vw1DAFnxuwn8Z34rAr13CF429FZx
	urn8t3ZrKr4I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNzuW5UUUUU==
X-CM-SenderInfo: xjxd0wxbih0wxbzd0wi6rwjhhfrp/xtbC+QblX2pAqEYCSQAA3K

From: guang feng wang <guang_feng_wang@163.com>

The Cobalt boot check still shows an I-pipe log message. This is stale
for the current Dovetail-based Cobalt setup.

Replace it with an updated Cobalt boot log example.

Signed-off-by: guang feng wang <guang_feng_wang@163.com>
---
 content/installation/_index.md | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/content/installation/_index.md b/content/installation/_index.md
index 12cf726..30f54ce 100644
--- a/content/installation/_index.md
+++ b/content/installation/_index.md
@@ -937,11 +937,13 @@ messages like these:
 
 ```
     $ dmesg | grep -i xenomai
-    I-pipe: head domain Xenomai registered.
-    [Xenomai] Cobalt vX.Y.Z enabled
+    [Xenomai] scheduling class idle registered.
+    [Xenomai] scheduling class rt registered.
+    IRQ pipeline: high-priority Xenomai stage added.
+    [Xenomai] Cobalt vX.Y.Z
 ```
 
-If the kernel fails booting, or the log messages indicates an error
+If the kernel fails booting, or the log messages indicate an error
 status instead, see the [Troubleshooting guide]({{% relref
 "troubleshooting/_index.md#x3-failed-boot-klog" %}}).
 
-- 
2.34.1

