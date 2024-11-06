Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B87D1DA63C
	for <xenomai@lists.linux.dev>; Wed,  6 Nov 2024 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892467; cv=none; b=F6hFCgljIF58JnJxHjE2pfrd5kZRJw/vNvWakhLXpvBiEohOtXhIs5TZV+wVF91EBHTGD+qeD8j5dB6ljpyOmU0aL0CDQFwAlw5OcQV9ZrO/p/1utNEi13ZrVYX/p74B8h/8yuChuiwudRdXBmHo0unGDzjVKFkfPLSx7zWrO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892467; c=relaxed/simple;
	bh=xB6PFqk+blk7NkzgwpF726YN/d85irx6MlWLW2QaRBU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PbneR+/KOKxyRj7M8wwoHuieVK3Rq3PjsKAx/urDoPVbOBt+TdG01nVACa9nMl277lME2OoSqHMYHFmsW3n2UDneC98B05GY8CCaLO6+64yeDuWcvjVhuYprkUBXawEsvk1g4V6y5cuxJyWEV7G7vU+fs/5kIrOnRhTzUCN902E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=CBFxwntH; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="CBFxwntH"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20241106112741bb0fac5679b0633420
        for <xenomai@lists.linux.dev>;
        Wed, 06 Nov 2024 12:27:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=gO5L0ScZdNmI+mLMG3R/t/cdGwddy5QP7IybRxP3WXI=;
 b=CBFxwntHt80diMP1VgX6COTxihB5xYhRXA0MDfwEcyTUxmSp6TKUW3wDaFC9ZACBhNMPLi
 k+H1Gqkm5oM/BMya2Vslx6CmOEDcVhYL1Lx0Pk+UlaP/ElQoP4ucP4FcZz6RRopty3/pmTX2
 ZJhcfqaip6kYDqMZwptrktZxDJWFQ5rUOnTtzCxSO+Jf9T1ToeX9OG2tZaUkwnzW/rbcGKq1
 WAIpMQG+FudOvWGbbXh3qGEC8Zs9Eotw3xKfk/smedb8tPNz3/yX4ZrnfnRtjOG6YEyhGRvf
 ZV4JFzFag5ESjp7WtKKvf1LfKa/5YoadlGKz/KkGkvps6FETwQ7jorrg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 0/3] arm64 compat testing
Date: Wed,  6 Nov 2024 12:27:37 +0100
Message-ID: <cover.1730892460.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

This adds one more target to the next pipeline for testing compat on
arm64 on the RPi4.

Jan

Jan Kiszka (3):
  ci: Add missing kernel cache tag to compat jobs
  Update isar revision
  Enable compat support for arm64

 Kconfig            |  2 +-
 ci/compat_jobs.yml | 24 +++++++++++++++++++++++-
 kas.yml            |  2 +-
 3 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.43.0

