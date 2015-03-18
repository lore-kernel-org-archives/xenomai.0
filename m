Date: Wed, 18 Mar 2015 08:42:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150318074211.GK16113@hermes.click-hack.org>
References: <tencent_6C3FD8E83CD0092927B8FE71@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_6C3FD8E83CD0092927B8FE71@qq.com>
Subject: Re: [Xenomai] How to sync a task to GPS ptp time ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?5Lmm5ZGG5a2Q?= <zhoupeng1982@qq.com>
Cc: xenomai <xenomai@xenomai.org>

On Tue, Mar 17, 2015 at 03:14:58PM +0800, 书呆子 wrote:
> I need a periodic task run according to GPS ptp time, 
> and native skin will be used.
> 
> A linux e1000e driver is used to talk to 1588 GPS master,
> ptp4l program can maintain PHC clock sync to GPS time.
> 
> I think rt_task_sleep_until(RTIME date) may be used if I carefully 
> calculate 'date' as I need.
> 
> But xenomai has it's own 'wallclock_offset', which is init when boot.
> Because TSC clocksource is not very accurate, so 'wallclock_offset'
> need adjust frequently according to PHC clock.
> 
> The ksrc/nucleus provide a function xntbase_adjust_time which can be 
> used to adjust 'wallclock_offset', but how can I do it in userspace?
> 
> And my idea feasible or not ?

Sure, but you will have to use clock_settime() from the POSIX skin.

-- 
					    Gilles.

