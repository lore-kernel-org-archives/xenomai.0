From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-help] rt can time on sending frames
Date: Sat, 10 Mar 2007 11:55:32 +0000
References: <bc4264770703091209h3b46bfa3s8042ad9a32dfda36@domain.hid>
In-Reply-To: <bc4264770703091209h3b46bfa3s8042ad9a32dfda36@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703101155.32539.paul_c@domain.hid>
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


Hi Roland

On Friday 09 March 2007 20:09, roland Tollenaar wrote:
> now that we have discovered the delay on and Rx interrupt, can anyone
> perhaps tell what the delay is on sending a can frame? Is that also of
> the order of 200 microseconds?

If we assume a similar number of bytes need to be written to the dongle as 
were read during a receive, I would expect to see a 20% increase in speed. 
This being based on a write using six outb() calls and a read using eight 
inb() per byte of the CAN frame. - This only applies to parallel port 
dongles, and I would expect dedicated PCI cards to be considerably faster..

As a side note - I see Kvaser[1] (and Peak [2]) do a PCMCIA card and supply 
source code for a driver. Not cheap, but an alternative if you are tied to a 
laptop for development.


Regards, Paul.



[1] http://www.kvaser.com/prod/hardware/lapcan_i.htm
[2] http://www.phytec.com/products/can/pc-can-interfaces/peakpccard.html

