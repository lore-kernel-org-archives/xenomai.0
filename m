Message-ID: <514092EE.5090406@siemens.com>
Date: Wed, 13 Mar 2013 15:53:34 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] Do not overwrite pre-existing SIGDEBUG handler in
	xeno_skin_bind
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

In case the application already set a SIGDEBUG handler, let that one
handle any potential SIGDEBUG_NOMLOCK events and keep our handler
(xeno_handle_mlock_alert) out of the loop. This helps in scenarios where
skin libraries are loaded belatedly via dlopen.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Anything that speaks against this? We ran into that issue with a large
application, and that can be one way to solve but should even make
sense in general.

 include/asm-generic/bits/bind.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/bits/bind.h b/include/asm-generic/bits/bind.h
index 269be95..f39c853 100644
--- a/include/asm-generic/bits/bind.h
+++ b/include/asm-generic/bits/bind.h
@@ -23,6 +23,11 @@ xeno_bind_skin(unsigned skin_magic, const char *skin, const char *module)
 		exit(EXIT_FAILURE);
 	}
 
+	/* do not overwrite an already installed SIGDEBUG handler */
+	sigaction(SIGXCPU, NULL, &sa);
+	if (sa.sa_handler != SIG_DFL)
+		return muxid;
+
 	sa.sa_sigaction = xeno_handle_mlock_alert;
 	sigemptyset(&sa.sa_mask);
 	sa.sa_flags = SA_SIGINFO;
-- 
1.7.3.4

