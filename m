Date: Mon, 4 May 2015 12:04:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150504100441.GM1993@hermes.click-hack.org>
References: <20150504094745.GL1993@hermes.click-hack.org>
 <161457050.3957521.1430733251745.JavaMail.root@openwide.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161457050.3957521.1430733251745.JavaMail.root@openwide.fr>
Subject: Re: [Xenomai] Problem with the promiscuous mode of RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Damien Lagneux <damien.lagneux@openwide.fr>
Cc: xenomai@xenomai.org

On Mon, May 04, 2015 at 11:54:11AM +0200, Damien Lagneux wrote:
> Hi Gilles, 
> 
> Thank you for your quick reply.
> 
> Here is the script I'm using to set RTnet:
> #!/bin/sh
> 
> modprobe rtnet
> modprobe rt_fec
> modprobe rtpacket
> modprobe rtudp
> modprobe rtcap
> 
> rtifconfig rteth0 up 10.5.18.161 netmask 255.255.0.0 promisc

I do not see anything wrong in the code. rtifconfig seems to ask the
IFF_PROMISC flag to be set for the driver, and the driver code seems
to take this flag into account. So I guess you will have to trace
the path from rtifconfig to the driver code to see where the
information gets lost.

> ifconfig rteth0 up

Note that what you are doing here is enabling the rtcap interface
(which is a plain linux interface, and not the rtnet interface), you
may want to avoid doing that in a first step, in case it fiddles
with the promisc bit too.

-- 
					    Gilles.

