From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 2 May 2016 15:25:04 -0400
Message-ID: <20160502192504.GL2055@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] [PATCH] arm/ipipe: pinctrl-single: Fix build failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

arm/ipipe: pinctrl-single: Fix build failure

A ; was lost when adding IPIPE support to the pinctrl-single.c which is
only seen when building with IPIPE disabled.

Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>

index b00fe3a..637f923 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -218,7 +218,7 @@ struct pcs_device {
 #ifdef CONFIG_IPIPE
 	ipipe_spinlock_t lock;
 #else /* !IPIPE */
-	raw_spinlock_t lock
+	raw_spinlock_t lock;
 #endif /* !IPIPE */
 	struct mutex mutex;
 	unsigned width;

-- 
Len Sorensen

