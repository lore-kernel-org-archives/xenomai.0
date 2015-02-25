Date: Wed, 25 Feb 2015 21:46:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150225204657.GC2912@hermes.click-hack.org>
References: <CAB6vvj=qpKhxcW=88vo0Gr6CBAd=VH+ann3i=OHkZYnNNkXFpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB6vvj=qpKhxcW=88vo0Gr6CBAd=VH+ann3i=OHkZYnNNkXFpA@mail.gmail.com>
Subject: Re: [Xenomai] rtnet issue with xenomai-3.git next branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine Hoarau <hoarau.robotics@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Feb 25, 2015 at 01:23:17PM +0000, Antoine Hoarau wrote:
> >You are missing
> >CONFIG_XENO_DRIVERS_NET_RTIPV4_ICMP in your kernel configuration.
> >ping uses icmp packets, so, if you do not enable icmp, ping is not
> >going to work.
> 
> Now it's working ! Thank you Gilles !
> 
> cd /usr/xenomai/sbin
> 
> sudo modprobe rtnet #Loaded at startup
> sudo modprobe rt_e1000e #Loaded at startup because e1000e is blacklisted
> sudo modprobe rtudp
> 
> sudo ./rtifconfig rteth0 up 192.168.100.101 netmask 255.255.255.0
> sudo ./rtroute solicit 192.168.100.102 dev rteth0
> 
> sudo ./rtifconfig
> sudo ./rtroute
> 
> # Wait a bit..
> sudo ./rtping 192.168.100.102

Ok, it would be nice to know what is the difference with the rtnet
script. 

-- 
					    Gilles.

