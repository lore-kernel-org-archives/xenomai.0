From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Do not stumble over annotated ipipe tags
Message-ID: <0b906f3c-ad12-104d-0e24-325ad37c6547@siemens.com>
Date: Fri, 6 Dec 2019 19:34:47 +0100
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

Currently not an issue for the kernels we pull here, but 4.14-ppc would
break e.g. because ls-remote --tags gives

... ipipe-core-4.14.36-ppc32-1.1
... ipipe-core-4.14.36-ppc32-1.1^{}

with the second one representing the dereferentiation of the annotated
tag. We only need the first one, though, while the second breaks git
clone. --refs filters this.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Already applied to stable in order to fix the ppc ci build there.

 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 7f3cba96e9..d56b6e494e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -25,7 +25,7 @@ install:
   - sudo update-alternatives --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-8 800
   - sudo update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-8 800
   - sudo update-alternatives --install /usr/bin/powerpc-linux-gnu-gcc powerpc-linux-gnu-gcc /usr/bin/powerpc-linux-gnu-gcc-8 800
-  - REV=$(git ls-remote --tags ${IPIPE_KERNEL} | sed "s|.*[[:space:]]refs/tags/||" | grep "${IPIPE_REV}" | sort -r -n -t - -k 5 -k 6 | head -1)
+  - REV=$(git ls-remote --tags --refs ${IPIPE_KERNEL} | sed "s|.*[[:space:]]refs/tags/||" | grep "${IPIPE_REV}" | sort -r -n -t - -k 5 -k 6 | head -1)
   - test -n "${REV}" || REV="${IPIPE_REV}"
   - echo "Cloning branch/tag ${REV}"
   - git clone --depth 1 --branch ${REV} ${IPIPE_KERNEL} ${KDIR}
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

