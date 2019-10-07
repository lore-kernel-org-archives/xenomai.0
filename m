From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] prepare-kernel: Make robust against -rc release names
Message-ID: <d3f09452-c4c0-618e-36df-956ef675ec6e@siemens.com>
Date: Mon, 7 Oct 2019 16:23:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/prepare-kernel.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 8707b11983..7fb8ed3307 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -371,6 +371,9 @@ case $linux_VERSION.$linux_PATCHLEVEL in
 	version_major=`expr $version_stamp : '\([[0-9]]*\)' || true`
 	version_minor=`expr $version_stamp : '[[0-9]]*\.\([[0-9]*]*\)' || true`
 	revision_level=`expr $version_stamp : '[[0-9]]*\.[[0-9]*]*\.\([[0-9]*]*\)' || true`
+	if [ -z "$revision_level" ]; then
+	    revision_level=0
+	fi
 	version_string=`cat $xenomai_root/config/version-label`
 	sed -e "s,@VERSION_MAJOR@,$version_major,g" \
 	    -e "s,@VERSION_MINOR@,$version_minor,g" \
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

