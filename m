Message-ID: <53B90F6A.30809@xenomai.org>
Date: Sun, 06 Jul 2014 10:57:14 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CABqyFP_DMH3t3Dp+AZPzXHXQb_j_VHkAjMMuBeLJ-5BTPPfk4g@mail.gmail.com>
In-Reply-To: <CABqyFP_DMH3t3Dp+AZPzXHXQb_j_VHkAjMMuBeLJ-5BTPPfk4g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Latency can be negative ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ruika You <crazylinuxcnc@gmail.com>, xenomai@xenomai.org

On 07/06/2014 06:19 AM, Ruika You wrote:
> Dear all,
> I build xenomai 2.6.3 base on ipipe stable 3.14.0 as linux kernel in my
> i386 PC. Everything seems work well, until i try to test latency. It is
> quite strange when negative  value occur. Any idea? My test result as
> follow:

These are early timer shots, happening a micro-second or so before the 
ideal date. The pre-calibration for your machine is pessimistic, you 
should decrease the /proc/xenomai/latency value until the minimum 
latency never drops below zero, keeping the worst-case as close as 
possible to zero.

i.e.
# echo [nanoseconds] > /proc/xenomai/latency

You can refine this value as the latency test runs in another window. 
Once you are happy with some calibration value, assign it to 
CONFIG_XENO_OPT_TIMING_SCHEDLAT in your kernel configuration.

Please note that depending on which latency is considered among 
user-space/kernel task scheduling, and interrupt handler, the most 
appropriate calibration value may be different. You have to find the 
best trade-off for your workload.

-- 
Philippe.

