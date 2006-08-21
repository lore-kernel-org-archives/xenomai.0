Subject: Re: [Xenomai-core] [patch, minor] xnpipe_recv and
	xntimer_get_timeout_periodic()
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0608210136w7ca05265o5ef930c1bee24d65@domain.hid>
References: <b647ffbd0608210136w7ca05265o5ef930c1bee24d65@domain.hid>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 12:02:18 +0200
Message-Id: <1156154538.4402.32.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-08-21 at 10:36 +0200, Dmitry Adamushko wrote:

> 
> [ pipe.c.patch ]  update the "timeout" variable so that the remaining
> timeout is used in case of consequent xnsynch_sleep_on() calls.
> 
> As I understand that may indeed happen in case when another thread
> "steals" data while this one waits to be scheduled in.

Indeed, but this case is already handled in xnsynch_sleep_on()
(see the test for the XNROBBED bit).

-- 
Philippe.



