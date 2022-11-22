Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F9015CBB
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:36 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 6B90C240003
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:29 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 2036D780450
	for <xenomai@xenomai.org>; Tue, 22 Nov 2022 22:26:28 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2022112222262744ff00a123b32e8384
        for <xenomai@xenomai.org>;
        Tue, 22 Nov 2022 23:26:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=yEh9+u+Tww3oHw2XLKltilma93WbVqNHBUc8LKJy+Ds=;
 b=PhNn1NP1TG9bxv6CsgAiqOvuAB6lYgkaOkdv4yiQpO9hZeDwGOAXtw1S3x0/DQ0HI6E78w
 T0UvJmEH/QQn+MwciCJcw0j5UP3zhCM+fHQKEW/obTA+gLqlIg6ZlRYfkp2Wv8UP9bG+O61m
 hJkaIf1iTCRzxVdDZnNWpx9yBYixU=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 1/8] drivers/testing/heapcheck: Replace prandom_u32 with custom implementation
Date: Tue, 22 Nov 2022 23:26:19 +0100
Message-Id: <d41c353fc20318ee2282c959cdf676f2e9c53437.1669155986.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1669155986.git.jan.kiszka@siemens.com>
References: <cover.1669155986.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool4: domain of rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) client-ip=185.136.64.228; envelope-from=fm-294854-2022112222262744ff00a123b32e8384-Zl2pAq@rts-flowmailer.siemens.com; helo=mta-64-228.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=PhNn1NP1;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-2022112222262744ff00a123b32e8384-Zl2pAq@rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) smtp.mailfrom=fm-294854-2022112222262744ff00a123b32e8384-Zl2pAq@rts-flowmailer.siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

prandom_u32 was dropped from 6.1, but get_random_u32 is not oob-safe. So
we only use it for initializing a seed and then rely on our own version
of next_pseudo_random32. The latter is still available via
linux/prandom.h, but given that there are no more in-tree users, it
could be dropped at any point in the future.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/testing/heapcheck.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/testing/heapcheck.c b/kernel/drivers/testing/heapcheck.c
index 1b97d1d024..fc6e91d3ad 100644
--- a/kernel/drivers/testing/heapcheck.c
+++ b/kernel/drivers/testing/heapcheck.c
@@ -53,6 +53,8 @@ static struct runstats *statistics;
 
 static int nrstats;
 
+static unsigned int random_seed;
+
 static inline void breathe(int loops)
 {
 	if ((loops % 1000) == 0)
@@ -68,6 +70,12 @@ static inline void do_swap(void *left, void *right)
 	memcpy(right, trans, sizeof(struct chunk));
 }
 
+static inline unsigned int pseudo_random(void)
+{
+	random_seed = random_seed * 1664525 + 1013904223;
+	return random_seed;
+}
+
 static void random_shuffle(void *vbase, size_t nmemb)
 {
 	struct {
@@ -76,7 +84,7 @@ static void random_shuffle(void *vbase, size_t nmemb)
 	unsigned int j, k;
 
 	for (j = nmemb; j > 0; j--) {
-		k = (unsigned int)(prandom_u32() % nmemb) + 1;
+		k = (unsigned int)(pseudo_random() % nmemb) + 1;
 		if (j == k)
 			continue;
 		do_swap(&base[j - 1], &base[k - 1]);
@@ -166,6 +174,8 @@ static int test_seq(size_t heap_size, size_t block_size, int flags)
 	bool done_frag;
 	void *mem, *p;
 
+	random_seed = get_random_u32();
+
 	maxblocks = heap_size / block_size;
 
 	mem = vmalloc(heap_size);
@@ -224,7 +234,7 @@ static int test_seq(size_t heap_size, size_t block_size, int flags)
 		}
 		chunks[n].ptr = p;
 		if (flags & RTTST_HEAPCHECK_PATTERN) {
-			chunks[n].pattern = (enum pattern)(prandom_u32() % 3);
+			chunks[n].pattern = (enum pattern)(pseudo_random() % 3);
 			fill_pattern(chunks[n].ptr, block_size, chunks[n].pattern);
 		}
 		breathe(n);
-- 
2.35.3

