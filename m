Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF081FB5
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 07:50:58 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230223074048b0372b227ae53c2fe3
        for <xenomai@lists.linux.dev>;
        Thu, 23 Feb 2023 08:40:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=n8i73CyRwsk9FBnA8YB8jtF3XnN2reW7TChEl5nnM60=;
 b=N8W0V9K8BbXjst2GYGrnrluNLEIkuMc5GQQIleWkx2g+K14wwSnSpeur8Gl0apCccphWJt
 ERiI3G0/qCiyg40kenr/hf+401bdUL+q5pBeRJXzUY0p0oBjIFoBy5PiBvrWDQ+P2oIOyVYv
 008V9RPs5Gk10d/Tr7y6LP5Uv7KmU=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH 0/2] Fix pipeline failure detection
Date: Thu, 23 Feb 2023 08:40:45 +0100
Message-Id: <20230223074047.3974956-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi,

a failing xenomai (smokey) test was not properly reported by gitlab-ci.
In addition some bitbake warnings were triggered by the option file used
for CI builds.

It seems that LAVA decided to report test failures now as "failures"
instead of "errors". I did some research but could not identify any
recent LAVA change that triggers this. Might be the case that I
overlooked something or the error detection has been broken for a long
time now.

I have one more patch pending: Enable compat testing for the stable
3.2.x branch. Let me know if that is of general interest. It helped to
detect and fix some compat issues for this branch.

Best regards,
Florian

Florian Bezdeka (2):
  ci: Fix handling of lava test failures
  ci: Fix some bitbake warnings triggered by opt-ci.yml

 opt-ci.yml                |  4 ++--
 scripts/run-lava-tests.sh | 17 +++++++++++++----
 2 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.39.1

