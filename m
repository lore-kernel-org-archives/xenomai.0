Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA75A329C66
	for <xenomai@lists.linux.dev>; Sun, 14 Jun 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781429271; cv=none; b=rj9/XYZjhVKfWNeTEo/DpYmPaSdlt+MAQ8gOuLeMioZP3kQzfa3/IiNFfBSRfob9b40DeBaeI0tbE3jS5uaCF3JjkF5jfqXgjhajNGaDOjkEdAumkr8HQjSK4pCWGavaFUFoBEHhz57AVMfnNbS/hQLeF5vpalaPzAdwUdJGQ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781429271; c=relaxed/simple;
	bh=cX+j4XqctVq51bMHcIFs8EExVcQ8YXFWfz3yZ6XmLYU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZdUBvJ13OB2zd2BcGEppA/nCrW8Iooh4uL2YQr4BluC3tmYGV7S//41deIuvYIkvs8gkBXAJdQ8/qPzM8p9LhItljVKCaAH+4qjVQ6vi4gT/lfC+R6sOo5YVlU7AMtud+KWq3NlPyTGGoPfOqsECEOD938y7OW8ERj/EvFKDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=oMx+wOnV; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="oMx+wOnV"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202606140917359efc457b85000207a6
        for <xenomai@lists.linux.dev>;
        Sun, 14 Jun 2026 11:17:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=uHfnNltvB91+vUkLBoqIiGi+oUqq8xCRwfnp0MpzRDI=;
 b=oMx+wOnVYCaOk5QdE9DfynoCiKs+qxixrDjx/g5Nrx1hIFknNvvFukZ8ZOKMHM3b5E6lpg
 uB0AkWROPLRjokrSDdcblRinUdK8+Omnwj6OTebQIx7X+Mj20geK7Dr7Dwh6sczo654yCE81
 8FYgtBU0glO3PVOpXI8udTrvdmAsmwWl66HVeGqfSPdD2eF1c9oU3H5s6hoXjZvgJKJYOUna
 WOr5DaCmPmQECd++PmcplWWl3IBANdfWR9/3BU19V9BR8jX6fZYVM6EoWgLkYd1zQzQdThUL
 rQ0qDRaSJ9PwmSyRlQNAQddy8mynnL4Ma2y73/zsAaTJ0Uhe43AYtePg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 4/6] ci: Drop 6.1 from xenomai-4 pipelines
Date: Sun, 14 Jun 2026 11:17:32 +0200
Message-ID: <0b2189576ad7dd63006be5af823a98ee5bcf87fc.1781428654.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1781428654.git.jan.kiszka@siemens.com>
References: <cover.1781428654.git.jan.kiszka@siemens.com>
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

That kernel is now end of life.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/xenomai_4_next.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
index ffb1ebb..6ef4b6a 100644
--- a/ci/xenomai_4_next.yml
+++ b/ci/xenomai_4_next.yml
@@ -11,7 +11,6 @@
 
 include:
   - local: '/ci/lib/gitlab-ci-base.yml'
-  - local: '/ci/lib/kernel/6_1.yml'
   - local: '/ci/lib/kernel/6_12.yml'
   - local: '/ci/lib/kernel/6_18.yml'
   - local: '/ci/lib/kernel/head.yml'
-- 
2.47.3

