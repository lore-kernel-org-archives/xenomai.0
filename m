Subject: [PATCH 2/2] Add release generator script
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <98fe2e20-bad6-7c24-945c-f2c0bd20a743@siemens.com>
Message-ID: <72dd2779-fce3-f21f-279a-90115c6f70ee@siemens.com>
Date: Thu, 20 Dec 2018 08:58:47 +0100
MIME-Version: 1.0
In-Reply-To: <98fe2e20-bad6-7c24-945c-f2c0bd20a743@siemens.com>
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

This encodes
- updating version-code/label
- committing the changes
- tagging the result

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/make-release.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100755 scripts/make-release.sh

diff --git a/scripts/make-release.sh b/scripts/make-release.sh
new file mode 100755
index 0000000000..67a191d44e
--- /dev/null
+++ b/scripts/make-release.sh
@@ -0,0 +1,35 @@
+#! /bin/bash
+
+usage() {
+	echo "usage: $0 name"
+	exit 1
+}
+
+name=$1
+
+if [ -z "$name" ]; then
+	usage
+fi
+
+if [ ! -f config/version-code ] || [ ! -d .git ]; then
+	echo "Must be run from top-level directory"
+	exit 1
+fi
+
+if [ -n "`git status -s -uno`" ]; then
+	echo "Working directory is dirty!"
+	exit 1
+fi
+
+echo -e "Tag commit\n\n    `git log -1 --oneline`"
+echo -e "\nof branch\n\n    `git branch | sed -n 's/^\* //p'`"
+echo -ne "\nas $name? (y/N) "
+read answer
+if [ "$answer" != "y" ]; then
+	exit 1
+fi
+
+echo $name | sed "s/v//" > config/version-code
+cp  config/version-code config/version-label
+git commit -sv config/version-code config/version-label -m "config: Bump version number"
+git tag -as $name -m "Release $name"
-- 
2.16.4

