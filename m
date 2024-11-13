Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2567C273F9
	for <xenomai@lists.linux.dev>; Wed, 13 Nov 2024 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509016; cv=none; b=PUXUpyPnPQWZGNkv0IEYnVnBNMolXPCIufZfyBAm3MAeP2wT2bJsVw+sVZIof6x7YHJouvbHVj1hxQgESj7Jjf4iLHVT2WMPExJw6e9KkLO4QeMJgqd29uJl5X4FFC6HLg6RCAnblQZ53ha/dp3YE/p47cfniDvp6JXanmA8N7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509016; c=relaxed/simple;
	bh=6hSU+GhG+h8mdUZ4fN5Xc7RU0yqKc3B2Ifx/NYuU63U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XglIJd2oskQXwGFQbImvx8Kx8mt5NJm6/rWnJMJgTMsNhpsEY1f3BlO50gUEX3yoNrqxRqTlDP2mMpWRmACCZwOKWH6gU61rWdZkPY06qfkq4QMQlOI/4jjR9tBx91592Vzo9PkSfZxTlpKb57Co20bliD3WuSSELZ5X3MtAzY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Grc8CW50; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Grc8CW50"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20241113143314465365a3045c569216
        for <xenomai@lists.linux.dev>;
        Wed, 13 Nov 2024 15:33:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6YZYgGoF5HBPrnbUI4HinPkAGBpM/8TCBm+n4DV33Hw=;
 b=Grc8CW50F3wGyTzBT10X5023xdnyNxV/gVC433US6a3l/xB+CkCQzOMeOOAOT7J9YAiNZL
 /jmZQ64uqwNYX69ybBLJ4p7KOhFfeoGJj/wYdffb2NCONb1TDR72ur5y2g6DZS9WUem1QyIf
 mmNd97tV8uuU4fZY2tbszHi6bfymPMFHOOgsIfp2/IUGR6UQA7SKSJXCmcSN/Q0Re1JvK22a
 Z772c/BGDXyH14fvOWQN17seUjG3+G4xiGgkGSgbQBYyE4CWmzarepLw1YopyhgiqLBXRMoJ
 NsTJkPxVwGGCySB2pk6JkNrArWEf8oVbwqBEHbS2CXERUdtyJWhGzBqA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 2/2] ci: Switch test job container to self-built one
Date: Wed, 13 Nov 2024 15:33:13 +0100
Message-ID: <c91236daefb7e3701f1cc20bae8027ed861f580b.1731508393.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1731508393.git.jan.kiszka@siemens.com>
References: <cover.1731508393.git.jan.kiszka@siemens.com>
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

