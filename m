Date: Tue, 3 Nov 2015 12:47:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151103114717.GA26720@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A705D34@mb2010-3.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A705D34@mb2010-3.intra.tut.fi>
Subject: Re: [Xenomai] Pcap replay tool for xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Nov 03, 2015 at 10:49:14AM +0000, Umair Ali wrote:
> Hello,
> 
> I am working on the project of playing back the pcap files in real
> time using xenomai patch on vanilla kernel. The main idea is to
> open the pcap file, read the file packet by packet and then send
> on the network as raw Ethernet packet.

To send raw ethernet packets, see "man 7 packet", here for instance:
http://man7.org/linux/man-pages/man7/packet.7.html

You should call socket(AF_PACKET, SOCK_RAW, 0);

Then send packets with sendto, using a sockaddr_ll structure for the
destination. The important part of the sockaddr_ll is the
ifr_ifindex member, the interface index (at least for RTnet, because
this is what allows to find the interface to use to send the packet).

The same code should work with RTnet "rtpacket" module. Only the
compilation process is different.

A rapid google search gives this result:
https://gist.github.com/austinmarton/1922600

In your case, of course, you would simply take the data from the
pcap file instead of filling the ethernet header and writing
0xdeadbeef as a payload.

> (...)
> I am also new to real time linux kernel.
> Moreover I tried to install the RTnet over the xenoami but most of
> the time my pc hangs up and I need to do the brutal restart.
> (...)

You do not tell us much about your setup, so it is difficult to help
you here. Maybe have a look here:
http://xenomai.org/troubleshooting-a-dual-kernel-configuration/#Kernel_OOPSes

Regards.

-- 
					    Gilles.
https://click-hack.org

