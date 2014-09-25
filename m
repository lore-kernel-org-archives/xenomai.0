Date: Thu, 25 Sep 2014 13:40:04 +0200
From: =?utf-8?q?Petr_Cervenka?= <grugh@centrum.cz>
MIME-Version: 1.0
Message-Id: <20140925134004.CABE0A32@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] =?utf-8?q?Native_and_Posix_skins_together?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello.

I have a NATIVE skin application with using rt_task_shadow on the main task.
I recently added some library written in POSIX skin (ported from nrt to POSIX / RTNet).
But after adding correct linking flags, the function rt_task_shadow fails with -EBUSY error code.
Also rt_task_self returns NULL.
Is there a way to call such functions like rt_task_unblock and similar on the main task or do I need to rewrite it completely or partially?
What is the proper POSIX skin counter part to rt_task_unblock? Is it pthread_kill(threadId, SIGHUP)?
And what skin do you suggest to use for any new RT application.

Thanks in advance

Petr

