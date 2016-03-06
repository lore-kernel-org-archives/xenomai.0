Date: Sun, 6 Mar 2016 16:08:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160306150817.GA1783@hermes.click-hack.org>
References: <56DC4081.4040807@esiee.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56DC4081.4040807@esiee.fr>
Subject: Re: [Xenomai] rtnet/xenomai-3.0.1+3.18.20kernel: tdma & nomac issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Grandpierre <thierry.grandpierre@esiee.fr>
Cc: xenomai@xenomai.org

On Sun, Mar 06, 2016 at 03:36:49PM +0100, Thierry Grandpierre wrote:
> Dear all,
> 
> I spent a week testing and browsing carefully the web but  didn't find 
> any answer to my problems, so I am writing here..
> 
> 1) RTNET/TDMA : I am unsuccessfully  trying to run rtnet/xenomai 3 on 2 
> virtual machines : a VM as master and a VM as slave. Synchro frames are 
> sent by the master and received on the slave machine (seen with 
> wireshark on the rteth0 of each machine) but slave never answer. Both 
> machine are VMs connected by a  VM to VM private network  (VMnet0 in 
> VMware)

Are you sure the network emulation you use transmit all kinds of
packets? In qemu, for instance, the default network emulation is not
able to transmit icmp packets and probably not rtcfg packets (they
use a custom ethertype). I have tested rtcfg with Xenomai 3.0.1 and
it worked. I have not tried transmitting files though, just used it
as a kind of DHCP.

> 
> Rtnet on the slave machine is waiting with message :
>      /usr/xenomai/sbin/rtcfg rteth0 add 10.0.0.2 -stage1 -
>      Waiting for all slaves.../usr/xenomai/sbin/rtcfg rteth0 wait"
> 
> Rtnet on the master machine is also hanging with message
>    /usr/xenomai/sbin/rtifconfig rteth0 up 10.0.0.2
>    Stage 1: searching for master...
> 
> I think rtnet on the slave machine doesn't see/understand the sync 
> frames. Below all details are given.
> 
> 2)RTNET/NOMAC:
> When trying nomac, once everything is configured, I'm getting " ioctl: 
> Resource temporarily unavailable" when pinging. Details are also given 
> at the end.

This probably means that the network is not up, but I am a little
confused, as I thought I added this check after the 3.0.1 release.
Are you using the 3.0.1 release, or the current git?
Anyway, if that is the case, when you run rtifconfig you should not
see the RUNNING flag. You have to wait for the network to be up and
running before being able to actually send packets.

-- 
					    Gilles.
https://click-hack.org

