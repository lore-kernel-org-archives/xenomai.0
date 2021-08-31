From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 3/5] selinux: dovetail: declare oob socket class
Date: Tue, 31 Aug 2021 10:27:07 +0200
Message-Id: <20210831082709.1296249-4-rpm@xenomai.org>
In-Reply-To: <20210831082709.1296249-1-rpm@xenomai.org>
References: <20210831082709.1296249-1-rpm@xenomai.org>
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
 security/selinux/hooks.c            | 4 +++-
 security/selinux/include/classmap.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 227eb896796377b..548faa1cf744c01 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1271,7 +1271,9 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
 			return SECCLASS_SMC_SOCKET;
 		case PF_XDP:
 			return SECCLASS_XDP_SOCKET;
-#if PF_MAX > 45
+		case PF_OOB:
+			return SECCLASS_OOB_SOCKET;
+#if PF_MAX > 46
 #error New address family defined, please update this function.
 #endif
 		}
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index b9fdba2ff41637c..a16df4cf674f874 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -246,6 +246,8 @@ struct security_class_mapping secclass_map[] = {
 	    NULL } },
 	{ "xdp_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
+	{ "oob_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
 	{ "perf_event",
 	  { "open", "cpu", "kernel", "tracepoint", "read", "write", NULL } },
 	{ "lockdown",
@@ -253,6 +255,6 @@ struct security_class_mapping secclass_map[] = {
 	{ NULL }
   };
 
-#if PF_MAX > 45
+#if PF_MAX > 46
 #error New address family defined, please update secclass_map.
 #endif
-- 
2.31.1


