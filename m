References: <trinity-1ef46b53-74c5-4379-96b4-54a2dac80070-1538499509655@3c-app-webde-bap30>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <31bc6c5a-6323-2500-85e5-68044eb8ba4f@xenomai.org>
Date: Tue, 2 Oct 2018 19:32:06 +0200
MIME-Version: 1.0
In-Reply-To: <trinity-1ef46b53-74c5-4379-96b4-54a2dac80070-1538499509655@3c-app-webde-bap30>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_pipe_write Latencies at alchemy skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sascha-Carsten Wedler <FXMaveric@web.de>, xenomai@xenomai.org

On 10/02/2018 06:58 PM, Sascha-Carsten Wedler wrote:
>    Hello,
> 
>    i'm using xenomai 3.0.2 on a SMP Kernel and have running a periodic
>    alchemy xenomai task at 10kHz.
>    This task sends data to a non xenomai (linux) task running in an other
>    process using rt_pipe_write and will be read out by a file read
>    operation.
>    I sends every 50x per sec about 25K to the linux process.
>    About every 500ms it occurs, that the call of the rt_pipe_write command
>    takes upto 100x more time, than it normaly does.
>    I've  measured this using rt_timer_read before and after the call.
>    I can't find out why this happend.
>    The size of the pipe buffer has no influence to this and will be read
>    out from linux side fast engough.
>    Can there be any dependencies to the "read process" at linux side?
>    Are there any circumstances which can affect this issue?
> 
>    Hope you can help me with a hint.
> 

We neither know the CPU architecture nor the kernel release from your
description.

Anyway, there is no wait state on the rt side of a pipe, either the
resources (e.g. memory) are there to proceed immediately, or the call
fails with an error status. So if rt_pipe_write() blocks the thread,
this is unexpected.

Assuming there is no high priority periodic rt activity actually
stealing the CPU every 500ms, I would start by checking the output of
/proc/xenomai/sched/stat, regarding the PF and MSW fields for the writer
thread.

If any of those increase over time (especially the latter), then you may
want to enable the spurious relax detector [1]. Since 3.0.2 is quite
outdated, only backtracing from the application itself may be available
to you, slackspot might not work properly in this release.

[1] https://gitlab.denx.de/Xenomai/xenomai/wikis/Finding_Spurious_Relaxes

-- 
Philippe.

