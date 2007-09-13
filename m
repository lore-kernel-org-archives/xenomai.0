MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18153.37062.708378.653036@domain.hid>
Date: Thu, 13 Sep 2007 21:34:30 +0200
In-Reply-To: <1ce16a2c0709131222g3acfb8a8y2c48ce4eee964903@domain.hid>
References: <1ce16a2c0709131003t673986c5v417ddce15dd29de6@domain.hid>
	<2ff1a98a0709131016o4fbf1e99l9e3024b622ec63e7@domain.hid>
	<1ce16a2c0709131222g3acfb8a8y2c48ce4eee964903@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] seperate native write task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bachman Kharazmi <bahkha@domain.hid>
Cc: xenomai@xenomai.org

Bachman Kharazmi wrote:
 > rt_task_shadow() commented out.
 > fd only declared in the header.. so it should be the same everywhere.
 > 
 > Still all output is written to terminal and nothing over rtser0 (my
 > serial port).
 > My updated version: http://pastebin.ca/696180

Read my answer again, and completely this time:

 > > >         (....)
 > > >         fd = rt_dev_open(WRITE_FILE, 0);
 > > >         (....)
 > > >         err=write(fd, myString, strlen(myString));
 > >
 > > This is no good, a file descriptor returned by rt_dev_open should be
 > > used with rt_dev_write. If you want to use write, you should use open
 > > and ioctl, and not forget to compile with the flags returned by
 > > xeno-config --posix-cflags and xeno-config --posix-ldflags.


-- 


					    Gilles Chanteperdrix.

