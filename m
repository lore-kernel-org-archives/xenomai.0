From: Richard Cochran <richardcochran@domain.hid>
Date: Fri, 23 Sep 2011 13:02:19 +0200
Message-Id: <cover.1316774468.git.richard.cochran@domain.hid>
Subject: [Xenomai-core] [RFC 0/1] Class driver for raw Ethernet packets
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This patch adds a class driver for raw Ethernet drivers under
Xenomai. The goal is to support industrial protocols such as EtherCAT
and IEC 61850, where the "stack" is a user space program needing
direct access at the packet level. The class driver offers interfaces
for registration, buffer management, and packet sending/receiving.

Although this patch is a kind of first draft, still I have it working
on the Freescale P2020 with a real world application, with very good
results. I can post a patch series for the gianfar driver in the ipipe
tree, if anyone is interested.

The user space interface is a character device and not a socket, simply
because my applications will probably never need fancy socket
options. The class driver could surely be made to offer a socket
instead, but I think the character is sufficient.

The class driver is clearly in the wrong directory within the source
tree, but I put it there just to get started. It really does not fit
to any of the other drivers, so it probably would need its own place
under ksrc/drivers.

Thanks in advance for your comments,

Richard


Richard Cochran (1):
  Add a class driver for raw Ethernet packets.

 include/rtdm/rtpacket.h       |   99 ++++++++++++
 ksrc/drivers/testing/Kconfig  |    8 +
 ksrc/drivers/testing/Makefile |    3 +
 ksrc/drivers/testing/packet.c |  352 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 462 insertions(+), 0 deletions(-)
 create mode 100644 include/rtdm/rtpacket.h
 create mode 100644 ksrc/drivers/testing/packet.c

-- 
1.7.2.5


