From: Johannes Holtz <johannes.holtz@compador.de>
Subject: RTCan missing frames
Message-ID: <aea6afe6-99e3-9e60-6004-05d7a3d0eb42@compador.de>
Date: Mon, 11 Feb 2019 10:16:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

In my application i set up a RTCAN socket and a pair of rt-threads. One 
to read and one to write. Writing works perfectly and I receive answers 
in the initial phase of the program.

In particular I send CANopen NMT messages out and receive the responses 
from the other Nodes in the Network.

2019-02-11 09:52:13.309[       500][    CAN TX] > NMT Node 0:0:
CAN ID 0x000 FC 0x0 DLC 2
         0       82 00
2019-02-11 09:52:13.310[       503][    CAN RX] > NMT Error Control Node 
0:8:
CAN ID 0x708 FC 0xe DLC 1
         0       00
2019-02-11 09:52:13.311[       503][    CAN RX] > NMT Error Control Node 
0:9:
CAN ID 0x709 FC 0xe DLC 1
         0       00
2019-02-11 09:52:13.317[       509][    CAN RX] > NMT Error Control Node 
0:3:
CAN ID 0x703 FC 0xe DLC 1
         0       00
2019-02-11 09:52:13.317[       509][    CAN RX] > NMT Error Control Node 
0:4:
CAN ID 0x704 FC 0xe DLC 1
         0       00
2019-02-11 09:52:13.317[       509][    CAN RX] > NMT Error Control Node 
0:5:
CAN ID 0x705 FC 0xe DLC 7
         0       00 06 07 00
         4       00 01 01
2019-02-11 09:52:13.317[       509][    CAN RX] > NMT Node 0:0:
CAN ID 0x000 FC 0x0 DLC 3
         0       07 00 00
2019-02-11 09:52:13.326[       519][    CAN RX] > TIME Node 0:1:
CAN ID 0x101 FC 0x2 DLC 0

As you can see, I capture 7 frames. However, the RX count from 
/proc/rtcan/devices is 10.

If I send specific SDO requests to one of the node which have answered I 
don't capture a response but the RX count increases and rtcanrecv 
program captures the correct response. Only my application's read 
doesn't return.

I have not altered the filters and the RX and TX timeouts are at 
100micro sec. I also don't get error frames. The RX_BufFull indicator 
from /proc/rtcan/sockets keeps growing.

Also the rtcanrecv utility shows garbage if i let it run but if I 
restart it after each request the first response is printed correctly.


Can you give me any advice? I followed every example and documentation 
about rtcan but I'm running out of ideas what the cause could be.

I'm still using the "old" 2.6.3 xenomai but I sincerely hope this is not 
an old known issue. I rather hope there is something wrong with my approach.

I'm thankful for every hint.

Cheers,

Johannes




