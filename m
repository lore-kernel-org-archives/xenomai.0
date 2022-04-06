From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 3/5] copperplate,
 testsuite: convert to cobalt_event_broadcast()
Date: Wed,  6 Apr 2022 17:56:46 +0200
Message-Id: <20220406155648.1592472-3-rpm@xenomai.org>
In-Reply-To: <20220406155648.1592472-1-rpm@xenomai.org>
References: <20220406155648.1592472-1-rpm@xenomai.org>
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

cobalt_event_post() is about to be deprecated, rename to
cobalt_event_broadcast().

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 lib/copperplate/eventobj.c       | 2 +-
 testsuite/smokey/events/events.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/copperplate/eventobj.c b/lib/copperplate/eventobj.c
index dce5bd242f..fcc30b2429 100644
--- a/lib/copperplate/eventobj.c
+++ b/lib/copperplate/eventobj.c
@@ -84,7 +84,7 @@ int eventobj_post(struct eventobj *evobj, unsigned int bits)
 {
 	int ret;
 
-	ret = cobalt_event_post(&evobj->core.event, bits);
+	ret = cobalt_event_broadcast(&evobj->core.event, bits);
 	if (ret)
 		return ret;
 
diff --git a/testsuite/smokey/events/events.c b/testsuite/smokey/events/events.c
index 79711795ac..ee1de05baf 100644
--- a/testsuite/smokey/events/events.c
+++ b/testsuite/smokey/events/events.c
@@ -101,13 +101,13 @@ static int run_events(struct smokey_test *t, int argc, char *const argv[])
 	sem_post(&c.start);
 	sem_wait(&c.sem);
 
-	if (!__T(ret, cobalt_event_post(&c.event, 0x12121212)))
+	if (!__T(ret, cobalt_event_broadcast(&c.event, 0x12121212)))
 		return ret;
 
 	sem_wait(&c.sem);
 	usleep(1000);
 
-	if (!__T(ret, cobalt_event_post(&c.event, 0x41414141)))
+	if (!__T(ret, cobalt_event_broadcast(&c.event, 0x41414141)))
 		return ret;
 
 	sem_wait(&c.sem);
-- 
2.34.1


