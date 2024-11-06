Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DD01DED73
	for <xenomai@lists.linux.dev>; Wed,  6 Nov 2024 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893077; cv=none; b=GSNXMNc+eTkeLoR0DNPgtw/J/VVSI8wbCiG/KhO6SqXujx1Y2NPI7NhSUUZaMFUuVcgFr5GjrqVvP/V2WZZYbx5fzZ9y/e0od1/qBb4rOO/lQxAqVDhE4hbJNsCjNoo14G29LXf52gKgxU/feguG+iSCmKP7eCEKQKQPvMUMakQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893077; c=relaxed/simple;
	bh=vuvGEqcR674dk/XkaT9JbH6BluddLfbEjigp58sUoy4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ov7w+xz8gdy9DWX2mnuZ89bynWhWcSg/Z9VIGTl01dRVILZkFEEIWESBjmpSBhmBKkkSUmUXEfkYeoGMiPR4P7iU0Oy6Tgd/Kz3QHEAQMHyBr9xC3ScFxx5ZgAw6yFXb9TTX1x61W/ZQzL38Jri7cRkly6dOpkrPGNKs1UJNlQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=ADImJZNp; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ADImJZNp"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20241106112741821cb00dc8ab35d58c
        for <xenomai@lists.linux.dev>;
        Wed, 06 Nov 2024 12:27:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=DRLv550YsDrsyy8ToE4GCvv17AT6fBUxsP8WsruUJ6E=;
 b=ADImJZNp57nAb1C17F6LOuIzdH8ZHiUeJ6EScx3Fxt/n43R4GdVgaV51R0DvE49qzixCuh
 XnidiKlPzCjRuT3rpl1sd5H5Y6B5lvvmRTDDA1GN7/gQugc7JdJBj3rYKkw8LMRyTl074D1A
 DPwm9clYu8Txv900isZPbxTkwzbfakR+RTCNdVS8Q8T9cNxk1fXGk57ph4AinBTmLcskqkzK
 Mr1DPirStpbcZmbM+fToYkqwZy5mKfirGbqvTHqipaHS1l5slsUaTplgCjC5ULb64IqeTHTI
 jZ6yGYAGby4cMGwj7OB01TEoUsEkllxYALnIjBQISDpt+bAsYDLzgyqQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 2/3] Update isar revision
Date: Wed,  6 Nov 2024 12:27:39 +0100
Message-ID: <e63522c011cd39bb83ef0737127799661a54f7c4.1730892460.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730892460.git.jan.kiszka@siemens.com>
References: <cover.1730892460.git.jan.kiszka@siemens.com>
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

Will allow to build compat vDSO for arm64.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas.yml b/kas.yml
index d2554d3..778165d 100644
--- a/kas.yml
+++ b/kas.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 2480baaa18b097c39d6e68b2ac7d6fabd6ff8ab9
+    commit: 75488685dd2123417deb70f6d0923b8c2772954e
     layers:
       meta:
 
-- 
2.43.0

