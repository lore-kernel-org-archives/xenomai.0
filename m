From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17964.64208.463335.611234@domain.hid>
Date: Mon, 23 Apr 2007 20:28:32 +0200
In-Reply-To: <bc4264770704230809i9f9c554k14d67007b828971d@domain.hid>
References: <45F68258.5040603@domain.hid> <45F6A44A.2030000@domain.hid>
	<45F6A73C.8030301@domain.hid> <45F6AA11.40707@domain.hid>
	<bc4264770703281005v17fc4802v53728cda11cb6b17@domain.hid>
	<460AB8FF.5060904@domain.hid> <460B21C0.7090200@domain.hid>
	<460B7FDF.8030100@domain.hid> <460BECFD.2030003@domain.hid>
	<460C0C7D.7000001@domain.hid>
	<bc4264770704230809i9f9c554k14d67007b828971d@domain.hid>
Subject: Re: [Xenomai-help] Latencies due to RT-Socket-CAN register accesses
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: Xenomai-help@domain.hid

roland Tollenaar wrote:
 > Hi Wolfgang, Gilles, Stephane
 > 
 > In the intrim I have checked for latency killers and have found
 > nothing. I have a faster machine than you have posted the poerformance
 > of below yet I have substantially worse latencies.
 > 
 > Attached is my config file if you care to look at it.
 > 
 > One point may be USB. I am using usb pen drives and have seen in one
 > of the threads that USB (even if not used?) is considered a latency
 > killer.
 > 
 > Gilles suggested also to turn off the debug features but they were
 > turned off already AFAIK.
 > 
 > Sorry for the delay, I have not been able to work on this project for a while.
 > 
 > Ah and I have updated to 2.3.1 today, no problems but also no
 > improvement on the latency unfortunately. Just to eliminate that
 > point.

The latency killers:
- SMI: check dmesg to see if you get a warning saying that an
  SMI-enabled chipset was detected. If yes, read the TROUBLESHOOTING. If
  no, and you have a fairly recent Intel chipset, then we probably need
  to add support for your chipset to the SMI workaround module, send us
  the result of lspci -vv.
- USB: disable legacy USB in BIOS configuration, sometimes it is not
  enough, and you have to _enable_ USB in kernel configuration, and load
  the USB modules (that is at least uhci-hcd, ohci-hcd, ehci-hcd and
  usbcore) so that they disable BIOS legacy USB emulation.
- X-window: if you see high latencies only when the X server is running,
  the X-server is probably causing them. A workaround is proposed in the
  TROUBLESHOOTING file.

In case all that fails, enable the I-pipe tracer, run latency with the
-f option, and check /proc/ipipe/trace/frozen once you observed the high
latency in latency.

-- 


					    Gilles Chanteperdrix.

