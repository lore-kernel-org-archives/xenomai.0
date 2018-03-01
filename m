References: <9d0a8dc6-d16d-e3e2-8d20-400e5e2e4b4c@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f0fbe41c-cd42-0991-9f3f-dd1f8c214e69@xenomai.org>
Date: Thu, 1 Mar 2018 18:51:15 +0100
MIME-Version: 1.0
In-Reply-To: <9d0a8dc6-d16d-e3e2-8d20-400e5e2e4b4c@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Winter^W y2038 is coming
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 02/21/2018 07:33 PM, Jan Kiszka wrote:
> Hi,
> 
> likely due to some platform oddities (still has to be analyzed in more
> details), we are running into the situation that xntimer_grab_hardware
> on a x86-64 host tunes nkclock.wallclock_offset to a value that is not
> compatible with the 32-bit time_t ABI of compat applications. If you do
> a pattern like
> 
>     abs_timeout = clock_gettime(CLOCK_REALTIME) + rel_timeout
>     some_abs_wait(abs_timeout)
> 
> that abs_wait will practically wait forever. The same bug can also be
> triggered by doing a
> 
>     clock_settime(CLOCK_REALTIME, -negative_date)
> 
> I'm now wondering if we should take measures that detect or even prevent
> the setting of invalid dates in the presence of 32-bit ABIs. Or if we
> should suggest/demand the setting of -D_TIME_BITS=64 already. The clock
> is ticking... Thoughts?
> 

AFAIU, y2038 will hit any configuration showing timespec32 in the table
below:

CPU-bitness    	ABI		Timespec

64		native		timespec64
64		x32*		timespec64
64		ia32*		timespec32
32		native		timespec32

(*) x86 specific

To sum up, x86_64 applications using the ia32 ABI, and any application
running on a 32bit CPU won't make it after that date, with the current code.

Ignoring the case of 32bit platforms for which there does not seem to be
much of a hope in mainline anyway, I would favor option #2 for ia32
apps, i.e. assume that the underlying *libc can be told to pass
timespec64 arguments, and have the compat mode wrappers in Cobalt assume
userland always gives timespec64.

To make sure kernel & userland agree on the timespec bitness, we could
add a dedicated information bit to cobalt_bindreq::feat_req.

I believe that those updates should go to 3.1, since they induce ABI
changes, and it seems reasonable to ask ia32 ABI users to upgrade the
*libc (for getting the timespec64 switch) along with the real-time core
and libraries.

-- 
Philippe.

