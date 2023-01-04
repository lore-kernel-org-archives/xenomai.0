Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC42F27
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 12:17:35 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202301041137185262ee7edc997bb499
        for <xenomai@lists.linux.dev>;
        Wed, 04 Jan 2023 12:37:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=6doXk4sSlHPK4ef8QyBl2kKNlEQf1wtR0Trt8KGqMoI=;
 b=VN1ieEi0/rl9JCpePeyFGDQ0Wl+17OSBCVh3rcLKbwVGdeuPynFiWZSyN1PY+g7sh7eqIn
 dX6T4N+umZ1fcRXoJB4MaPL7aakZ7/xyVWdT5EpkEKfop9W7YcQCcwRd6u8XfyyN3PX/aB0w
 isiqCSR1bZCUesD4fiujJuacV/+xk=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH 0/2] Fix CI build failure if DISTRO_APT_PREMIRRORS is
Date: Wed,  4 Jan 2023 12:37:13 +0100
Message-Id: <20230104113715.2872917-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

this fixes an issue on our internal CI infrastructure where 
DISTRO_APT_PREMIRRORS was not set. Now both worlds - with and without
this variable - work.

Best regards,
Florian

Florian Bezdeka (2):
  ci: Variables block cleanup
  ci: Update documentation for build environment specific settings

 ci/gitlab-ci-base.yml | 2 --
 tests/README.md       | 4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.39.0

