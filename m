Date: Wed, 12 Oct 2005 07:33:19 -0700
From: Steven Seeger <steve@domain.hid>
Message-ID: <BF726CBF.17F0%steve@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Subject: [Xenomai-help] remove_proc_entry problem semi-tracked down
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

The kernel panic in remove_proc_entry happens when a userspace fusion app
calls a xenomai function that deletes something from the register in atexit.
For example, I have a set of c++ classes that wrap mutexes, queues, etc. If
I have a global instance, it sometimes causes a kernel panic in the
destructor where the rt_mutex_delete, rt_queue_delete, etc, is called. This
seems to always happen with rt_queue_delete, but not always with
rt_mutex_delete. (A couple of starts/stops seem to create the problem.)

This is when exiting with a call to exit(0), not with a control-c.

Steven


