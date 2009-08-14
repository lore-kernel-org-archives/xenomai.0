Message-ID: <4A8518FE.7070103@domain.hid>
Date: Fri, 14 Aug 2009 09:57:50 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE20060EFA3F76@domain.hid>
	<4A840387.9010700@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060F03FA93@domain.hid>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE20060F03FA93@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] FW: Peak parallel port dongle rtcan driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Charlton, John" <john.charlton@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Charlton, John wrote:
> Wolfgang,
> 
> Thank you for the information and advice.  We are currently considering this interface in a custom embedded controller design but based on your recommendations we probably need to reassess that decision. We were intending to use the parallel port through a super io chip on a custom designed board but it sounds like we should go with an ISA or PCI bus interface to get real-time performance at 1mbit baud rate.  Our application requires the full 1mbit baudrate continuous for 100msec to 200msec intervals.

FYI, I remember discussions about real-time problems with the PCAN dongle:

  https://mail.gna.org/public/xenomai-help/2007-03/msg00185.html

See also:

  https://mail.gna.org/public/xenomai-help/2007-03/msg00183.html

Can't remember where I got that information from, maybe from PEAK PCAN
support.

But that user did not have the problems you reported. Maybe it's
hardware related.

Wolfgang.

