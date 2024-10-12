Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C441514F6
	for <xenomai@lists.linux.dev>; Sat, 12 Oct 2024 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728816; cv=none; b=JzSR1EUT36kB9WluBde5dhQBcpO3mUtsG91G1jxK0Z9Mo7Vi/dqFPJ7BKaU4SudNrUMf6991xJDVLARNWXBC4Z1XDXtSWGH1b19jJYYsibcDSL272BZVUUar/sdF82+VD3BIufVFmGMTdPd49OGhs1f4w2BqjY4KH7D6GBNLEYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728816; c=relaxed/simple;
	bh=POhdNSRbSTQDz3BzN4Yw75iyyuJo9tZAhf/RTPUWIps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=od53C7dNO1T10gPrpQyQotOOoWvMHmVNDRwnpCQaK+2mI9G8dkT8IbZTS5WENrJkgKJceSdTYnhrEWf/LYA4srhHchhrMZ+D6WFZSsrQrIyt4AsxSi23+Mlkh5j8mO7yw99whHUy+GhqeddVaM6MvD5vSf01wy07AA3RY+kcDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=hpbNX7tU; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="hpbNX7tU"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20241012102643225402548a669ca750
        for <xenomai@lists.linux.dev>;
        Sat, 12 Oct 2024 12:26:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=hHyNVk2H1J7mTwDRByRo2iDWSiQnH4K0/7UJ735xk6g=;
 b=hpbNX7tUX/4fT5J8Go9pugO8TNQHlfurzUyciPfaug9dnf/qDDHM8cn1iecpW+kQTNHfmM
 Wxomy0zHdAAa0PKetNrf2BLltJzs8ngHxJoYUIpmCAsPWb69sw1yuFZaZ8Bvz1ThSzcmJxnv
 SK75uEV5vY9RjDOguUCUa4G25gGfIxMTpvRg9Kt9LfyF3v73i58biCFbLF7XsK5W+ZMKtgeY
 JvwoA0eIV8NtUwlFngsIpTmfBTM4Ap402pnj5MLWlAvNEnh5dFJ0vrsg1aHUk1XqdaeqmuP/
 /1bFZdzuLEH+U09xOcPLzMxqP/ds4sLJn6jUz3ZInkIpkg1FuM+fM7xw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Sat, 12 Oct 2024 12:26:41 +0200
Subject: [PATCH 2/7] testsuite: Cleanup of unused includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-flo-cleanup-before-release-v1-2-df05bfa0ac80@siemens.com>
References: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
In-Reply-To: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Clara Kowalsky <clara.kowalsky@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

No functional change intended. Helps to speed up the build a bit.

As most files had a blank line between the license header and the
first include this pattern has been applied where necessary.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/clocktest/clocktest.c   | 2 +-
 testsuite/gpiobench/gpiobench.c   | 8 +-------
 testsuite/gpiotest/gpiotest.c     | 2 +-
 testsuite/latency/latency.c       | 1 +
 testsuite/spitest/spitest.c       | 3 +--
 testsuite/switchtest/switchtest.c | 1 +
 6 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/testsuite/clocktest/clocktest.c b/testsuite/clocktest/clocktest.c
index 4d87ee700..283d33ccd 100644
--- a/testsuite/clocktest/clocktest.c
+++ b/testsuite/clocktest/clocktest.c
@@ -15,6 +15,7 @@
  * along with Xenomai; if not, write to the Free Software Foundation,
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
+
 #include <errno.h>
 #include <pthread.h>
 #include <sched.h>
@@ -30,7 +31,6 @@
 #include <sys/syscall.h>
 #include <sys/time.h>
 #include <boilerplate/ancillaries.h>
-#include <boilerplate/atomic.h>
 #include <xeno_config.h>
 
 /*
diff --git a/testsuite/gpiobench/gpiobench.c b/testsuite/gpiobench/gpiobench.c
index dfd936c0e..f2cbb2549 100644
--- a/testsuite/gpiobench/gpiobench.c
+++ b/testsuite/gpiobench/gpiobench.c
@@ -20,25 +20,19 @@
  * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
+
 #include <stdlib.h>
-#include <math.h>
 #include <stdio.h>
 #include <string.h>
-#include <errno.h>
-#include <error.h>
 #include <signal.h>
 #include <sched.h>
 #include <time.h>
 #include <sys/time.h>
 #include <unistd.h>
 #include <pthread.h>
-#include <semaphore.h>
-#include <sys/timerfd.h>
-#include <xeno_config.h>
 #include <rtdm/testing.h>
 #include <rtdm/gpio.h>
 #include <boilerplate/trace.h>
-#include <xenomai/init.h>
 #include <sys/mman.h>
 #include <getopt.h>
 
diff --git a/testsuite/gpiotest/gpiotest.c b/testsuite/gpiotest/gpiotest.c
index 2e4b1bf4d..b86a88515 100644
--- a/testsuite/gpiotest/gpiotest.c
+++ b/testsuite/gpiotest/gpiotest.c
@@ -20,6 +20,7 @@
  * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
+
 #include <stdio.h>
 #include <error.h>
 #include <errno.h>
@@ -28,7 +29,6 @@
 #include <fcntl.h>
 #include <smokey/smokey.h>
 #include <rtdm/gpio.h>
-#include <boilerplate/time.h>
 
 smokey_test_plugin(interrupt,
 		   SMOKEY_ARGLIST(
diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
index 52e315d9d..fe688b9b8 100644
--- a/testsuite/latency/latency.c
+++ b/testsuite/latency/latency.c
@@ -21,6 +21,7 @@
  * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
+
 #include <stdlib.h>
 #include <math.h>
 #include <stdio.h>
diff --git a/testsuite/spitest/spitest.c b/testsuite/spitest/spitest.c
index 0b9aa62dc..88eca0246 100644
--- a/testsuite/spitest/spitest.c
+++ b/testsuite/spitest/spitest.c
@@ -20,15 +20,14 @@
  * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
+
 #include <sys/types.h>
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 #include <sys/timerfd.h>
 #include <stdio.h>
-#include <error.h>
 #include <semaphore.h>
 #include <errno.h>
-#include <stdlib.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <smokey/smokey.h>
diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index 91ac91303..434004450 100644
--- a/testsuite/switchtest/switchtest.c
+++ b/testsuite/switchtest/switchtest.c
@@ -20,6 +20,7 @@
  * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
+
 #include <ctype.h>
 #include <errno.h>
 #include <stdio.h>

-- 
2.39.5

