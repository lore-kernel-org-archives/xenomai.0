Message-ID: <52EEBDA7.2000102@xenomai.org>
Date: Sun, 02 Feb 2014 22:50:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6E05996E-AC72-4B77-88D1-A4BBC57C9827@mah.priv.at>
In-Reply-To: <6E05996E-AC72-4B77-88D1-A4BBC57C9827@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] packet_mmap raw socket usable from Xenomai?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 02/01/2014 06:58 PM, Michael Haberler wrote:
> I am looking into ethernet I/O from a RT thread, but am willing to
> tradeoff some latency against using stock linux drivers

The tradeoff is not about latency. It is about determinism. You can not
expected bounded latencies when in secondary mode and without preempt_rt.

> 
> also I'd like to use a common method across RT-PREEMPT and Xenomai
> thread styles to keep the number of moving parts low
> 
> One method which looks promising is the PACKET_TX_RING/PACKET_RX_RING
> methods of the packet_mmap raw sockets; it seems packet read is
> possible with only shared memory r/w and a transmit entails a
> sendto() socket call passing a reference to the packet in the
> transmit ring (so skbufs arent used except in the driver per se) - I
> do assume though that sendto() will cause a domain switch even if it
> is just a notification to the driver
> 
> am I blundering down a dead end? Is RTnet my only option even if I
> dont need the IP and above stack, and the low latency RTnet
> provides?

RTnet will allow you to use send/recv service without leaving primary
mode, any other method based on Linux system calls will cause a thread
to switch to secondary mode, and loose determinism.

> 
> if not - is it conceivable to handle this sendto() driver
> notification via an RTDM driver? I dont need RX notification because
> the shm test is cheap and threads are cyclic anyway

I do not think RTnet implement packets mapped in user-space. That said,
user-space mapped packets are useful for a high throughput, if you only
care about having bounded latencies, packets copied from user-space to
kernel-space do just fine (they have a higher latency due to the copy,
but the latency remains bounded).

Regards.

-- 
                                                                Gilles.

