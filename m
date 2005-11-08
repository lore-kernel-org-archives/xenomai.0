Message-ID: <002f01c5e44a$b675bf50$1000000a@domain.hid>
From: "Hans-J. Ude" <ude@domain.hid>
Date: Tue, 8 Nov 2005 10:56:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Task lock/unlock unlock difficulties
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

I need to lock/unlock the scheduler from time to time. I'm using the RTAI
native skin in userspace and tried the rt_task_set_mode approach but was not
very successfus yet. I've tried this:

int task_lock(void) { return rt_task_set_mode(0, T_LOCK, &mask); }
int task_unlock(void) { return rt_task_set_mode(T_LOCK, mask, NULL); }

To support nested calls to these functions i've implement an array of masks
and lock/unlock counters to maintain a stack. I've also tried a single mask
and no stack and with no mask at all. No success. It's hard to explain what
exactly happens because I'm porting an existing software with a really bad
design but the original works. I found there are xenomai functions called
xnpod_lock_sched(), which are directly called from e.g. the vxWorks skin.
Obviously xn_pod_lock has an integrated counting. Otherwise the vx skin
would be incompatible. But when i include pod.h i get a whole bunch of error
messages, likely due to missing defines. So can someone show me a way to a
clean working counting lock/unlock mechanism.

TAI,
Hans


