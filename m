Message-ID: <4757EBAE.4050608@domain.hid>
Date: Thu, 06 Dec 2007 13:31:42 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] How to cancel a Xenomai POSIX thread
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

Hello,

how do I cancel or delete a Xenomai POSIX thread running in primary
context from a higher priority thread? IIUC, pthread_kill() can only be
used in secondary context. I tried pthread_cancel(), but it only works
when hitting a cancelation point, e.g. pthread_testcancel(). Setting
pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS) did not help. Is
there a code snippet or even an example program showing how to cancel a
pthread in primary context?

TIA,

Wolfgang.


