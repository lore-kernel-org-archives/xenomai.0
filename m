From: Paul Janzen <pcj@xenomai.sez.to>
Date: Fri, 8 Aug 2014 11:44:35 -0700
Message-ID: <oqegwqn4xu.fsf@merlin.sez.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Xenomai] [PATCH] hal/x86: Export symbol rthal_c1e_disable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 ksrc/arch/x86/c1e.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/ksrc/arch/x86/c1e.c b/ksrc/arch/x86/c1e.c
index a5bdc34..984c039 100644
--- a/ksrc/arch/x86/c1e.c
+++ b/ksrc/arch/x86/c1e.c
@@ -79,4 +79,5 @@ void rthal_c1e_disable(void)
 	}
 }
 
+EXPORT_SYMBOL_GPL(rthal_c1e_disable);
 #endif
-- 
1.7.1


