Subject: Re: [Xenomai-core] [patch, minor] xnpipe_recv and
	xntimer_get_timeout_periodic()
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0608210347y4a863588r607c403de0640e74@domain.hid>
References: <b647ffbd0608210136w7ca05265o5ef930c1bee24d65@domain.hid>
	<1156154538.4402.32.camel@domain.hid>
	<b647ffbd0608210347y4a863588r607c403de0640e74@domain.hid>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 13:27:11 +0200
Message-Id: <1156159631.4402.41.camel@domain.hid>
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

On Mon, 2006-08-21 at 12:47 +0200, Dmitry Adamushko wrote:
> 
> what about pipe-related change (I mean timeslice updating in
> xnpipe_recv()) ?
> 

It's basically useless, since xnsynch_sleep_on() handles the resource
stealing case internally, and the loop in xnpipe_recv is fake actually.
Think of it as a goto statement in disguise.

> 
> -- 
> Best regards,
> Dmitry Adamushko
-- 
Philippe.



