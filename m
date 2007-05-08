From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17984.50298.842145.884348@domain.hid>
Date: Tue, 8 May 2007 20:42:02 +0200
In-Reply-To: <1178645689.7883.9.camel@domain.hid>
References: <1178645689.7883.9.camel@domain.hid>
Subject: Re: [Xenomai-help] rtser not showing up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Brandt Erickson <berickso@domain.hid>
Cc: xenomai@xenomai.org

Brandt Erickson wrote:
 > Hi,
 > I'm trying to get realtime communication over the serial port to work
 > using the example found here
 > 
 > 	http://www.captain.at/xenomai-serial-port-example.php
 > 
 > I compiled a 2.6.20-6 kernel with xenomai-2.3.1 and configure the
 > realtime serial driver to be a loadable module.  I disabled the default
 > linux serial driver using 'setserial'.  However, when I run
 > 
 > 	modprobe xeno_16550A ioaddr=0x3f8 irq=4
 > or
 > 	insmod ./xeno16550A.ko ioaddr=0x3f8 irq=4
 > 
 > no rtser<N> nodes turn up in /dev.  No errors are generated when I
 > insert the module and an lsmod reveals it is in.  Have I missed
 > something?  Thanks.
 > -Brandt

No node will turn up in /dev, you will find the list of available RTDM
devices in /proc/xenomai/rtdm/named_devices.

-- 


					    Gilles Chanteperdrix.

