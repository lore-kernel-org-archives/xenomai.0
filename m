Message-ID: <2cf1ee820603280009r5adec759h99aa69809f68b457@domain.hid>
Date: Tue, 28 Mar 2006 11:09:50 +0300
From: "emin ak" <eminak71@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-help] gigabit rate packet processing with xenomai
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

Dear All;
I'am new with xenomai (and also adeos), firstly I would like to thank=20
who contributed to this project for this  high quality job. I have an
project that needs gigabit rate ethernet packet processing in user
space and need your recommendations.
I want to archive this with minimal kernel level device driver changes.
 According to my plan, I'll create a realtime user level thread and
this thread sleeps (with the mutex machanism in the native api) until
receiving a valid ethernet packet on ethernet interface that is
working regular linux domain. After receiving the packet, ethernet
driver releases the lock and sends packet to user level thread (with
shared memory or an other way).With this way, I have left the device
driver in linux domain, I'll only need to add locking and shared
memory system in the device driver.Does this system work? Does the
user level thread affect the functionallty of ethernet interface?Do I
need to implement all my user space thread and kernel level driver in
primaly domain?
Thanks again and B/regards.

