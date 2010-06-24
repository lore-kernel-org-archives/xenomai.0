Message-ID: <4C23682A.8060505@domain.hid>
Date: Thu, 24 Jun 2010 16:14:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikU5zPKew64ZxWGokwh5R5F-sNegWdDzOENWdzB@mail.gmail.com>	<4C1B7EB1.2040006@domain.hid>	<AANLkTinABTK2nMI0QfZVaULQ4OKwF0678PKOBc_OMIn1@domain.hid>	<AANLkTiklRlwsIJfelo0eT2GZDvI6PtDAwc4qluLCr6R5@domain.hid>	<4C1B8C04.3010900@domain.hid>	<4C1BCCBF.7010400@domain.hid>	<AANLkTilBt1fx4MFJ_Tmuz-fUl1D190u_FYDfLn09JaA3@domain.hid>	<1277330401.2453.145.camel@domain.hid>	<AANLkTincrp1q4RbmCoijrummF3IS_tfBJ-YGZnGFbpw0@domain.hid>	<4C234679.10209@domain.hid>
	<AANLkTilPgVl1k1TUWBjwmT969SL5ga227so3x8VSqXtP@mail.gmail.com>
In-Reply-To: <AANLkTilPgVl1k1TUWBjwmT969SL5ga227so3x8VSqXtP@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fwd: problem in pthread_mutex_lock/unlock
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Nero Fernandez <grimlynch@domain.hid>
Cc: xenomai@xenomai.org

Nero Fernandez wrote:
> 
> Yes, the measurements are on no-load scenarios.
> I will try to repeat my measurements with system-loads as you suggest.

You can find a working root filesystem image with Xenomai 2.5.3 compiled
here:
http://www.xenomai.org/~gch/pub/rootfs-arm926-ejs.tar.bz2

The root password is empty, the system launches a telnet daemon, so you
can log on the board via telnet.

To run the tests, launch in a first telnet session:
echo 0 > /proc/xenomai/latency
latency -T 2 -H
in a second telnet sesssion, launch:
dohell
When you see "Listening on any address 5566", run on the host:
netcat <target-name-or-IP> 5566

where <target-name-or-IP> is the name of your arm board in the host
/etc/hosts file or its IP address.

Now, you can let the system run as long as the latency test prints
message. When the dohell script is done, it will kill the latency test,
which will cause it to print the histogram values and exit.

-- 
					    Gilles.

