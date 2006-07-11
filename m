Message-ID: <44B3BF22.2000107@domain.hid>
Date: Tue, 11 Jul 2006 17:09:22 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xenomai beginner problem
References: <200607111633.09508.technique@domain.hid>
In-Reply-To: <200607111633.09508.technique@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Martin Chaplet <technique@domain.hid>
Cc: xenomai@xenomai.org

Martin Chaplet wrote:
> On 7/11, Jan Kiszka wrote:
> 
> 	Kim Chuan Lim wrote:
> 		I am interested with the hard real time serial port example from..
> 		http://www.captain.at/xenomai-serial-port-example.php
> 
> 		The following is the error message i received when i try to run the
> 		program..
> 		./rt_serial_uprog
> 		rt_serial_uprog: PRESS CTRL-C to EXIT
> 		rt_serial_uprog: timer started
> 		rt_serial_uprog: can't open rtser0
> 		rt_serial_uprog: stop timer
> 
> 		May i know which device is "rtser0"?
> 		shall i just change it to /dev/ttyS0?
> 
> 	Check Hannes' doku: you have to load the xeno_16550A driver.
> 
> 
> I'm also a beginner on Xenomai and I have the same problem as Kim Chuan Lim.
>  I verified my configuration : RTDM skin and 16550A driver are both integrated 
> in my 2.6.16 kernel, so these modules don't exist.
> Shall I create rtser0 node ?

I think I had the 16550A driver once also compiled in, but I couldn't configure
it. But once you compile it as module, check:
http://www.captain.at/xenomai-xeno_16550A.php

Best regards,
Hannes.

