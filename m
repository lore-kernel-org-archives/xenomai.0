Message-ID: <50EC2047.1060304@siemens.com>
Date: Tue, 08 Jan 2013 14:33:59 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <50ebff2e488690.18102992@wp.pl>
In-Reply-To: <50ebff2e488690.18102992@wp.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] SIGXCPU with rt_mutex_release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mariusz Janiak <mariuszjaniak@wp.pl>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-01-08 12:12, Mariusz Janiak wrote:
> Hi GIlles,
> 
> As you suggested, I have prepared simple test case that demonstrate how Xenomai is utilized by OROCOS. This test case behaves exactly the same like helloword example. Scheduler is chosen before any mutex are processed, so in my opinion it is not the case which you defined. What is really surprising is that the replacing TM_NONBLOCK with TM_INFINITE, in one before last line, do magic and suppress signal generation. Furthermore, there is no call to 'rt_task_set_mode(0, T_WARNSW, NULL);' so why 
> signal is generated? If we enable T_WARNSW in the thread, SIGXCPU is generated when mutex is locked first time in the thread. 

This should cure the issue (there was a check for XNTRAPSW missing):

diff --git a/ksrc/nucleus/synch.c b/ksrc/nucleus/synch.c
index e10be47..c1465dc 100644
--- a/ksrc/nucleus/synch.c
+++ b/ksrc/nucleus/synch.c
@@ -687,10 +687,11 @@ xnsynch_release_thread(struct xnsynch *synch, struct xnthread *lastowner)
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	if (xnthread_test_state(lastowner, XNOTHER)) {
-		if (xnthread_get_rescnt(lastowner) == 0)
-			xnshadow_send_sig(lastowner, SIGDEBUG,
-					  SIGDEBUG_MIGRATE_PRIOINV, 1);
-		else
+		if (xnthread_get_rescnt(lastowner) == 0) {
+			if (xnthread_test_state(lastowner, XNTRAPSW))
+				xnshadow_send_sig(lastowner, SIGDEBUG,
+						  SIGDEBUG_MIGRATE_PRIOINV, 1);
+		} else
 			xnthread_dec_rescnt(lastowner);
 	}
 #endif

Thanks for providing the test case.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

