Message-ID: <4E3088A4.3010903@domain.hid>
Date: Wed, 27 Jul 2011 23:52:36 +0200
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] rt_task_delete or rt_task_suspend strange behavior
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

i'm using xenomai 2.5.6 stable implemented for Marvell mv78xx on Arm.
I have a very strange behaviour.

I have 60 tasks and some tasks delete other tasks. In the case that one 
task delete/suspend a task that  is just deleted/suspended,
the next delete/suspend kill the wrong task and if i print the sequence 
i see that rt_task_delete or rt_task_suspend
returned the value -3 (-ESRCH) that is NOT documented in the manual.

Unfortunately i can't send the source code because it's very large and i 
cannot see the problem with a small program.

Any ideas ?

Thanks for all

