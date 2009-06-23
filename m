MIME-Version: 1.0
Sender: emblem@domain.hid
Date: Tue, 23 Jun 2009 15:05:19 -0400
Message-ID: <7ed3bc8b0906231205o47c31453ja95bef2e8f6d3121@domain.hid>
From: Stuart O Anderson <soa@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rt_sem_p: No such process
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

Hello -

I'm seeing rt_sem_p and rt_sem_broadcast return a "No such process"
error code, which isn't one of the listed possibilities in the
documentation.  This must be happening because the call to
xeno_h2obj_validate on line 495 in ksrc/skins/native/sem.c is
returning NULL.

This happens, but not consistently, when I kill one of the two
user-space realtime processes that are using the semaphore (the other
one then gets this error every time it tries to touch the semaphore).
Restarting the second process, and re-binding to the semaphore does
not stop the error from occurring.

Stuart

