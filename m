From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9311c789-ef1d-8a28-502f-eb83540a0f68@siemens.com>
Date: Thu, 12 Apr 2018 10:28:55 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] Revert "boilerplate/hash: drop preposterous PI
	for locking"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

This reverts commit 0f19393b3702705c8470147b6a3fd03a08b42642.

No reason was given back then, and we there is the risk that this code
is used by prio-sensitive threads. Moreover, pvhash still used PI -
unless it is mapped on plain hash in case of !CONFIG_XENO_PSHARED.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/boilerplate/hash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/boilerplate/hash.c b/lib/boilerplate/hash.c
index aa35fa475..17beb385c 100644
--- a/lib/boilerplate/hash.c
+++ b/lib/boilerplate/hash.c
@@ -101,6 +101,7 @@ void __hash_init(void *heap, struct hash_table *t)
 
 	pthread_mutexattr_init(&mattr);
 	pthread_mutexattr_settype(&mattr, mutex_type_attribute);
+	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
 	pthread_mutexattr_setpshared(&mattr, mutex_scope_attribute);
 	__RT(pthread_mutex_init(&t->lock, &mattr));
 	pthread_mutexattr_destroy(&mattr);
-- 
2.13.6

