From: Jan Kiszka <jan.kiszka@siemens.com>
References: <7be9b9c7-7393-eca0-6a86-bcf3d0302271@siemens.com>
Message-ID: <667bd118-b8eb-4fbf-cb24-4f4f30114370@siemens.com>
Date: Fri, 13 Apr 2018 19:51:46 +0200
MIME-Version: 1.0
In-Reply-To: <7be9b9c7-7393-eca0-6a86-bcf3d0302271@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] copperplate: Drop PI from registry locks
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

None of the callers that run into the locks have RT requirements.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

As noted before, I think we should even be fine with STD locks, but that
may require more changes.

 lib/copperplate/registry.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/copperplate/registry.c b/lib/copperplate/registry.c
index daefa6c97..1bf0ebfea 100644
--- a/lib/copperplate/registry.c
+++ b/lib/copperplate/registry.c
@@ -175,7 +175,6 @@ int registry_init_file(struct fsobj *fsobj,
 
 	pthread_mutexattr_init(&mattr);
 	pthread_mutexattr_settype(&mattr, mutex_type_attribute);
-	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
 	pthread_mutexattr_setpshared(&mattr, PTHREAD_PROCESS_PRIVATE);
 	ret = __bt(-__RT(pthread_mutex_init(&fsobj->lock, &mattr)));
 	pthread_mutexattr_destroy(&mattr);
@@ -758,7 +757,6 @@ int __registry_pkg_init(const char *arg0, char *mountpt, int flags)
 
 	pthread_mutexattr_init(&mattr);
 	pthread_mutexattr_settype(&mattr, mutex_type_attribute);
-	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
 	pthread_mutexattr_setpshared(&mattr, PTHREAD_PROCESS_PRIVATE);
 	ret = __bt(-__RT(pthread_mutex_init(&p->lock, &mattr)));
 	pthread_mutexattr_destroy(&mattr);

