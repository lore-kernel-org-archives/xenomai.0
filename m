References: <56210E7E.1050606@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5621102C.4030902@siemens.com>
Date: Fri, 16 Oct 2015 16:56:44 +0200
MIME-Version: 1.0
In-Reply-To: <56210E7E.1050606@siemens.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3: kill() to non-Xenomai PIDs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On 2015-10-16 16:49, Jan Kiszka wrote:
> Hi,
> 
> kill() is currently handled by libcobalt such that PIDs <= 0 are
> forwarded to Linux and PIDs > 0 are considered to target only Xenomai
> threads. But what if the user wants to address a regular Linux task from
> within a Xenomai application? Shouldn't we retry kill via the Linux path
> if Xenomai's syscall reports ESRCH?
> 

IOW:

diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
index aac4059..7e03301 100644
--- a/lib/cobalt/signal.c
+++ b/lib/cobalt/signal.c
@@ -99,6 +99,10 @@ COBALT_IMPL(int, kill, (pid_t pid, int sig))
 
 	ret = XENOMAI_SYSCALL2(sc_cobalt_kill, pid, sig);
 	if (ret) {
+		/* Retry with regular kill is no RT target was found. */
+		if (ret == -ESRCH)
+			return __STD(kill(pid, sig));
+
 		errno = -ret;
 		return -1;
 	}

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

