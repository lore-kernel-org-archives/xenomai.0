From: Brandt Erickson <berickso@domain.hid>
In-Reply-To: <17984.50298.842145.884348@domain.hid>
References: <1178645689.7883.9.camel@domain.hid>
	<17984.50298.842145.884348@domain.hid>
Content-Type: text/plain
Date: Tue, 08 May 2007 15:23:59 -0600
Message-Id: <1178659440.5074.9.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: xenomai@xenomai.org


> No node will turn up in /dev, you will find the list of available RTDM
> devices in /proc/xenomai/rtdm/named_devices.

Okay,
there is a /proc/xenomai/rtdm/rtser0.  The example opens the file
"rtser0", does this default to the full path name when I use
rt_dev_open?

Right now, it appears I can open the file (rt_dev_open returns 0) and
configure the serial port (using rt_dev_ioctl), however, every call to
rt_dev_write returns -1.  I'm using the configuration from the example
code which basically has everything set to defaults.  Is there an
equivalent of errno I can get to find out what's going wrong?  Thanks.
-Brandt


