Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0CC2ECEB9
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986586; cv=none; b=oiLGEqq/f8X0z/KDU6S4LxKdzKUmEy4lx26ZtzDAfV6Gj7TIILtG2YikQuhGYZPGh2mwKlO31T8N/f6/YpFW+Ir6IPPJ4AEyMus2e4QJQUPNd15LvY6UcLA82UcAE3AtyeAck71UEeczMZ7tivrJfIK1vBA1NpyberEATjXWgd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986586; c=relaxed/simple;
	bh=2Cj0u6i3w73RhLK99uzxiL5QyaIPCEINYh7+1DwP3Ww=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gLiVwHLacvFyJ2DJl0wmWHzDQ6iM+5azzrT3LjPnWHXOWZC9MjdY98eEZLR+8mBxVxQk29ZeUhu/FT3u6L+VXQOfvDi3PNosMeFk5yE45z8/y1pDRNExjn85r5AcP8tMQ9h9ZQ+ufrYulDNGgKoOCnqrbtjgAZVem6Dis9miSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=Quirin.Gylstorff@siemens.com header.b=JEcvQI2n; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=Quirin.Gylstorff@siemens.com header.b="JEcvQI2n"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250904113929a7a7c4ef2900020743
        for <xenomai@lists.linux.dev>;
        Thu, 04 Sep 2025 13:39:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=wOry41gx3VjTJTIfJ3lylbVKcgleduZxUE2jWst/uBs=;
 b=JEcvQI2nDYJjkYtYvKFtCqpjbc/vWtlqP94BkmGu0BPASKsXA4sLY5bZZa/MTuxqgBuv4g
 yjGOokFOC7T7J/kwbFG8uzyRWY52oG/Ob5SBStU0uFLkGn+5q3MlhLeopRGRiJDTRqHDwEj+
 Ly5FlomUQHN2Dhuu5k/0CTTObGp8Lxrz+Dagw7fuMVk63Q7XTf2aJeiw3jMixBhUM4Tg+fE8
 B/vfLw9F1UKLm0qWe4oH16vf5tExfiSmkfbFR9RACXFFxtrtguCBtOzCyHzIYyqi3RqwmJog
 Tzi8KKKJVA5w7WKkY4CHXZN1CAQ8wQZk8anQRIAZ3Ff1UtpvkFB+X93g==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: florian.bezdeka@siemens.com,
	xenomai@lists.linux.dev,
	jan.kiszka@siemens.com
Subject: [PATCH] ci: increase wait for device timeout to 30min
Date: Thu,  4 Sep 2025 13:38:43 +0200
Message-ID: <20250904113929.2064680-1-Quirin.Gylstorff@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This should avoid test failures with due to no device available

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ci/gitlab-ci-base.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 875d951..fc41929 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -28,6 +28,7 @@ variables:
   SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
   SSTATE_MIRRORS: "file://.* ${SSTATE_LOCATION}/PATH;downloadfilename=PATH"
   SSTATE_MAX_AGE: 14d
+  WAIT_FOR_DEVICE_TIMEOUT: 30
 
 default:
   image: ghcr.io/siemens/kas/kas-isar:4.8.2
-- 
2.50.1

