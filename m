Message-ID: <500992D4.30505@xenomai.org>
Date: Fri, 20 Jul 2012 19:18:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E2AB2206BF591546A1931EA4E7A9FBC859BAFA22@Maui.in.dynetics.com>
In-Reply-To: <E2AB2206BF591546A1931EA4E7A9FBC859BAFA22@Maui.in.dynetics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RT_TASK affinity on more than 8 CPU's
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Wolz, Troy" <Troy.Wolz@dynetics.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/16/2012 10:16 PM, Wolz, Troy wrote:
> Hello,
> 
> I'm working on a project where I'd like to start more than 8 RT_TASKs
> each affined to their own CPU. From looking at the documentation,
> using the native API it appears to be possible to set affinity to a
> CPU from 0 to RTHAL_NR_CPUS-1. On my machine, RTHAL_NR_CPUS is 255,
> but when setting affinity above 7, overflow occurs and only the lower
> 8 CPU's are used.
> 
> Looking into this, the T_CPU macro appears to only use the lower 3
> bits of the value passed to it, implying that T_CPU only allows up to
> 8 CPU's to be used. Tracing through the use of this mask, it appears
> that the mode mask passed into rt_task_create uses the top 8 bits of
> the word as the cpu mask. The bits following the top 8 are used for
> other flags, so there is no room to expand the cpu mask.
> 
> I see 2 solutions to this limitation for using Xenomai and affinity
> on more than 8 cpus. 1. Expand the 'mode' argument from a 32 bit int
> to a 64 bit long. With the extra bits, the top 32 bits could be used
> as a CPU mask, allowing for up to 32 cpu's to be masked
> simultaneously. This change would affect several files, but it should
> be backwards compatible with applications currently written using a
> 32 bit mode.
> 
> 2. Pass an additional 64 bit long argument to rt_task_create that
> only contains the affinity mask. In this case, the mode argument
> would be used the same as previously, except the affinity would be
> ignored. This option has the disadvantage of being incompatible with
> existing Xenomai applications, but it is very easy to set affinity
> for up to 64 cpu's. We could add a preprocessor define that selects
> whether the existing rt_task_create method is available or whether
> the new method is available.

Solution 3: use glibc API to change affinity:
sched_setaffinity or pthread_setaffinity.

Also note that Xenomai design being based on a "big kernel lock", it
will scale poorly with too many cpus.

-- 
                                                                Gilles.

