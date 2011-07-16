Message-ID: <42ced071bc2bf4dbf2dc6f74746817be.squirrel@domain.hid>
Date: Sat, 16 Jul 2011 12:11:05 +0200
From: "Wong Sheng Chao" <wong@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] (no subject)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all

I'm using the Analogy API, a4l_sync_read to read an external voltage
level from my NI card. I had gone through the insn_read.c example and
managed to reproduce a simple working program of my own.

However I can't seemed to find the place to define the reference
voltage. Looking through the Analogy API, specifically the Driver API -
Channels and ranges. It is mentioned that the channel reference can be
define through these flags in the structure a4l_chdesc_t,

#define A4L_CHAN_AREF_GROUND 0x1
#define A4L_CHAN_AREF_COMMON 0x2
#define A4L_CHAN_AREF_DIFF 0x4
#define A4L_CHAN_AREF_OTHER 0x8

but how do I access this structure to define them? I can't seemed to
find the function that return the address of this structure.

Linux kernel: 2.6.37.3
adeos patch: 2.9-00
xenomai: 2.5.6
DAQ card: National Instruments PCI_6034E

Thanks!



