From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 2/2] lib/smokey: consider PATH in smokey_fork_exec()
Date: Fri, 20 Sep 2019 19:00:37 +0200
Message-Id: <20190920170037.6861-2-rpm@xenomai.org>
In-Reply-To: <20190920170037.6861-1-rpm@xenomai.org>
References: <20190920170037.6861-1-rpm@xenomai.org>
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

Prefer execlp() over execl() for bootstrapping a new image: callers
may assume that PATH should be considered when searching for the
executable file, e.g. posix_fork test.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 lib/smokey/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
index 6ee69ec5b..da84c863c 100644
--- a/lib/smokey/helpers.c
+++ b/lib/smokey/helpers.c
@@ -276,7 +276,7 @@ int smokey_fork_exec(const char *path, const char *arg)
 	case -1:
 		error(1, errno, "fork/vfork");
 	case 0:
-		execl(path, arg, NULL);
+		execlp(path, arg, NULL);
 		error(1, errno, "execl %s", path);
 	default:
 		waitpid(pid, &wstatus, 0);
-- 
2.21.0


