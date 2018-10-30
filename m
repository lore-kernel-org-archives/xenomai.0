From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Subject: [PATCH 3/3] utils/analogy: fix compilation of analogy_calibrate with
 old toolchains
Date: Tue, 30 Oct 2018 11:29:14 +0100
Message-Id: <1540895354-16866-4-git-send-email-sebastian.smolorz@gmx.de>
In-Reply-To: <1540895354-16866-1-git-send-email-sebastian.smolorz@gmx.de>
References: <1540895354-16866-1-git-send-email-sebastian.smolorz@gmx.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The previous commit introduced a fix for old toolchains by including
sys/timex.h in include/cobalt/time.h. However, that breaks the
compilation of analogy_calibrate. Removing #include <sys/time.h>
from analogy_calibrate.c fixes compilation again.

Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
---
 utils/analogy/analogy_calibrate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/utils/analogy/analogy_calibrate.c b/utils/analogy/analogy_calibrate.c
index c5990a7..b927ee2 100644
--- a/utils/analogy/analogy_calibrate.c
+++ b/utils/analogy/analogy_calibrate.c
@@ -20,7 +20,6 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <sys/time.h>
 #include <sys/resource.h>
 #include <getopt.h>
 #include <pthread.h>
-- 
2.7.4


