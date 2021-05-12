From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4/7] drivers/testing: headcheck: remove variable-length array
Date: Wed, 12 May 2021 12:05:54 +0200
Message-Id: <154860d91888a771ab3fc580bbf49513a1cde0f8.1620813957.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1620813957.git.jan.kiszka@siemens.com>
References: <cover.1620813957.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/testing/heapcheck.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/drivers/testing/heapcheck.c b/kernel/drivers/testing/heapcheck.c
index 023a06ca64..207f20921f 100644
--- a/kernel/drivers/testing/heapcheck.c
+++ b/kernel/drivers/testing/heapcheck.c
@@ -59,19 +59,19 @@ static inline void breathe(int loops)
 		rtdm_task_sleep(300000ULL);
 }
 
-static inline void do_swap(void *left, void *right, const size_t size)
+static inline void do_swap(void *left, void *right)
 {
-	char trans[size];
+	char trans[sizeof(struct chunk)];
 
-	memcpy(trans, left, size);
-	memcpy(left, right, size);
-	memcpy(right, trans, size);
+	memcpy(trans, left, sizeof(struct chunk));
+	memcpy(left, right, sizeof(struct chunk));
+	memcpy(right, trans, sizeof(struct chunk));
 }
 
-static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
+static void random_shuffle(void *vbase, size_t nmemb)
 {
 	struct {
-		char x[size];
+		char x[sizeof(struct chunk)];
 	} __attribute__((packed)) *base = vbase;
 	unsigned int j, k;
 
@@ -79,7 +79,7 @@ static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
 		k = (unsigned int)(prandom_u32() % nmemb) + 1;
 		if (j == k)
 			continue;
-		do_swap(&base[j - 1], &base[k - 1], size);
+		do_swap(&base[j - 1], &base[k - 1]);
 	}
 }
 
@@ -259,7 +259,7 @@ static int test_seq(size_t heap_size, size_t block_size, int flags)
 	}
 	
 	if (flags & RTTST_HEAPCHECK_SHUFFLE)
-		random_shuffle(chunks, nrblocks, sizeof(*chunks));
+		random_shuffle(chunks, nrblocks);
 
 	/*
 	 * Release all blocks.
-- 
2.26.2


