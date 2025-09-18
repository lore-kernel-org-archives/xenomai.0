Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263322F9C39
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210977; cv=none; b=GzjlUH+JKA05afX28uDrt9NWf6IezFfNe7LSHOsUeUNdAl/CDOh65VivQofHRLXFQ9GFfxtcm1JRqJrLGpulCJKrCgXbPzJDljrlDjceV+m0SHL85x3KOknu316espOhw0jkJhQr2mr30psIkL/M4lQNRtA29uFmiKI81YBlssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210977; c=relaxed/simple;
	bh=3wzHxsxHN9cQNAtQGnrnDqc56cInqgts919zgPoeaoU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCV/BcF0r3jyFQupJ6hc6zT7VXZfJT1RwPhMoJgOgDwoCCMYmKW4CKNPbyCa0F2KArRUeu9qT0O4xtlx27hyohYJEMCnENIg0eWrN4BbcedIviSJHZqxvK08oUfsdn9kIGF/YQ0KcpeqkEhcgmOlGNYYPZhFbd4v/MA+4wENn8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=cvySMLg3; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="cvySMLg3"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250918155615871866c5740002070d
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 17:56:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=MQjpyo8UWQ4aU6CQei8+cpPnOqkGQKzT4lsn+kI1sds=;
 b=cvySMLg3xKqS4NrlqLIzYfh5tuHNxqgjw8N0+OdBHMMJglCRoI+rwEIwoQjVX43DCwI2/b
 z/q4PxxcQiyvGsSeg4H7570iQGTsYWIWjONAgXNxm2hnAsDAxjKnZt3N9tHXH4CNHYlVVQUn
 DBfz4NaG0VfTUvhQ2N9HN5c3OkwWaYWSy3RKYI1DiEuzUZKW9qHWn29IbhJ+wc7gO3Y8ndhh
 ziBMvVfFWO1bbcpbeDdW3aCA2Wnu28F9Nr9a2nKyGMDn6thT10QnMRLanHynFfd2uOwkNpxB
 5dmNWDyxtQ12bwaBO6aixuiwU0b/2E56emo/dHxTA9IdegwmEimcenyw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 11/13] ci: Drop unused variable
Date: Thu, 18 Sep 2025 17:55:53 +0200
Message-ID: <c1915bab805f7fbd72933420d90c2baa24b6a478.1758210955.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1758210955.git.jan.kiszka@siemens.com>
References: <cover.1758210955.git.jan.kiszka@siemens.com>
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

This was obsoleted by 0ae7fc956478.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index ac688fc..f461999 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -100,8 +100,6 @@ default:
     - !reference [.common-config, script]
   script:
     - scripts/run-lava-tests.sh ${TARGET}
-  variables:
-    BUILD_JOB_NAME: "build-${BUILD_IDENTIFIER}:${TARGET}"
   artifacts:
     when: always
     reports:
-- 
2.51.0

