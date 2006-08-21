Subject: Re: [Xenomai-core] [patch, minor] xnpipe_recv and
	xntimer_get_timeout_periodic()
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0608211045m24073f66s7fcbf56c5ed78f4f@domain.hid>
References: <b647ffbd0608210136w7ca05265o5ef930c1bee24d65@domain.hid>
	<1156153751.4402.28.camel@domain.hid>
	<b647ffbd0608211045m24073f66s7fcbf56c5ed78f4f@domain.hid>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 20:02:02 +0200
Message-Id: <1156183323.4321.14.camel@domain.hid>
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

On Mon, 2006-08-21 at 19:45 +0200, Dmitry Adamushko wrote:
> 
> 
> On 21/08/06, Philippe Gerum <rpm@xenomai.org> wrote:
>         On Mon, 2006-08-21 at 10:36 +0200, Dmitry Adamushko wrote:
>         
>         > [ timer.c.patch] xnticks_t is unsigned while (as I
>         understand)
>         > "xntlholder_date(&timer->plink) - nkpod->jiffies" can be
>         negative.
> 
> ok, I somehow missed a check for xntimer_running_p() in
> xntimer_get_timeout(). I bet it was not there when I was looking at
> this part of code yesterday or maybe I just had too much ummmm
> wonderful belgium beer :o)

It's been there since the fusion times! Ok, it must be the beer... :o>

> 
> Actually xntimer_get_timeout() should be called with nklock held + irq
> off as it must be atomic. But anyway, this is how it's used in all
> places and it's probably not supposed to be used "as is" from any
> upper layer. So it's ok.
> 

Indeed.

> 
> 
> -- 
> Best regards,
> Dmitry Adamushko
-- 
Philippe.



