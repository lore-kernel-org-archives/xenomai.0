From: Michael Haberler <haberlerm@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <09EA8A4C-D8EB-4470-A339-C2019D1B662B@gmail.com>
Date: Thu, 30 Jul 2015 07:26:43 +0200
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: [Xenomai] mutate/start RT_TASK a posix thread?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

we're happily using RT threads using the Xenomai 2 thread API

is it possible _using this API_ to create/mutate/relax such a thread =
intentionally into a Posix thread but retaining the API usage?

I can do any conditional API usage through thread parameters to avoid =
calls which will not work for a relaxed thread, but I would like to =
retain the API (I guess I could switch to the posix skin but I would =
like to avoid another learning curve/test cycle for now)

going forward/Xenomai 3: what would be your recommendation to address =
the issue long-term?=20




(may sound like whacky question but great use case around here - turns =
out many jobs do not need RT capabilities but it would be handy to =
retain the flow)

thanks in advance,

- Michael


API used from =
http://www.xenomai.org/documentation/trunk/html/api/group__task.html :

rt_task_create
rt_task_delete
rt_task_inquire
rt_task_join
rt_task_resume
rt_task_self
rt_task_set_affinity
rt_task_set_mode
rt_task_set_periodic
rt_task_start,
rt_task_suspend
rt_task_unblock
rt_task_wait_period

ps: update on rtdm_native: 'sortof works' - I ran into a problem with =
unbalanced IRQ's which seems unrelated to rtdm_native but more related =
to my kernel fu; with a determined push/more clue it should be possible =
to transpose into 'fully works'=

