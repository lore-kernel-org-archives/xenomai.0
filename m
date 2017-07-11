Date: Tue, 11 Jul 2017 10:41:33 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170711104133.4d12cfc7@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] secondary mode switches on rt_task_set_priority
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

i was asked to assist debugging a case where a SIGXCPU is received
after calling rt_task_set_priority. According to the docs that call
should not cause secondary mode switches, but it seems it does.
Xenomai 3.0.5 kernel 4.4.43

I did not start digging yet but wanted to ask if someone has already
come across that scenario.

Henning

Here some output from the signal-handler:

SIGXCPU signal detected! TID = 12743, reason = -53542910: <unknown>

Backtrace:
application sigxcpu handler
/lib/x86_64-linux-gnu/libpthread.so.0(+0x113d0)[0x7f133162f3d0]
/lib/x86_64-linux-gnu/libc.so.6(__sched_get_priority_max+0x7)[0x7f132f4ffd97]
/usr/lib/libcobalt.so.2(cobalt_xlate_schedparam+0x37)[0x7f1331a4fb87]
/usr/lib/libcobalt.so.2(pthread_setschedparam_ex+0x31)[0x7f1331a4fdc1]
/usr/lib/libcopperplate.so.0(copperplate_renice_local_thread+0x9)[0x7f1331c67c69]
/usr/lib/libcopperplate.so.0(threadobj_set_schedparam+0x6a)[0x7f1331c6af1a]
/usr/lib/libalchemy.so.0(rt_task_set_priority+0x59)[0x7f1331e81149]

