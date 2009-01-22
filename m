Message-ID: <4978DEF4.9080807@domain.hid>
Date: Thu, 22 Jan 2009 22:02:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1231007816-1232652648-cardhu_decombobulator_blackberry.rim.net-1405832660-@domain.hid>
	<4978CA01.1080107@domain.hid>
	<001501c97cd2$892353e0$9b69fba0$@com>
In-Reply-To: <001501c97cd2$892353e0$9b69fba0$@com>
Content-Type: text/plain; charset=UTF-8
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
Cc: 'Xenomai help' <xenomai@xenomai.org>

Wayne Call wrote:
> Is it possible to read the /sys/bus/i2c/devices/0-0048/temperature
> file using rt_dev_read?  The application is running in the real time
> context.  Even though the device driver is not in the real time
> context, can an application running in the real time context just
> simple access the /sys/bus/i2c/devices files using rt_dev_read and
> rt_dev_write?  The /sys is where the sysfs has been mounted.

No, rt_dev_read/rt_dev_write is for devices created using the RTDM skin,
not for Linux devices or files. When an application running in real-time
context (that is, in primarey mode) reads a Linux file, it switches to
secondary mode, that is to say, it becomes a plain linux task with linux
induced latencies.

-- 
					    Gilles.

