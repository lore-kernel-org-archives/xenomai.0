Message-ID: <48AAF7DB.1080603@domain.hid>
Date: Tue, 19 Aug 2008 18:42:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [BUG] Lock stealing is borken
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

bad news, everyone :(. According to the result of some lengthy debug
session with a customer and several ad-hoc lttng instrumentations, we
have a fatal bug in the nucleus' implementation of the lock stealing
algorithm. Consider this scenario:

1. Thread A acquires Mutex X successfully, ie. it leaves the (in this
   case) rt_mutex_acquire service, and its XNWAKEN flag is therefore
   cleared.

2. Thread A blocks on some further Mutex Y (in our case it was a
   semaphore, but that doesn't matter).

3. Thread B signals the availability of Mutex Y to Thread A, thus it
   also set XNWAKEN in Thread A. But Thread A is not yet scheduled on
   its CPU.

4. Thread C tries to acquire Mutex X, finds it assigned to Thread A, but
   also notices that the XNWAKEN flag of Thread A is set. Thus it steals
   the mutex although Thread A already entered the critical section -
   and hell breaks loose...

Looks like the XNWAKEN flag is misplaced in the owner's thread flags.
Can we safely move it into the synch object?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

