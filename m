From: Jussi Viiri <ilmai@iki.fi>
Subject: Patch: Make Sched* struct fields public so they can be constructed
Message-ID: <b4e4e45b-4b8c-bd6e-55d2-b580b1f576fd@iki.fi>
Date: Tue, 7 Jun 2022 21:30:06 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

 From 2c9979487f50ce3e6d38c7fa69f5ad5de4c60474 Mon Sep 17 00:00:00 2001
From: Jussi Viiri <ilmai@iki.fi>
Date: Tue, 7 Jun 2022 21:00:19 +0300
Subject: [PATCH] Make Sched* struct fields public so they can be constructed

---
  src/sched.rs | 14 +++++++-------
  1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/sched.rs b/src/sched.rs
index bc069e4..2114d40 100644
--- a/src/sched.rs
+++ b/src/sched.rs
@@ -8,25 +8,25 @@ use evl_sys::{
  pub struct SchedAttrs(pub(crate) evl_sched_attrs);

  pub struct SchedFifo {
-    prio: i32,
+    pub prio: i32,
  }

  pub struct SchedRR {
-    prio: i32,
+    pub prio: i32,
  }

  pub struct SchedWeak {
-    prio: i32,
+    pub prio: i32,
  }

  pub struct SchedQuota {
-    group: i32,
-    prio: i32,
+    pub group: i32,
+    pub prio: i32,
  }

  pub struct SchedTP {
-    part: i32,
-    prio: i32,
+    pub part: i32,
+    pub prio: i32,
  }

  pub trait PolicyParam {
--
2.25.1

