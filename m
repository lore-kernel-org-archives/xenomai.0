From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 4/5] lib/cobalt: deprecate cobalt_event_post()
Date: Wed,  6 Apr 2022 17:56:47 +0200
Message-Id: <20220406155648.1592472-4-rpm@xenomai.org>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/sys/cobalt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/cobalt/sys/cobalt.h b/include/cobalt/sys/cobalt.h
index 1035a29d52..5dde69da8a 100644
--- a/include/cobalt/sys/cobalt.h
+++ b/include/cobalt/sys/cobalt.h
@@ -113,6 +113,7 @@ int cobalt_event_broadcast(cobalt_event_t *event,
 			unsigned int bits);
 
 /* Backward compatibility with 3.2.x and earlier. */
+__deprecated
 static inline int cobalt_event_post(cobalt_event_t *event,
 				unsigned int bits)
 {
-- 
2.34.1


