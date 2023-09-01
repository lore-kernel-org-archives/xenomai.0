Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821DDDCF
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 19:45:34 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230901194534358129c7249895afb9
        for <xenomai@lists.linux.dev>;
        Fri, 01 Sep 2023 21:45:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ta9G6OOkAr7k2J/8jFwM9Dy4UXOBXdiXnbBMrJBhwSg=;
 b=msdQJjLeLrgwcfwb3UEaNF7QgJB9hVJZHjt2CfmiPBU9swCv9ipwt4VYR8yoZGPle+VvVy
 vXOvGblVf9vkSAEzPGjTIgPYPmKi1cNvXnFyC+OKH9+8Zyf4fHm1UHlDY8cXGuJz0kVryzP6
 2Toa+fSpLmFwPNhty+rNMrLmO5LCg=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 01 Sep 2023 21:45:37 +0200
Subject: [PATCH stable/v3.2.x v2 14/17] drivers/testing/heapcheck: Replace
 prandom_u32 with custom implementation
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v2-14-5189cfb05a62@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

[ master commit d41c353fc20318ee2282c959cdf676f2e9c53437 ]

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
index 1b97d1d02..fc6e91d3a 100644
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
2.39.2

