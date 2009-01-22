Message-ID: <4978C604.8020309@domain.hid>
Date: Thu, 22 Jan 2009 20:16:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <000101c97cbc$96bacc10$c4306430$@com>
In-Reply-To: <000101c97cbc$96bacc10$c4306430$@com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai i2c
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: wcall@domain.hid
Cc: xenomai@xenomai.org

Wayne Call wrote:
> Is there a way to use xenomai to do a simple read/ write to an i2c device?
> I simply want to read a temperature sensor value, via I2C, in the real time
> context.  I currently use files such as i2c-bfin-twi.c and i2c-core.c and
> have built a sensor type driver, lm73.c.  I can read temperature values from
> user space using the /sys/bus/i2c/devices/0-0048/temperature folder.

The clean way is to implement a driver (or several drivers) using the
RTDM skin. Then, you would access this driver using the real-time
version of the usual open/read/write/ioctl/close interface.

-- 
					    Gilles.

