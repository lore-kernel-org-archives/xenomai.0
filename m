From: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Date: Sat, 06 Oct 2018 10:07:49 +0200
Message-ID: <3016131.PUnFZZDcdA@lenni>
In-Reply-To: <1806354.2vQZyoBssO@wirbelwind>
References: <C2EC5BA46D13CD44B5915A8FEEB4C44ED1819D8C@DDCEXCH.ddc-ny.com>
 <1806354.2vQZyoBssO@wirbelwind>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai] Does RTNET supports TCP?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, steven.seeger@nasa.gov
Cc: "Hillman, Robert" <hillman@ddc-web.com>

Hi all,

Steven Seeger wrote:
> On Thursday, October 4, 2018 9:02:46 PM EDT Pham, Phong wrote:
> > Hi,
> > 
> > I noticed starting Xenomai 3.0.1 until now (3.0.7), there is net/ in
> > .../kernel/drivers/ and in ../kernel/drivers/net/stack/ipv4/Kconfig
> > 
> > # source "drivers/xenomai/net/stack/ipv4/tcp/Kconfig"
> 
> I don't know why this is commented out. It looks like Gilles's initial
> import of this file in commit
> 106ffba7b55d506143966ff16158ee79b0007336 had it commented out.
> 
> I know that UDP is typically used with RTNET. TCP is complicated and
> has a lot of timers and dynamic state that makes it less than
> desirable for hard- realtime systems. Probably Jan should chime in on
> this. I think he has the most experience using RTnet at this point.
> 
> > 5)      When I created a socket with rt_dev_socket(AF_INET,
> > SOCK_STREAM, 0); and attempting to rt_dev_connect(fd,
> > server_ip_addr,
> > sizeof(server_ip_addr)), I get errno = 25 (Inappropriate ioctl for
> > device).> 
> >  Does it mean b/c TCP is not supported in RTnet and I attempt to
> >  connect> 
> > via TCP (w/ socket SOCK_STREAM)?
> 
> Sorry I can't answer the other questions, as I am not working on rtnet
> myself. However, I would suspect that since TCP doesn't compile that
> is why SOCK_STREAM is not working.

In the old days of Xenomai 2.6 rttcp worked so I am confident that we can 
make it work again.

Currently, I am working on fixing two additional bugs in rttcp and I can 
include this compile bug in rt_tcp_accept() Phong found. I will soon 
come up with a patch series, I think.

> Try SOCK_DGRAM and see if it
> works. If not, then are you sure you have rtnet drivers for your
> network device compiled and ready to use? Remember, the driver for
> your network device must be realtime-safe. I recall seeing a guide
> for some simple changes to make to a Linux ethernet driver to use as
> a starting point for porting it to RTNET, but I can't seem to find
> it. Anyone?

Do you mean kernel/drivers/net/doc/README.drvporting?

-- 
Sebastian





