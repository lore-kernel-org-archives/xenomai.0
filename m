Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9718BC2F
	for <xenomai@lists.linux.dev>; Thu, 14 Nov 2024 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586408; cv=none; b=sbv3ezS/jnYqkZXZbkj0Ns9Z8ozE+iP6TE33vTUq8C4WV3D9+KzpazkGJBuQ8avW0o1DgqSJDiwDgrqfpXWn60PY5aMbWasxuuLlIRtNr6ymvasHlYjpuI8j2+fem7a0P2TYrL3sciJPXqIr9A3k7ojSuWMdZAQa9HSWmUMpif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586408; c=relaxed/simple;
	bh=6hSU+GhG+h8mdUZ4fN5Xc7RU0yqKc3B2Ifx/NYuU63U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkUAi1vPYGQIHLWV3PTU/Fm5sn82ykuTS+OPapdebPTZhishWBjDn/sPJhfSC9eqQAlT4G1VTHEZMVdB1zx+wPcFLzxn2IBUYnm2tdzymmTLK27aWdnKsmMqOxMOZAzG57AHf/E/Z00oLxV6irmQIJm4P6FjF+upHu8FuLOrMuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=NFdxmXVI; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="NFdxmXVI"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20241114121316418c999af943f416a4
        for <xenomai@lists.linux.dev>;
        Thu, 14 Nov 2024 13:13:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6YZYgGoF5HBPrnbUI4HinPkAGBpM/8TCBm+n4DV33Hw=;
 b=NFdxmXVIUE6Nor9Fzg484PrMITBsH6EMjviyqIf4UATQEuTYymx2KfT9euPebEwtbfRyMf
 GCL7T+yslTps6Shk5bIWeqAbTR4y7qfF5bcy3boY+2mjIVjbGqu1SGkwK+t2+uzkX672O3DG
 MiN5/Eoa1Vt8S6wNrrjYe4Ggr1GRCDh70mbE+YBfdA6n5cFSUMQDSC0wQs1QyYzikeID9QDx
 K5XqA7zWGRHH+ESNjOJxZY5mXHj/LykPZf+xAKyN7QA8z50pGUp7PGS+wD3lQ/Ii99sTKsXe
 Skb3d9wVxeHCmSy8iYkhyZJHCe7KTuliZFfjo0omAPGPIlK6G2WXqxAg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH v2 2/2] ci: Switch test job container to self-built one
Date: Thu, 14 Nov 2024 13:13:14 +0100
Message-ID: <3b9841a3daeb408eefbbc20c1caa34bfdc55b33f.1731586394.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1731586394.git.jan.kiszka@siemens.com>
References: <cover.1731586394.git.jan.kiszka@siemens.com>
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

Speeds up a the start of test jobs, avoids access to snapshot.d.o (as
used by kas-isar containers).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml      |  2 +-
 scripts/install-lavacli.sh | 23 -----------------------
 2 files changed, 1 insertion(+), 24 deletions(-)
 delete mode 100755 scripts/install-lavacli.sh

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index a40dbcb..853d929 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -93,12 +93,12 @@ default:
 
 .test:
   stage: test
+  image: $CONTAINER_REGISTRY/xenomai/xenomai-lava-container/lavacli
   tags:
     - lava
   before_script:
     - !reference [.common-config, script]
   script:
-    - scripts/install-lavacli.sh
     - scripts/run-lava-tests.sh ${TARGET}
   variables:
     BUILD_JOB_NAME: "build-${BUILD_IDENTIFIER}:${TARGET}"
diff --git a/scripts/install-lavacli.sh b/scripts/install-lavacli.sh
deleted file mode 100755
index ae61497..0000000
--- a/scripts/install-lavacli.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/sh
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2019
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-# check if Debian 10 or later. If not use the pip version
-# of lavacli. The apt version from stretch-backports cannot communicate
-# with the lava master on Debian 10.
-os_version_id=$(sed -nr 's/VERSION_ID="([0-9]+)"/\1/p' /etc/os-release)
-sudo apt-get update
-sudo apt-get install -y jq xmlstarlet
-if [ "${os_version_id}" -ge "10" ]; then
-    sudo apt-get install -y lavacli
-else
-    sudo pip3 install wheel
-    sudo pip3 install lavacli
-fi
-- 
2.43.0

