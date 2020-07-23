From: Steven Seeger <steven.seeger@flightsystems.net>
Subject: Re: Dovetail <-> PREEMPT_RT hybridization
Date: Thu, 23 Jul 2020 09:09:31 -0400
Message-ID: <4555996.GXAFRqVoOG@omoikane>
In-Reply-To: <b4c53b27-3de9-3264-0a3f-0563f95321ec@xenomai.org>
References: <2c2da877-f9e7-9be7-d659-c51235738bc0@xenomai.org>
 <BYAPR11MB3765087193BDF5EB45094A5DEE780@BYAPR11MB3765.namprd11.prod.outlook.com>
 <b4c53b27-3de9-3264-0a3f-0563f95321ec@xenomai.org>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Meng, Fino" <fino.meng@intel.com>, Evl <evl@evlproject.org>, xenomai@xenomai.org
Cc: Philippe Gerum <rpm@xenomai.org>

On Tuesday, July 21, 2020 1:18:21 PM EDT Philippe Gerum wrote:
> 
> - identifying and quantifying the longest interrupt-free sections in the
> target preempt-rt kernel under meaningful stress load, with the irqoff
> tracer. I wrote down some information [1] about the stress workloads which
> actually make a difference when benchmarking as far as I can tell. At any
> rate, the results we would get there would be crucial in order to figure
> out where to add the out-of-band synchronization points, and likely of some
> interest upstream too. I'm primarily targeting armv7 and armv8, it would be
> great if you could help with x86.

So from my perspective, one of the beauties of Xenomai with traditional IPIPE 
is you can analyze the fast interrupt path and see that by design you have an 
upper bound on latency. You can even calculate it. It's based on the number of 
cpu cycles at irq entry multiplied by the total numbers of IRQs that could 
happen at the same time. Depending on your hardware, maybe you know the 
priority of handling the interrupt in question.

The point was the system was analyzable by design.

When you start talking about looking for long critical sections and adding 
sync points in it, I think you take away the by-design guarantees for latency. 
This might make it less-suitable for hard realtime systems.

IMHO this is not any better than Preempt-RT. But maybe I am missing something. 
:)

Steven




