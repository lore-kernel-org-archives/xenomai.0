Date: Wed, 2 Mar 2016 14:25:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160302132514.GB14986@hermes.click-hack.org>
References: <56d616b706ffa3.50702648@wp.pl>
 <20160302130733.GA14986@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160302130733.GA14986@hermes.click-hack.org>
Subject: Re: [Xenomai] Odp: Re: RTnet -- receive broadcast frame at the
 local machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mariusz Janiak <mariuszjaniak@wp.pl>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Mar 02, 2016 at 02:07:33PM +0100, Gilles Chanteperdrix wrote:
> On Tue, Mar 01, 2016 at 11:24:55PM +0100, Mariusz Janiak wrote:
> > > From what I understand from this post, it is not easy to fix, as it
> > > requires duplicating packets. So, patch welcome.
> > 
> > Ok, we went back to the original question, could someone point the
> > place that has to be modified. I have played a little bit with the
> > RTnet stack recently, but this task require far better
> > understanding of the stack. Maybe someone more advanced can give
> > some guidelines.
> 
> It is not that complicated. The udp send function (rt_udp_sendmsg)
> is in udp.c, it calls rt_ip_route_output (found in route.c) to find
> the output route, than rt_ip_build_xmit (found in ip_output.c) to
> build the packet and send in on the device. rt_ip_build_xmit calls
> rt_eth_header to build the ethernet header (found in eth.c), then
> rtdev_xmit (found in dev.c) to send the packet.
> 
> So you can do this either at the IP level in rt_ip_build_xmit, or at
> the ethernet level in rtdev_xmit. What you need to do is that when
> the destination is broadcast (there should be a macro to test that
> an IP address is broadcast if you want to do it at IP level, and the
> mac address for broadcast is just ff:ff:ff:ff:ff:ff if you want to
> do it at ethernet level) you need to duplicate the packet, and
> either trigger a receive on the same device, or send the packet on
> the loopback device. If you go the ethernet route, you will have to
> use a per-device callback to test if the destination is broadcast,
> as rtdev_xmit is supposed to not be specific to ethernet, like is
> done with the hard_header and start_xmit callbacks.

Note that doing this at ethernet level is better, as it will also
work for packets sent with raw sockets, and also note that to test
if a MAC address is broadcast, you only need to test the most
significant byte least significant bit. If you do it that way, it
also gets the trick working with multicast addresses.

-- 
					    Gilles.
https://click-hack.org

