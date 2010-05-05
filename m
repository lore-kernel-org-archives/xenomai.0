Message-ID: <4BE1C695.10803@domain.hid>
Date: Wed, 05 May 2010 21:27:17 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <l2tff1d78711005030332i4120fbc5w46c47785200e67ce@domain.hid>
In-Reply-To: <l2tff1d78711005030332i4120fbc5w46c47785200e67ce@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] System freezes when CAN buffer overflows
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Kauffmann <steven.kauffmann@domain.hid>
Cc: xenomai@xenomai.org

On 05/03/2010 12:32 PM, Steven Kauffmann wrote:
> Hi all,
> 
> When I close my application a cleanup function is called. In this
> function I first close the CAN listener thread that handles incoming
> CAN messages. After that some other cleanup code is executed and at
> the end I finally close the socket. If I close the application when
> the CAN bus is idle, no problems occur. When the CAN bus is active,
> I'm getting a CAN buffer overflow after the CAN listener thread is
> closed which results in a system freeze.

This is normal behaviour (not the freeze, though). Obviously you receive
CAN messages at rather high rate and as long as the socket is open, the
ISR tries to deliver it to the socket's RX buffer and when it gets full
an error counter is increased and an error message is printed out if
debugging is enabled. See:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rtcan_raw.c#122

> I can reproduce this problem with an easy example (see rtcanTest.c).
> This program opens a socket but it does not start a CAN listener
> thread. This results in a CAN buffer overflow when sending CAN
> messages ( using rtcansend ) and a system freeze. Executing the
> following command twice triggers the problem "rtcansend rtcan1 -l 100
> 001#00 00 00 00 00 00 00 00".
> 
> Tested with the latest xenomai 2.4 branch + CAN peak pci card.
> 
> Workaround for me is closing the socket immediately after the CAN
> listener thread is closed. Can this be a system configuration problem
> (config file attached) or a driver problem?

The problem is due to the error messages at high rate. It should be
rate-limited somehow or even be removed. Does Xenomai already have
a rtdm_printk_ratelimted function? I will have a closer look
a.s.a.p. Disabling debugging should also help.

Wolfgang.

