Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DBE28CF55
	for <xenomai@lists.linux.dev>; Thu, 10 Apr 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294602; cv=none; b=pt7Vt9ZvY47wnB3AdsMrDQXCorYo9l77OoDtQa0z3B70s+Pkp7ZlwiomiSJqz3ET0B1J5FSw8WWyYJULkYQzk/T1bBHV9wRs0y/n7Emmyto/dCWUKktqzEZENbNQRcTW5Xvfeuou4JPaa6U9s5KvNfzh4DmQ8/ZY73ioy4JaQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294602; c=relaxed/simple;
	bh=O8o33lXDZShvWiu3ag0iPM/BjNRM+p6q4/HlZ9fSZ14=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGwkcxw0RL68tgUVzcYPscr4KvE7jJl5n+9n1LfDt28sdDdrK06AnavQt6vupQ8Z/reSqo5jlDBsNJycksTnkFeU1qW0am1jEiexjx9g9nXF9TxFIlhi0Gz+Q/Xei9UDkezpssbnNiq/ENFkge2Gi2/NXXi+EitNmUO+xHaeWyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=CEER7R4s; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="CEER7R4s"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025041014163189e8dfbb5a1d8312bb
        for <xenomai@lists.linux.dev>;
        Thu, 10 Apr 2025 16:16:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=6YXj6h+XiS9YQsQ9cJpnDfZIOsYg9xvUWf7idlqS4YE=;
 b=CEER7R4sX73sPwM7JoBk3hQrGcvPBG3/DrT2MQtY8ulZtTwYBPvHw9lxJRd4UXVl3bqHjE
 XmWCVEbuBYKOjgH/JFsxFuir5DhIuontjqJdxOh0vlr6SXEgjvBFF4qeoMsPmOuh37rBgDDN
 klgOItxzcgEtInJ5PlWPS7/vZGmmdlwlaf23x4roqVQHo9Q5YDQ7AYJNqroKDxwFHqDjrIvp
 raJAIbnBe8IMfA0Inqo26DyNCV9Z7XTXnrejepFZxvQnwKBF60rzZy2VtLst14W/gCSvsix9
 FCErKMAVRzSsf7O9SVirQ5ghnsVfwCXQzG2pxF5vdpRDobFSbhkmWhtA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 7/7] Kconfig: Add 6.12 kernel option for EVL
Date: Thu, 10 Apr 2025 16:16:30 +0200
Message-ID: <4734c0b8d72ab98e411516d4c0d73023be00ef99.1744294590.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1744294590.git.jan.kiszka@siemens.com>
References: <cover.1744294590.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Kconfig b/Kconfig
index f7ac3c8..042be93 100644
--- a/Kconfig
+++ b/Kconfig
@@ -242,6 +242,12 @@ choice
 config EVL_KERNEL_LATEST
 	bool "Head of latest EVL branch"
 
+config EVL_KERNEL_6_12_LATEST
+	bool "Head of 6.12 EVL branch"
+
+config EVL_KERNEL_6_12
+	bool "Latest 6.12 EVL release"
+
 config EVL_KERNEL_6_6_LATEST
 	bool "Head of 6.6 EVL branch"
 
@@ -259,6 +265,8 @@ endchoice
 config KAS_INCLUDE_EVL_KERNEL
 	string
 	default "opt-linux-latest.yml" if EVL_KERNEL_LATEST
+	default "opt-linux-latest-6.12.yml" if EVL_KERNEL_6_12_LATEST
+	default "opt-linux-6.12.yml" if EVL_KERNEL_6_12
 	default "opt-linux-latest-6.6.yml" if EVL_KERNEL_6_6_LATEST
 	default "opt-linux-6.6.yml" if EVL_KERNEL_6_6
 	default "opt-linux-latest-6.1.yml" if EVL_KERNEL_6_1_LATEST
-- 
2.43.0

