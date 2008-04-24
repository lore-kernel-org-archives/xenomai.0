Message-ID: <2ff1a98a0804240701te010062q74c091650bee8862@domain.hid>
Date: Thu, 24 Apr 2008 16:01:16 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646F22@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F17@domain.hid>
	<2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid>
	<18447.31623.723753.421351@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F1D@afsexc01.aurora.aero>
	<18447.43488.713144.166771@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F21@domain.hid>
	<18448.11276.526008.229326@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F22@domain.hid>
Subject: Re: [Xenomai-help] serial port overrun problem RT TASK
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org

On Thu, Apr 24, 2008 at 3:59 PM, Karch, Joshua <jkarch@domain.hid> wrote:
>
>
>
>
> Gilles,
>
>  You're right about the code formatting-- when I cut and paste the code in I
> removed some unneeded code- the other else is within a nested if statement.
> I had errors with or without the extra ioctl.  Without the extra ioctl for
> RTSER_RTIOC_WAIT_EVENT my number of errors is about once every 8
> seconds(basically commented out the first if else statement).  My baud rate
> is 115200, but I only receive 2520 bytes per second (45 bytes at 50 Hz).  I
> am using a Versalogic Puma board PC/104 with a Geode GX2.  It uses a CS5536
> chipset.  I will try the T_WARNSW option now.

The first thing to do is to run the latency test to see if you have
hardware problems.

-- 
 Gilles

