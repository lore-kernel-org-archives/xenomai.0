Message-ID: <49651106.4030807@domain.hid>
Date: Wed, 07 Jan 2009 21:31:02 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2003E4BABF18@domain.hid>
	<4964F242.3020908@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2003E4BAC0DC@us194mx002.tycoelectronics.net>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2003E4BAC0DC@us194mx002.tycoelectronics.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtcanconfig rtcansend rtcanrecv
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
> I added a reply to you with my reply to Sebastian Smoloz request for the driver module source.  Yes the transmitter shows TX-counter incremented by 1 and the receiver never receives anything. The
> /proc/xenomai/irq is:
> 
> IRQ         CPU0
>   0:      119660         [timer]
>   5:           0         SJA1000
>   7:           0         SJA1000
>  34:           0         [virtual]

That's what I expected. You may want to crosscheck with the TSCAN1
driver of the lincan project:

http://www.ocera.org/download/components/WP7/lincan-0.3.3.html

Wolfgang.


