MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18152.27953.505687.903208@domain.hid>
Date: Thu, 13 Sep 2007 00:50:25 +0200
In-Reply-To: <1ce16a2c0709121230n19192fd5yc0c0ceba5880faf9@domain.hid>
References: <1ce16a2c0709100614u3f23fce9yd2be767406fa536a@domain.hid>
	<46E58BE4.9090109@domain.hid>
	<1ce16a2c0709101142r6cf2d624oe443807575eadcfa@domain.hid>
	<46E59235.2060506@domain.hid>
	<1ce16a2c0709110837r52eedac7vcc970d5c3b4e2d53@domain.hid>
	<46E6F290.9090901@domain.hid>
	<1ce16a2c0709120702m1d4cc503vb045f3d2e0814d67@domain.hid>
	<1ce16a2c0709120922t50ead4ep695f2bf1b061c57c@domain.hid>
	<2ff1a98a0709120933t43a8636g32b61652aea163b1@domain.hid>
	<2ff1a98a0709120943y366f22f2g157bd2d7e18e035c@domain.hid>
	<1ce16a2c0709121230n19192fd5yc0c0ceba5880faf9@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] adding PCI support to 16550A.c
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
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Bachman Kharazmi wrote:
 > Sorry I didn't paste my code, http://pastebin.ca/694397
 > The output from it is:
 > sandbox:/home/bkw/code/driver# ./simpledriver
 > 0
 > test1
 > 
 > And then it exits, no test2 printed at all.. :/
 > And nothing in the while loop seem to write to the serialport as I expected.
 > 
 > what am I doing wrong?

You are returning from the main thread, which terminates the whole application.

-- 


					    Gilles Chanteperdrix.

