Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC09F28C866
	for <xenomai@lists.linux.dev>; Tue, 13 Jan 2026 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768305009; cv=none; b=pgtvAeeUxaZOqKBjUa46yf5UmQGSeM0inZz5qKqjBRTLsP12IqN69vWptfRNs8TxCjITT34Vgw7Trx+18tERiFLUtk8ty+hVLcp7W6uwV4arKdN8c0ao4siy7n2GF7gCrm3dA+97TYjnDPD5WkFb9LL41WO+zLYdu535/GrbCTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768305009; c=relaxed/simple;
	bh=g4pACFFzdvQQz8QfFKqSDM3WaO/jiFz8wHtcpy+mavI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZfygJTGfBiaQXf6X3B+cM5WcyXc4E/mK/DPOk6ELdYLJilG2gGiOVEK4rAVn2Cbbzzcanmd9Bqt6y1QSYRbIw1lwDEH09ZOZwzVLuCD5HDLDdgkgYHRLJvipki2zoiVIhO9daCK2ts/4wH5WSp5GNMWxT8F4Z6GzW7sYJR6rUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=NCAw8od9; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="NCAw8od9"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202601131139548fd3adb8b1000207df
        for <xenomai@lists.linux.dev>;
        Tue, 13 Jan 2026 12:39:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=6ptt/+FwE9I1BxMzjdag8nKIUKNmKAZ2b0itLgY2/QE=;
 b=NCAw8od9JS43/z4pgqGc5T+XCmgRgIRSB5j1qmvNdBp783PRjD2xEfRAU9v43m58oWbmm6
 6lShaaVl/9pbeG9fWhp0UtEKclpLM4mbDvsGemASp32+O1jCXKV4fYoVc768Fjd3y7ZWOJSf
 GSMEK4B7BMfH8J7vbDRCm3LHl/mfCjfCog0jZWTDc7B5MolRfXbVmYLOJAz5XclruXUrI606
 HR2mEmcqOPEM+YudQvb9W0tWJINROoAvesvHqBt8UjeR72/aPFBk2S+cnIMGWOKWWxKqKSde
 hjdwONKOTnZE6FbwJ7OCgzSxWQkMkJRDgu+K8IROtdDTeFqJvaY86vOg==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v4 0/3] Trigger CI job for dovetail
Date: Tue, 13 Jan 2026 12:39:41 +0100
Message-ID: <20260113113945.1038227-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Hi,

this adds the functionality that if new commits are pushed to dovetail,
the corresponding kernel builds in xenomai-images are triggered.

Changes in v4:
- Fixed https://gitlab.com/Xenomai/linux-dovetail/-/pipelines/2258056311
  by adding the same rules for trigger-xenomai-images as for set-vars.
  Pushes to any branches not matching the regex
  "^v(5\.(10|15)|6\.(1|12))(\.y)?-dovetail-rebase$" are now completely
  ignored. Tested for v6.18.y-dovetail-rebase and v6.12.y-dovetail.
- Fixed https://gitlab.com/Xenomai/xenomai-images/-/pipelines/2257965129
  by setting XENOMAI_VERSION and XENOMAI_BUILD_OPTION as top-level
  variables in separate files and including them based on rules. That
  way, they are for sure set for the build and lava jobs, which wasn't
  the case before when they were set in templates. Tested for
  v6.12.y-dovetail-rebase.
- Renamed ci/xenomai_3_dovetail.yml to ci/dovetail_xenomai_3.yml to
  match the structure of the added files for the xenomai options.

Best regards,
Clara

Clara Kowalsky (3):
  ci: replace LATEST_KERNEL_VERSION by KERNEL_VERSION_WITH_QEMU
  ci: Add build job for pipeline triggered by linux-dovetail
  ci: Add CI for linux-dovetail

 .gitlab-ci.yml                  |  8 ++++++
 ci/ci-dovetail.yml              | 49 +++++++++++++++++++++++++++++++++
 ci/dovetail_xenomai_3.yml       | 35 +++++++++++++++++++++++
 ci/dovetail_xenomai_3_3_x.yml   | 14 ++++++++++
 ci/dovetail_xenomai_3_next.yml  | 14 ++++++++++
 ci/gitlab-ci-base.yml           |  4 +--
 ci/xenomai_3_3_x.yml            |  2 +-
 ci/xenomai_3_next.yml           |  2 +-
 ci/xenomai_3_next_long_term.yml |  2 +-
 ci/xenomai_4_next.yml           |  2 +-
 10 files changed, 126 insertions(+), 6 deletions(-)
 create mode 100644 ci/ci-dovetail.yml
 create mode 100644 ci/dovetail_xenomai_3.yml
 create mode 100644 ci/dovetail_xenomai_3_3_x.yml
 create mode 100644 ci/dovetail_xenomai_3_next.yml

-- 
2.52.0

