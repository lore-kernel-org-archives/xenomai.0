MIME-Version: 1.0
Sender: arthur.quaid@gmail.com
Date: Wed, 18 Nov 2015 20:30:44 -0500
Message-ID: <CAG3GeUDEtuMF4BmJEpm0-279BaJae65gJar-67AcECfR_GQvDw@mail.gmail.com>
From: Arthur Quaid <aquaid@vivero1.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] RTCAN corruption after short CAN frames
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I'm trying to get xenomai and RT-CAN working on a beaglebone black.
I'm using a CBB-Serial-r02 cape, which uses the Bosch DCAN hardware
built into the TI AM335x.

Everything appears to work until I send a CAN frame that has less than
the 8 byte max payload.  After a "short" frame is received, future
frames received on that socket are corrupted.

For example, if I use cansend (from can-utils) on a vanilla debian BBB
to send a series of messages:
[...]
$ cansend can0 765#00112233aabbccdd
$ cansend can0 123#DEADBEEFDEADBEEF
$ cansend can0 089#aabbccddeeff
$ cansend can0 123#DEADBEEFDEADBEEF
$ cansend can0 765#00112233aabbccdd

to a second BBB running xenomai and rtcanrecv -v rtcan0, I see:
[...]
#2: (0) <0x765> [8] 00 11 22 33 aa bb cc dd
#3: (5) <0x123> [8] de ad be ef de ad be ef
#4: (0) <0x089> [6] aa bb cc dd ee ff
#5: (0) <0x001> [0]
#6: (190) !0x0dde0800! [111] de ad be ef 65 07 00 00 00 40 fa b6 00 11
cd 38 b0 20 01 00 08 00 00 00 84 20 01 00 b0 20 01 00 1d 00 00 00 b0
20 01 00 90 20 01 00 00 a0 fa b6 00 00 00 00 a7 8e 00 00 b8 9b 00 00
1e 58 00 00 a0 20 01 00 84 20 01 00 00 00 00 00 d8 20 01 00 08 00 00
00 00 00 00 10 00 00 00 00 dc 9b 00 00 00 00 00 00 00 00 00 00 68 00
00 00 e4 9b 00 ERROR

where messages #2-4 look ok, but #5-6 (after the "short" frame
arrives) are corrupted.

Note that if I restart rtcanrecv, it will look ok again until after
the next short frame is received.  Also, no errors are reported in
/proc/rtcan/rtcan0/info.

Some info for the xenomai beaglebone black (running a pre-built ubuntu
14.04 image):
$uname -a
Linux arm 3.8.13-xenomai-r78 #1 Sat Sep 26 17:01:02 UTC 2015 armv7l
armv7l armv7l GNU/Linux
$cat /proc/rtcan/version
RT-Socket-CAN 0.90.2 - built on Sep 26 2015 16:59:21
$/proc/xenomai/version
2.6.3
$/proc/ipipe/version
3

Thanks for any help,

-Arthur

