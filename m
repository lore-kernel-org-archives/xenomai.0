Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9BE3624A6
	for <xenomai@lists.linux.dev>; Fri, 28 Aug 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931310; cv=none; b=sDkyYr1zaN4OcDYANDx+3PKNBk0is8QcMHACWDQ5L4Q/K7TMd/Ic+eeMoEBHR59ksE3kI6p9pp8pzb9tsB/w8iwOv8kBuuJhWXKk3HPoZbNEVgtN6QiPyrR22Hf+mhGKB/R2NGzqA9Dn3nU5gIOC2gKGUeXwaExfVZkfw653k8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931310; c=relaxed/simple;
	bh=a/6PUQUyMqVDRHwYees/mema8pCQ3fTAPncs3xWmpIw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZI6SL3K8jzpglZoeYUvQu1UGYOwbDyteFS7nsYlZWjLqVIJLsUvfMWR4VHx0+tDj6aAVLiTcbcnEoxvAmbKnD8kIxO6eDLUvM9vrMAIT6c3Za0Wr+D8Z3AZavS5GacNybGqJfOsLRd8OXWnkXTFT6a/VCd93HnKlgGu0FrmFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=g3r/dgEc; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="g3r/dgEc"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260828153457d6c077d33a0002078b
        for <xenomai@lists.linux.dev>;
        Fri, 28 Aug 2026 17:34:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=3Nem9Y1p/p0TsIivGQfU+DmfIjrB0pTlcSqkhglij+o=;
 b=g3r/dgEceGwJM9tJ5tCY/dVEsd1N9ynQfmnCrHnz58CtVMAf8lanhIsGj3O2k3bV3Gl2Hz
 k2ReRQYJmWeiR35NdRRl5J6nt4ujBzhzxeANQ1+6PUzkTqE57neBZhuwrGU3h5z0G3PdZgJk
 vCX82a0iC79Je0T3XhHI/FcPMNxcxalqpMhjjz7eCmjUl0wJgJpejaSZHDNHXSmimP/UzrQ9
 meC2gidoknpODFj9eEotrNs/wSxzf2jULP05VK1fH3yT9W9OVC+JcMqi8/7PhBjGcBI9Y9mi
 T9IYZK62wNsrw9rVNVn1bCkhCwutC/Uc/CBZvf9MjUN7D7SQKgnnPhnQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 1/5] linux-xenomai-4: Switch to next branches for latest kernel builds
Date: Fri, 28 Aug 2026 17:34:52 +0200
Message-ID: <fae473678d1cfb500aa18938dff88644a8c7730a.1787931296.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787931296.git.jan.kiszka@siemens.com>
References: <cover.1787931296.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Those are now marking the tip of the xenomai-4 development.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-4_latest.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
index a542e80..345809e 100644
--- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -22,12 +22,12 @@ python () {
     if is_kernel(d, 'latest'):
         cmd = 'git ls-remote --tags --head --refs https://gitlab.com/Xenomai/xenomai4/linux-evl.git | ' \
               'sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | ' \
-              'grep "^v7\.[0-9].*-evl-rebase" | ' \
+              'grep "^next/v7\.[0-9].*-evl-rebase" | ' \
               'sort -r -n -k 1.4 | head -1'
         (ret, out) = subprocess.getstatusoutput(cmd)
         d.setVar('LATEST_KERNEL_BRANCH', out)
     else:
-        d.setVar('LATEST_KERNEL_BRANCH', 'v6.18.y-evl-rebase')
+        d.setVar('LATEST_KERNEL_BRANCH', 'next/v6.18.y-evl-rebase')
 }
 
 GIT_BRANCH = "${@ \
-- 
2.47.3

