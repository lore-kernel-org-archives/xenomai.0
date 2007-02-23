Subject: Re: [Xenomai-core] [PATCH] Bogus conversion to ns in
	rt_task_make_periodic() emulation
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <54823def0702221541l574a6eb9v1bb61dfd68395986@domain.hid>
References: <54823def0702221541l574a6eb9v1bb61dfd68395986@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 18:30:46 +0100
Message-Id: <1172251846.26738.86.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Andrew Dennison <andrewd.lists@domain.hid>
Cc: Xenomai-core@domain.hid

On Fri, 2007-02-23 at 10:41 +1100, Andrew Dennison wrote:
> The RTAI function rt_task_make_periodic() takes absolute ticks as the
> start_time argument, however this was being compared to ns in the RTAI
> emulation layer.
> 
> This patch fixes this, and also removes '+ period' as this seems wrong
> with the way xnpod_set_thread_periodic() works.
> 

Applied, thanks.

> Patch is against r1717 so it won't apply directly to head, but the
> same logical bug seems to exist there?

Indeed. Fixed in the trunk/ too, thanks.

-- 
Philippe.



