From: Brandt Erickson <berickso@domain.hid>
In-Reply-To: <1178659440.5074.9.camel@domain.hid>
References: <1178645689.7883.9.camel@domain.hid>
	<17984.50298.842145.884348@domain.hid>
	<1178659440.5074.9.camel@domain.hid>
Content-Type: text/plain
Date: Tue, 08 May 2007 15:45:57 -0600
Message-Id: <1178660757.5074.15.camel@domain.hid>
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


> Right now, it appears I can open the file (rt_dev_open returns 0) and
> configure the serial port (using rt_dev_ioctl), however, every call to
> rt_dev_write returns -1.  I'm using the configuration from the example
> code which basically has everything set to defaults.  Is there an
> equivalent of errno I can get to find out what's going wrong?  Thanks.
> -Brandt

Slight modification here, it does write correctly if I call rt_dev_write
from a task spawned by main, but not if I call it from main itself.  So
I guess this is less about rtser per se and more about the rtdm API.


