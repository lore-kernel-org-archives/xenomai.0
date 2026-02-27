Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8699449EB8
	for <xenomai@lists.linux.dev>; Fri, 27 Feb 2026 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207403; cv=none; b=A1Y6uqFGj+NVVMfofrfUZjHGKk+ZG2qVMVaPZK2dA7l9tRKhtVOKWLUTjXD0d2KGo18Es3gRCi8eDjVs2PDAJuM2Z8syA79T3uwbosf7CA9NHPxaeg7DPc1cNdbzHAlJdhtM3dc+eQOnG9kGaHZ0N2cmjDt8zWJZcYXcfzUjVmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207403; c=relaxed/simple;
	bh=/EsdR5DPK1EIjpf/66+pLtxzbgHTBOkd6E4+QI9pYRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mpg6WIr7O3zHjb4aUg/iP60FaFkPQrufjXwE/okFhBAyNBUJ93F8YbWDrr31nkCFMRylpzdUJheOyWpVH5Pte54qdT8fEdIXuhlDhNd3ZhWYsU46pdnPWRII+hdRgqbT3BSI5A6G4aBE+2Nfo3NHTfPaWKPMC6rAN6kJiU+SmJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=SUy0Gzdd; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="SUy0Gzdd"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260227154945ecd637157a0002074b
        for <xenomai@lists.linux.dev>;
        Fri, 27 Feb 2026 16:49:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=/Tgewl0NzyBpSvBoZ1OMXzAi9RNKjObMc7Qj849aeqc=;
 b=SUy0GzddmcdToay9EjJ3NHryxjVP7W3k6+AQ9aGSMZEBRdFExP2NCroaV6IwY0yszDz5Jr
 8KyGhRQMpWZmiWlg/JgeQwFbEhs9wH2jlL/yeld2aYSkvtb84l6CkkyH2eQucnBskxeRR5Vm
 1tB0me9ycymBCDXbWWRmlsUeTFDrYqsySBd7X8gCLxgj5rAObggghPLiKJzgz3Lm89hk6bfI
 Nb2lfhKw9JxUexVYg9aLUY7DD4K1F9xyMxZOjQ7UfPY3104A0PmoJBSOvHOF/BnnIaXUNPnF
 UNgBm5hGGoW2br3j4K5HQzQ2w/iksMkdANA9VekdTU5Eri356O8O/WmA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH xenomai-images] linux-xenomai: x86: Enable NETCONSOLE
Date: Fri, 27 Feb 2026 16:49:31 +0100
Message-ID: <20260227154931.2831872-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The e1000e driver has some dovetail specific extension that depends on
CONFIG_NETCONSOLE. Enabling NETCONSOLE as module helps to detect build
failures early.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 recipes-kernel/linux/files/amd64_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/files/amd64_defconfig b/recipes-kernel/linux/files/amd64_defconfig
index a0a516f..23170ba 100644
--- a/recipes-kernel/linux/files/amd64_defconfig
+++ b/recipes-kernel/linux/files/amd64_defconfig
@@ -1791,7 +1791,7 @@ CONFIG_NET_FC=y
 # CONFIG_MACVLAN is not set
 # CONFIG_VXLAN is not set
 # CONFIG_MACSEC is not set
-# CONFIG_NETCONSOLE is not set
+CONFIG_NETCONSOLE=m
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
 CONFIG_TUN=y
-- 
2.53.0

