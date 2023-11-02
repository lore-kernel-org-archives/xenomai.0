Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60BA7486
	for <xenomai@lists.linux.dev>; Thu,  2 Nov 2023 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Zo2U+imz"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202311021441448c2b76bbc620f62667
        for <xenomai@lists.linux.dev>;
        Thu, 02 Nov 2023 15:41:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kb1dmHLKlRoAC9gKdyhJus0bU12XID3wYVsBn9EP8fk=;
 b=Zo2U+imzQzsjonuKfXgf5FF7o+VbHBmpq7RQY8meDSx/TeqlPjCReDZMTWwBdpjBcZvQss
 DYbzePjIVeC1IbTerCsWs6hxpoVz8KQqCOWe+T7LexLjwhvDbnBNHDJ9OJuo6JqBz7ijBNwK
 c6womxjj5dPMcTf9FzPAZEumoyPfU=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 02 Nov 2023 15:41:42 +0100
Subject: [PATCH 1/6] testsuite: vxworkstests: Do not try to call
 nonexistent binary
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-flo-cleanup-testsuite-v1-1-0fb7bbd2d45f@siemens.com>
References: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
In-Reply-To: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

vxworkstests are part of the smokey-testsuite. There is no vxworkstests
executable that can be called.

The following line could be found in the test log:
    sh: 1: /usr/lib/xenomai/testsuite/vxworkstests: not found

This patch addresses the first part of the problem. The remaining part,
the missing error reporting (the testrun was still successful), will be
addressed in a follow-up patch.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/vxworkstests/vxworkstests.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
index 4b694b30b..f7974cb5d 100644
--- a/testsuite/smokey/vxworkstests/vxworkstests.c
+++ b/testsuite/smokey/vxworkstests/vxworkstests.c
@@ -10,7 +10,6 @@ static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
 	int ret = 0;
 
 	char *tests[] = {
-		"vxworkstests",
 		"vxworkstests_lst1",
 		"vxworkstests_msgQ1",
 		"vxworkstests_msgQ2",

-- 
2.39.2

