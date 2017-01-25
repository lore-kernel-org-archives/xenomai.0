From: Henning Schild <henning.schild@siemens.com>
Date: Wed, 25 Jan 2017 16:08:35 +0100
Message-Id: <20170125150837.14161-1-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 1/3] scripts/xeno-config: fix error message,
	dump_wrappers is not just POSIX
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 scripts/xeno-config-cobalt.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/xeno-config-cobalt.in b/scripts/xeno-config-cobalt.in
index 62c1f33..d102d04 100644
--- a/scripts/xeno-config-cobalt.in
+++ b/scripts/xeno-config-cobalt.in
@@ -25,7 +25,7 @@ dump_wrappers()
 {
    file=$1
    if test \! -r ${XENO_LIBRARY_DIR}/$file; then
-      echo "Xenomai: POSIX wrappers cannot be read from ${XENO_LIBRARY_DIR}/${file}" >&2
+      echo "Xenomai: wrappers cannot be read from ${XENO_LIBRARY_DIR}/${file}" >&2
       exit 1
    fi
    if test "$LD_FILE_OPTION" = "yes"; then
-- 
2.10.2


