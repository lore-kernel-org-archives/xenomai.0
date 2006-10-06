Message-ID: <45264366.80405@domain.hid>
Date: Fri, 06 Oct 2006 13:52:06 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtcan_mscan compilation.
References: <ac3922a00610060437i4735bf7at85ca11beb12ab1be@domain.hid>
In-Reply-To: <ac3922a00610060437i4735bf7at85ca11beb12ab1be@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Syed Amer Gilani <amg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Syed Amer Gilani wrote:
> I wanted to test rtcan but the mscan Driver fails to compile:
> 
>  CC      drivers/xenomai/can/mscan/rtcan_mscan.o
> drivers/xenomai/can/mscan/rtcan_mscan.c:85: error: syntax error before
> string constant
> drivers/xenomai/can/mscan/rtcan_mscan.c:85: warning: type defaults to
> 'int' in declaration of 'MODULE_PARM'
> drivers/xenomai/can/mscan/rtcan_mscan.c:85: warning: function
> declaration isn't a prototype
> drivers/xenomai/can/mscan/rtcan_mscan.c:85: warning: data definition
> has no type or storage class
> drivers/xenomai/can/mscan/rtcan_mscan.c:89: error: syntax error before
> string constant
> drivers/xenomai/can/mscan/rtcan_mscan.c:89: warning: type defaults to
> 'int' in declaration of 'MODULE_PARM'
> drivers/xenomai/can/mscan/rtcan_mscan.c:89: warning: function
> declaration isn't a prototype
> drivers/xenomai/can/mscan/rtcan_mscan.c:89: warning: data definition
> has no type or storage class
> make[4]: *** [drivers/xenomai/can/mscan/rtcan_mscan.o] Fehler 1
> 
> When i understand the Sources correct it has something to do with the
> value of the config variables. But i left them all on the default
> values:
> 
> CONFIG_XENO_DRIVERS_RTCAN_MSCAN=y
> CONFIG_XENO_DRIVERS_RTCAN_MSCAN_1=y
> CONFIG_XENO_DRIVERS_RTCAN_MSCAN_2=y
> CONFIG_XENO_DRIVERS_RTCAN_MSCAN_CLOCK=66000000
> CONFIG_XENO_DRIVERS_RTCAN_MSCAN_ALT=y
> # CONFIG_XENO_DRIVERS_RTCAN_MSCAN_PSC2 is not set

Yes, I know since yesterday and it proofs again, untested software does 
  not work :-(. I'm working on a fix. Should be available today or tomorrow.

Wolfgang.


