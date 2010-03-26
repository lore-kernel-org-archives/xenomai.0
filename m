Message-ID: <4BACBFDC.4080909@domain.hid>
Date: Fri, 26 Mar 2010 15:08:28 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Bug in a4l_get_chan
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, Alexis Berlemont <berlemont.hauw@domain.hid>

Hello Alexis,

I found that a4l_get_chan() in buffer.c does not work for subdevices
that use a global channels description struct (mode =
A4L_CHAN_GLOBAL_CHANDESC in the a4l_chdesc_t structure).

The problem is that a4l_get_chan() iterates (twice) on the chan_desc
array looking for channel descriptions at indexes higher than 0, also in
the case where those are not populated because the subdevice uses a
single channel description structure for all channels.

This bug is quite bas, as it triggers a kernel oops for a integer
division by zero when an a4l_cmd_t command is issued with a channels
description array that does not have the channel id 0 as first acquired
channel. You can easily reproduce the bug using the ni_pcimio driver,
using cmd_read with the parameter -c 1.

I'm looking into providing a patch, but I have some difficulties in
understanding the rational of this part of analogy code...

Cheers,
-- 
Daniele

