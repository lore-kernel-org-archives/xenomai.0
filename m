Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F745F56A
	for <xenomai@lists.linux.dev>; Wed,  6 Mar 2024 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716444; cv=none; b=t/knKk+kUqyCbRi8cGsaY1hUP+P7WWE7RCtaCm39xYwV46fH5T8NWccnmZGUAn7RPvx6wM8EqSUBG732nm9T/v+KWTeYfsC5GVWebQmnhqBdLARdC68+1aDctZWkDcXCSv/q+T/Eqp/QGDLsoDnZ2HIe3tIQbIR8UQDtUOSkuM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716444; c=relaxed/simple;
	bh=m1FmVPOTMr13Y0L9cMgjoq2OlmGPHNnZ807CYP0CS5E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hb6fbgjLox7m/06Ao+txNJK5sIuBkkX10HXmgQ2xgixhaRmQkrNYxGPsIyPzGI0coFrsE169WhqFWh5OSqDiv1VUbT/VK1s3rmchJewaee+ZJzI+Iu05lkFUVt8N0ArojLAKy2BCJNKWIJkU5EedtzCdbjZ/8SnuXBDx/9Bdggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=HBFhTJof; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="HBFhTJof"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240306091356be97f31c8bbedd21fd
        for <xenomai@lists.linux.dev>;
        Wed, 06 Mar 2024 10:13:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=1X+ZWQMxIUSwBHp1K9QbMjmZd3RFb6PRskd3m8CZ+pM=;
 b=HBFhTJof6/1x+nkfClZhs0XMly9qANqK4VNqDs0UnsTj1jcMEfptj5Rlsx0sy9QjH4mt/9
 xbHI2BBtCfrn8gD4fQ4wYNJzWZaBhBF52nsJwMO/ltoyb6PgxWF9wYhZBBq4H4FhQngvsdU3
 aM+rOGO+VwhszjFi9KuOeFH8HQxLM=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH] linux-xenomai: x86: Disable group scheduling for SCHED_RR/FIFO
Date: Wed,  6 Mar 2024 10:13:36 +0100
Message-Id: <20240306091336.2365758-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Trying to run the latency tool on the example image on an x86 board with
Docker installed failed. This was due to the fact that the use of
CONFIG_RT_GROUP_SCHED results in Docker and its child containers not
being able to use system functions like sched_setscheduler() to raise
the realtime priority of a process.
The x86 defconfig has been synchronized with the arm64 defconfig to
disable support for group scheduling for SCHED_RR/FIFO.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 recipes-kernel/linux/files/amd64_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/files/amd64_defconfig b/recipes-kernel/linux/files/amd64_defconfig
index 2b7e63f..4f58c34 100644
--- a/recipes-kernel/linux/files/amd64_defconfig
+++ b/recipes-kernel/linux/files/amd64_defconfig
@@ -154,7 +154,7 @@ CONFIG_CGROUPS=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_FAIR_GROUP_SCHED=y
 # CONFIG_CFS_BANDWIDTH is not set
-CONFIG_RT_GROUP_SCHED=y
+# CONFIG_RT_GROUP_SCHED is not set
 # CONFIG_CGROUP_PIDS is not set
 # CONFIG_CGROUP_RDMA is not set
 CONFIG_CGROUP_FREEZER=y
-- 
2.39.2

