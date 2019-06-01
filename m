From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 8/8] lib/cobalt: kickstart backtrace() from safe context
Date: Sat,  1 Jun 2019 17:15:02 +0200
Message-Id: <20190601151502.27216-9-rpm@xenomai.org>
In-Reply-To: <20190601151502.27216-1-rpm@xenomai.org>
References: <20190601151502.27216-1-rpm@xenomai.org>
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

Kickstart backtrace() so that it may call malloc() from a safe context
when installing the SIGSHADOW handler, not later on from that handler.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 lib/cobalt/sigshadow.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/cobalt/sigshadow.c b/lib/cobalt/sigshadow.c
index fc8adf648..68d3e6276 100644
--- a/lib/cobalt/sigshadow.c
+++ b/lib/cobalt/sigshadow.c
@@ -97,10 +97,18 @@ static void sigshadow_handler(int sig, siginfo_t *si, void *ctxt)
 
 static void install_sigshadow(void)
 {
+	void *dummy[SIGSHADOW_BACKTRACE_DEPTH];
 	struct sigaction new_sigshadow_action;
 	sigset_t saved_sigset;
 	sigset_t mask_sigset;
 
+	/*
+	 * Kickstart backtrace() so that it may call malloc() from a
+	 * safe context right now, not later on from the sigshadow
+	 * handler.
+	 */
+	backtrace(dummy, SIGSHADOW_BACKTRACE_DEPTH);
+
 	sigemptyset(&mask_sigset);
 	sigaddset(&mask_sigset, SIGSHADOW);
 
-- 
2.20.1


