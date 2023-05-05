Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AD34C86
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:21:07 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202305050721052eff3b2678ceda4720
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:21:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Qn+cNF/NKOWVMO5hMPfbzSmoLBxNtE/YqndjK1SEIzE=;
 b=cfHC7ViZgaOtWyPqbkJCaW6C9Ll2RMOGusp4mZBf2/tLWuEbrkMzmE3iVMjh+rCI01oJFz
 LWxI+qgAfBaqXLo0qbMFWRAHSKqNil8lRkRW7Hu9zSURT40MDAbdYZ35DPi8dHXdwd09qeb7
 KWmMZ661tYpUD469qTcnT78BBEIcg=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:21:10 +0200
Subject: [PATCH 15/17] y2038: testsuite/smokey/y2038: Fix a very unlikely
 resource leak
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-15-64a972ff2189@siemens.com>
References: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
In-Reply-To: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

In case we had no kernel support for the cond_wait_prologue64 service
we would leak some thread resources. Fixed now.

While at it: Adding the "64" suffix to the test name. All other tests
have it as well.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index b1abec260..ef8c72225 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -1117,7 +1117,7 @@ out:
 	return ret;
 }
 
-static int test_sc_cobalt_cond_wait_prologue(void)
+static int test_sc_cobalt_cond_wait_prologue64(void)
 {
 	int ret = 0;
 	int err = 0;
@@ -1142,7 +1142,8 @@ static int test_sc_cobalt_cond_wait_prologue(void)
 	if (ret == -ENOSYS) {
 		smokey_note(
 			"cond_wait_prologue64: skipped. (no kernel support)");
-		return 0; // Not implemented, nothing to test, success
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
 	}
 	if (!smokey_assert(ret == -EINVAL))
 		return ret ? ret : -EINVAL;
@@ -1296,7 +1297,7 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
-	ret = test_sc_cobalt_cond_wait_prologue();
+	ret = test_sc_cobalt_cond_wait_prologue64();
 	if (ret)
 		return ret;
 

-- 
2.39.2

