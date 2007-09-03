From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <41f748550709022126g1bf2bf0bvb3fbf74373932b00@domain.hid>
References: <41f748550709022126g1bf2bf0bvb3fbf74373932b00@domain.hid>
Content-Type: text/plain
Date: Mon, 03 Sep 2007 11:08:47 +0200
Message-Id: <1188810527.6037.10.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Down interruptible
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Iwan Budi Kusnanto <iwanbk@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2007-09-03 at 11:26 +0700, Iwan Budi Kusnanto wrote:
> Hello all
> why rt_sem_p does not have behaviour like down_interruptible (that
> receive a signal while being blocked on a semaphore to give up the
> "down"/"p" operation).Is that a bad design?
> sem_wait (posix skin)have behaviour like that.

rt_sem_p automatically switches the pending thread to secondary mode
upon signal receipt, so that it can process this signal from a regular
Linux context, then -EINTR is returned to the caller.

> 
> In what situation we must use posix skin?
> In what situation we must use native skin?
> 

The native skin resembles traditional RTOS interfaces; if you know about
VxWorks, VRTX, pSOS and the like, it should sound familiar.
OTOH, choosing the POSIX interface has the advantage of keeping all
options open to move away from Xenomai, since it aims at conforming to
the opengroup's specs.

> thx
> 
> 
-- 
Philippe.



