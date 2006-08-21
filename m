Subject: Re: [Xenomai-core] [patch, minor] xnpipe_recv and # CPE_ANT_R6.2
	(Slotted release R6) - ModemSoftware bant-z # Sun Aug 20 08:24:02 MEST
	2006
	element * CHECKEDOUT # linxiangcheng # Sat Aug 19 09:47:12 MEST 2006 #
	fix the bug: CPE_P00016456 element /cm4/fsn/app/pstack/sl
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0608210134n410d0814n427caa8a6dd0a822@domain.hid>
References: <b647ffbd0608210134n410d0814n427caa8a6dd0a822@domain.hid>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 14:51:51 +0200
Message-Id: <1156164711.4402.52.camel@domain.hid>
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

On Mon, 2006-08-21 at 10:34 +0200, Dmitry Adamushko wrote:

> [ pipe.c.patch ]  update the "timeout" variable so that the remaining
> timeout is used in case of consequent xnsynch_sleep_on() calls.

Applied, thanks.

-- 
Philippe.



