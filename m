From: Martin Chaplet <technique@domain.hid>
Subject: Re: [Xenomai-help] xenomai beginner problem
Date: Tue, 11 Jul 2006 16:33:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607111633.09508.technique@domain.hid>
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

On 7/11, Jan Kiszka wrote:

	Kim Chuan Lim wrote:
		I am interested with the hard real time serial port example from..
		http://www.captain.at/xenomai-serial-port-example.php

		The following is the error message i received when i try to run the
		program..
		./rt_serial_uprog
		rt_serial_uprog: PRESS CTRL-C to EXIT
		rt_serial_uprog: timer started
		rt_serial_uprog: can't open rtser0
		rt_serial_uprog: stop timer

		May i know which device is "rtser0"?
		shall i just change it to /dev/ttyS0?

	Check Hannes' doku: you have to load the xeno_16550A driver.


I'm also a beginner on Xenomai and I have the same problem as Kim Chuan Lim.
 I verified my configuration : RTDM skin and 16550A driver are both integrated 
in my 2.6.16 kernel, so these modules don't exist.
Shall I create rtser0 node ?

Martin


