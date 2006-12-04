Message-ID: <45740D03.5090708@domain.hid>
Date: Mon, 04 Dec 2006 12:56:51 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] size of the struct can_frame
References: <54b161f50612040334v3244d551l56868ec221bd5dcb@domain.hid>
In-Reply-To: <54b161f50612040334v3244d551l56868ec221bd5dcb@domain.hid>
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
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org

Frits de Klark wrote:
> Hello everyone,
> 
> I noticed that the sizeof() function reports that the struct can_frame 
> has a size of 16 bytes. I know that this is because of memory aligning 
> done by the GNU compiler.

This is just a structure to pass message data from and to the CAN driver.

> But now I wonder if there are actually 16 bytes transferred over the CAN 
> bus. I guess not, since it has such a strict and well-defined format, 
> but I'd like to have this confirmed by someone, please.

The format of the data actually transferred over the bus is defined in 
the CAN bus standard. And the driver just programs the appropriate 
registers of the CAN controller.

> The size of 16 bytes though, is also passed to the rt_dev_recv() and 
> rt_dev_send() functions, so this is where I get confused: Are the 
> correct bytes extracted from this 16 byte block at a later stage (the 
> CAN driver)?

Yes, of course. And the internal ringer buffers for received messages 
also use a "packed" format.

> I'm asking this to make sure that if, for example, I'd like to store all 
> the received frames in a binary file, I don't need to store all 16 
> bytes, just the 13 (right?) that are in use.

You need to store (5 + can_dlc) bytes.

> 
> I hope I made myself clear.
> 
> Thanks in advance and best regards!

Wolfgang.


