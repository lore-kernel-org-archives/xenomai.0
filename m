Date: Tue, 10 Apr 2018 09:50:30 -0400
Message-ID: <20180410135030.qh2gep2yxj5tnyga@csclub.uwaterloo.ca>
References: <CAOuPNLgfpzTWgeBZcsntHDP07cOPyvhPEZM6WsQ453s=6id3tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLgfpzTWgeBZcsntHDP07cOPyvhPEZM6WsQ453s=6id3tA@mail.gmail.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [Xenomai] [RTNET]: Which rtnet driver to use with beagle bone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Apr 10, 2018 at 06:52:11PM +0530, Pintu Kumar wrote:
> Hi,
> 
> I am using:
> Beagle Bone Kernel: 4.9.51
> Xenomai: 3.0.6
> Board: Beagle Bone White
> 
> When I enable RTNET, the following ethernet drivers are build.
> $ ls drivers/xenomai/net/drivers/*.ko
> drivers/xenomai/net/drivers/rt_8139too.ko
> drivers/xenomai/net/drivers/rt_eepro100.ko
> drivers/xenomai/net/drivers/rt_loopback.ko
> 
> But I think beagle bone using different ethernet driver.
> ti_cpsw
> CONFIG_TI_CPSW=y
> Also this is by default in-built into the kernel. So I cannot remove the module.
> 
> When I try installing the available once it did install but network
> did not work.
> rtnet                  52594  10
> rt_8139too,rtipv4,rt_loopback,rtmac,rt_eepro100,rtpacket,rtudp,rt_e1000,rtcfg,tdma
> 
> # /usr/xenomai/sbin/rtifconfig rteth0 up
> ioctl: No such device
> 
> 
> So, I wanted to know is there any rtnet ethernet driver available
> which works with beagle bone ?

Well based on the list above, the answer appears to be none of them.

The cpsw is one of the weirdest network designs I have ever encountered.
It is a network interface missing a bunch of standard features (like mac
filtering) connected to a switch chip which is responsible for the mac
filtering and such while also being a switch.  It can be quite annoying
to deal with.

On the design I worked on we ended up using a PRU ethernet port for
xenomai instead because the cpsw was just not sane to work with.
Don't have that option on the beagle though.

-- 
Len Sorensen

