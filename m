Message-ID: <45F2B8BB.6060804@domain.hid>
Date: Sat, 10 Mar 2007 14:55:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: [Xenomai-help] rtcan driver. rtcan_sja_interrupt made interruptible
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hi,

The following probably relates to the functioning of the sja1000 chip. I
cannot see how it can NOT be possible for the chip to function properly
without also having the ability to be read by a fully interruptible ISR.

Could below just be clarified for me please?

When the 14 registers of the sja1000 chip are being read, I presume this
is a single CAN frame that is being recovered which will subsequently be
written to the message buffer of the sockets currently connected to the
device. I also presume that while the registers are being read new
incoming messages from the Bus will not be written into these registers
because this would possibly corrupt the frame that is currently being
extracted from the registers. i.e. if the ISR has read 7 of the 14
messages and a new message is now written into the registers the
resulting frame will be a mixture of two distinct received messages. To
prevent that happening I presume it must be possible to lock the
registers while the Rx-ISR is busy doing its reading of the 14
registers? Messages that arrive on the bus while the Rx-ISR is locking
the 14 registers will then either be discarded or sent again by the node
as a result of the sending node not receiving an acknowledge message?

The point of the above questions being that if it is possible to lock
the 14 registers there is no reason in my humble opinion (IMHO) that the
the Rx-ISR cannot be interrupted. Correct? Of course one wants to
minimize the delay to optimize bus traffic but such behaviour would
certainly improve Real-Time capabilities.

If the non-real-time driver functions as described above (locks the 14
registers and allows itself to be interrupted) it will be better for me
to use the non-real-time driver in a stand-alone non-real-time
application which reads the CAN bus and presents the data it receives to
the real-time application (or any other application for that matter) via
a mechanism of choice. E.g. in a file on RAM-Disk, a pipe etc. In short
this would be a CAN-server which, since it is a fully interruptible
normal process will allow my real-time applications to tick away
undisturbed.

Is the reasoning incorrect?


Having written the above I have just downloaded the datasheet of the
SJA1000 and it seems to confirm my above conjecture. Firstly there are
64 bytes of FIFO receive buffer 13 of which are presented as a window
and are probably the ones referred to by Sebastian as the ones the ISR
reads out. This means that while reading out the window messages will
not get lost immediately.

Then on page 10 with a more detailed explanation on page 14 they talk
about a command register with a bit switch called the Release receive
Buffer (RRB) which seems to have the function of the lock I was talking
about.

Can you more knowledgeable people comment on this. It the above is
correct it could enormously improve the applicability of the driver for
  Real-Time control. Which I presume the driver is all about?


Regards,

Roland.


