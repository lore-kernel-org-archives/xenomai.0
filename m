Message-ID: <41f748550709022126g1bf2bf0bvb3fbf74373932b00@domain.hid>
Date: Mon, 3 Sep 2007 11:26:41 +0700
From: "Iwan Budi Kusnanto" <iwanbk@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Down interruptible
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

Hello all
why rt_sem_p does not have behaviour like down_interruptible (that
receive a signal while being blocked on a semaphore to give up the
"down"/"p" operation).Is that a bad design?
sem_wait (posix skin)have behaviour like that.

In what situation we must use posix skin?
In what situation we must use native skin?

thx


-- 
Iwan Budi Kusnanto

