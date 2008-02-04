Message-ID: <2ff1a98a0802040725u4741ab60p440f2047a01a7f3f@domain.hid>
Date: Mon, 4 Feb 2008 16:25:38 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <op.t5z9ycg9t06gyn@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <op.t5z9ycg9t06gyn@domain.hid>
Subject: Re: [Xenomai-help] relationship of timestamp / timer functions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Axel Beierlein <belatronix@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

On Mon, Feb 4, 2008 at 4:14 PM, Axel Beierlein <belatronix@domain.hid> wrote:
> Hello,
>
>  which corresponding functions do i have to use when i try to get the
>  correct timediff between two events. Especially i get an timestamp with
>  every CAN Message (wich is implemented with rtdm_clock_read())and on the
>  other side i get a timestamp in my Userspace application with
>  rt_timer_tsc(). Are they are running at the same base so that i can use
>  the difference of both returned values of the functions?

rt_timer_read() corresponds to rtdm_clock_read(), but rt_timer_read()
returns the date as a count of clock ticks whereas rtdm_clock_read()
returns the date as a count of nanoseconds. So, if you are running in
periodic mode, you should compare CAN message timestamps with
rt_timer_ticks2ns(rt_timer_read()), if you are running in aperiodic
mode, rt_timer_ticks2ns simply returns the same value, so you can
directly compare the value returned by rtdm_clock_read() and
rt_timer_read().

-- 
                                               Gilles Chanteperdrix

