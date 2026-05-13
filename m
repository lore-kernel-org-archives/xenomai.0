Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BCD37C0F8
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676623; cv=none; b=KzMprIM4TXD8zM5C7jD92dgKxgOh5SqkBD78tYbyw+MwU1NIkyWeh9jMJh7sLaETOvt69u090B3NFN7SzSQ3gLS85j6kvYuWrG7TjXRBMnz0Wd1L9o2ocMcHV3tiMsRugTWXn8zV1DHPxKRQmb8bBfjUnnDJMJRUF71H9/1GZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676623; c=relaxed/simple;
	bh=03TEu61M286UOL8mKcf0lLfMePjtM4uFkx0VfEIMRq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SMUv/ACzX+9E7hJNVvfqYtQC7asM4nKW3cc36Tk9Dbsoli6yEdm6E0P85A31YoxK5R45TOhP2ismYkHS77crbUKQxsIQPHdGw5Lg3d2FxhJRRxZd5lceLAQGK+g7BOpnil1Pzwp6tD7w5KMTfXWlVWGtM3/aBZsldCnSBPEDcFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Yc+BT007; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Yc+BT007"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260513125015819ff975e6000207d6
        for <xenomai@lists.linux.dev>;
        Wed, 13 May 2026 14:50:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=L+rPFa8xYvTJZpPqU0ZGRvlsKReeUUUw1H5Su2AuDII=;
 b=Yc+BT007J8iVFPKP+XMKppBby86v21/SuCn0EnakHXsj3elDse0ZtpDqcpvUqXU7JNNoaJ
 OXlxQZo3EzVekKMsf7PyJOr5GPPqW8yoqTwrP0jCCwTR6vve6XqGyFA2qUHn6HKaBSV4lTru
 G2DpUIZh4lN8jOwF/7EPU3PrJZRCfMPN18AzVQRa94LWa5ggioMhAs+B31WoYI4qqgaomdD6
 mZni8nHaxB4TYBTikSkiwiTvpr/RiV+b9u+BqQdIEGN4nvl4rI7/VA8/29dApAZ1esxFy9p8
 7xoWSiHQtKZI0QtIpr4rKHy8PKZxn1Id1oVdJnMvQukqZCK9FFPKeypw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 13 May 2026 14:50:12 +0200
Subject: [PATCH 5/5] clang-format: Squash empty loops into a single line
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-wip-flo-gcc-16-v1-5-120ae1287401@siemens.com>
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
In-Reply-To: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

        while (cond) {    vs   while (cond) {}
        }

The alternative

        while (cond)
                continue;

triggered a warning inside the analyzer:
Redundant control flow jump statement.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 2ffd69afc1a8280654a8763e044e27e08be7a69f..2792bc6a0b6f8d6eba81e2dbf7d0c6ba745707ca 100755
--- a/.clang-format
+++ b/.clang-format
@@ -17,7 +17,7 @@ AlignConsecutiveDeclarations: false
 AlignOperands: true
 AlignTrailingComments: false
 AllowAllParametersOfDeclarationOnNextLine: false
-AllowShortBlocksOnASingleLine: false
+AllowShortBlocksOnASingleLine: Empty
 AllowShortCaseLabelsOnASingleLine: false
 AllowShortFunctionsOnASingleLine: None
 AllowShortIfStatementsOnASingleLine: false

-- 
2.54.0

