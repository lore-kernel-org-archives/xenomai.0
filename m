Message-ID: <5265A173.4030608@xenomai.org>
Date: Mon, 21 Oct 2013 23:49:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <l44714$imt$1@ger.gmane.org>
In-Reply-To: <l44714$imt$1@ger.gmane.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Slow Sockets and Pipes with POSIX Skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Neil T. Dantam" <ntd@gatech.edu>
Cc: xenomai@xenomai.org

On 10/21/2013 11:41 PM, Neil T. Dantam wrote:
> I am seeing some surprisingly high latencies for socket and pipe
> communication using Xenomai's POSIX skin.  Pipes, localhost TCP/UDP,
> and local domain sockets all show worst case latency of ~100us on
> Xenomai 2.6.2.1/Linux 3.4.6 on a Xeon E3-1270v2.  Average and 99%
> latency is under 20us.  Running `xeno-test latency` gives worst-case
> latency of ~10us.  POSIX message queues have worst case latency below
> 20us.
> 
> I've done the following to reduce latency:
> 
> * Disabled CPU frequency scaling
> * Disabled USB
> * Set real-time scheduling priority
> * Prefaulted the stack
> 
> The 100us delay seems like what one get from a System Management
> Interrupt (SMI).  However, since `xeno-test latency` and message
> queues both show low latency, it seems unlikely that this could be the
> issue.
> 
> Has anyone else encountered (or not encountered) similar performance
> issues with pipes and sockets?

Xenomai posix skin does not handle pipes, and only handles TCP/IP
sockets if you have installed and configured rtnet.

-- 
                                                                Gilles.

