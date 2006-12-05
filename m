Subject: Re: =?ISO-8859-1?Q?R=E9p=2E?= : Re: [Xenomai-help]  Switch mode
	with x86
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45748DE3.9030300@domain.hid>
References: <s56d88c0.099@domain.hid>  <45732660.6050605@domain.hid>
	<1165175999.4952.431.camel@domain.hid>  <45733D1B.7010805@domain.hid>
	<1165188655.4952.457.camel@domain.hid> <4573D896.9050200@domain.hid>
	<45748DE3.9030300@domain.hid>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 23:18:22 +0100
Message-Id: <1165357102.7218.16.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-12-04 at 22:06 +0100, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > ...
> > This indicates that we face an I-pipe bug: the scheduled Linux call on
> > relaxation of TASK2 and then later TASK1 somehow gets lost (there is no
> > rthal_apc_handler in the remaining trace).
> 
> I think I got it. No I-pipe bug, but one in the HAL.
> 
> What happened? A weird race caused by the unprotected optimisation to
> only call rthal_schedule_irq() if there is no APC pending yet. This is
> the constellation I finally worked out via instrumenting and tracing:
> 

Btw, really nice spot. This one was really bad to the bone. Thanks.

-- 
Philippe.



