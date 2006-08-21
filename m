Subject: Re: [Xenomai-core] [patch, minor] xnpipe_recv and
	xntimer_get_timeout_periodic()
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0608210136w7ca05265o5ef930c1bee24d65@domain.hid>
References: <b647ffbd0608210136w7ca05265o5ef930c1bee24d65@domain.hid>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 11:36:40 +0200
Message-Id: <1156153000.4402.17.camel@domain.hid>
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

>  Not sure 1 should be returned in this case (so far I just did it the
> same way as xntimer_get_timeout_aperiodic()), I guess 0 would be
> better in both cases.

Zero (XN_INFINITE) is reserved to indicate a non-running timer.

-- 
Philippe.



