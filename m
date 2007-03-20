Message-ID: <46002EE0.9040406@domain.hid>
Date: Tue, 20 Mar 2007 19:58:40 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] RT-Socket-CAN bus error rate and latencies
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>
Cc: socketcan-core@domain.hid

Hello,

on the Xenomai mailing list the topic "bus error flooding" popped up 
again. Various users reported trouble due to high bus error rates and 
bad impact on latencies. Some discussion is going on on how to avoid 
such flooding. I have already implemented "on-demand" bus error 
interrupts. Bus error interrupts are then only enabled when at least one 
socket is listening on bus errors. But flooding can still occur and we 
are thinking about a better way of downscaling or temporarily disabling 
them. Socket-CAN currently restarts the controller after 200 bus errors.
My preferred solution for RT-Socket-CAN currently is to stop the CAN 
controller after a kernel configurable amount of successive bus errors. 
More clever ideas and comments are welcome?

To have some input, I have measured the bus error rate with the PEAK 
PCAN PCI card on my Icecube MPC5200 eval-board doing rtcansend without 
cable connected. Here are the results for the various baud-rates:

    125 KB/s  1926 BEI/s
    250 KB/s  3925 BEI/s
    500 KB/s  7856 BEI/s
   1000 KB/s 15700 BEI/s

The latency measured with "latency" from the testsuite reported an 
increase of the latency with load from 67 to 95us almost independently 
of the baud-rate. Sending messages with 8 byte payload from MSCAN to 
SJA1000 on the same node as fast as possible increased the latency up to 
103us. This measurement did not include delivery of messages to sockets 
(actually no socket was listening).

Wolfgang.

