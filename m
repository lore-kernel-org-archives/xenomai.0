Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50DE38F8F
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 14:00:54 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230927135044a093fc080949d83821
        for <xenomai@lists.linux.dev>;
        Wed, 27 Sep 2023 15:50:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mo4x1SbuL05NB5GWJYjmrsW8EDPBWEOVZ5uTsQ7Fwp4=;
 b=GxshuAP+mlfFzNUmMw9b9+fKBfgHClkDhqaPlWfLojrV7mY/91T0tYrhHaHzeG33brC3bP
 wpIpCMaWWOq5lKD/b7enxTURSn7TsXo8V5bB3jzGMf9rQ9CE44bCDF1W4O45IJG8LmMnZUvN
 DZSNIH1gJ5C2YtswBB0CQoU3jBtIQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 27 Sep 2023 15:50:22 +0200
Subject: [PATCH v2 9/9] lib/cobalt/wrappers.h: Remove duplicate definition
 of __stringify()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-florian-y2038-2-v2-9-05f710464d83@siemens.com>
References: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

__stringify() is already defined in boilerplate/compiler.h which is
included a few lines above.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/wrappers.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
index 21f4ceacb..4fcb1c3b9 100644
--- a/include/cobalt/wrappers.h
+++ b/include/cobalt/wrappers.h
@@ -20,9 +20,6 @@
 
 #include <boilerplate/compiler.h>
 
-#define __stringify_1(x...)	#x
-#define __stringify(x...)	__stringify_1(x)
-
 #define __WRAP(call)		__wrap_ ## call
 #define __STD(call)		__real_ ## call
 #define __COBALT(call)		__cobalt_ ## call

-- 
2.39.2

