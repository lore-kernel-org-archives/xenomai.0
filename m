Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B62593
	for <xenomai@lists.linux.dev>; Thu, 27 Apr 2023 12:36:43 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202304271156249fc649198b4f28d605
        for <xenomai@lists.linux.dev>;
        Thu, 27 Apr 2023 13:56:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=3i6apvG71cZvvN9n0SIKb9zRUpUuI1VEmYn6bjQsflI=;
 b=aXU04V1l0QnoQNL/ukyJReJCDdSaB/kKwTyeAByH6BvpDYtGWWv5AikxcqCB2s1Djo3qnk
 Yis8y+d56ec9ogL7D/ryxEY+6j6uJjD5ZZF7cuxGqdNH5FLU1am6vHZ6P57X/qKdo/jAyPcT
 28ir9Fkf602rIgUmTu5kPpx4Wu0Lk=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH xenomai-images 0/2] Update demo-image to deal with the new
 testsuite package
Date: Thu, 27 Apr 2023 13:56:17 +0200
Message-Id: <20230426-flo-testsuite-extraction-v1-0-6f026bba9c39@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOFiSmQC/x2NQQqDMBBFryKz7oBJbAu9SukixlEHYlIyUQLi3
 Tt0+R68/08QKkwCr+6EQgcL56Rgbh2E1aeFkCdlsL11/WAfOMeMlaTKzpWQWi0+VI3QPae7ocE
 aFyxoPnohHItPYdWBtMeo8lto5vb/e0OjlDfPyJtfVH2u6weawrERjwAAAA==
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

This series depends on the previously posted xenomai debianization
patches. Both series should be applied in lockstep.

A full CI run was triggered internally to test both series. The run was
successful, all tests passed.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (2):
      recipes-xenomai/xenomai.inc: Split up PROVIDES
      xenomai: Install xenomai-testsuite in addition to xenomai-runtime

 recipes-core/images/demo-image.bb   | 27 +++++++++++++++++++++++++--
 recipes-xenomai/xenomai/xenomai.inc |  9 ++++++++-
 2 files changed, 33 insertions(+), 3 deletions(-)
---
base-commit: 61317a5eb9b02c09f3400b7b60c8333219a772cc
change-id: 20230426-flo-testsuite-extraction-37d51e4213c2

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

