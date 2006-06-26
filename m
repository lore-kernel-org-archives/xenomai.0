Message-Id: <20060626172119.882570000@domain.hid>
References: <20060626172116.019532000@domain.hid>
Date: Mon, 26 Jun 2006 19:21:21 +0200
From: jan.kiszka@domain.hid
Content-Disposition: inline; filename=accept-rtdm-dev-prefix.patch
Subject: [Xenomai-core] [PATCH 5/6] Overread dev-prefix on posix open
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Adds support to the posix user-space lib to address RTDM-devices also with a (here meaningless) "/dev/" name prefix. Intended to increase user convenience slightly.

---
 src/skins/posix/rtdm.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: xenomai/src/skins/posix/rtdm.c
===================================================================
--- xenomai.orig/src/skins/posix/rtdm.c
+++ xenomai/src/skins/posix/rtdm.c
@@ -41,10 +41,15 @@ static inline int set_errno(int ret)
 int __wrap_open(const char *path, int oflag, ...)
 {
 	int ret, oldtype;
+	char *rtdm_path = path;
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-	ret = XENOMAI_SKINCALL2(__rtdm_muxid, __rtdm_open, path, oflag);
+	/* skip path prefix for RTDM invocation */
+	if (strncmp(path, "/dev/", 5) == 0)
+		rtdm_path += 5;
+
+	ret = XENOMAI_SKINCALL2(__rtdm_muxid, __rtdm_open, rtdm_path, oflag);
 
 	pthread_setcanceltype(oldtype, NULL);
 

--

