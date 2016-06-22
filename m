From: "Patel, Yogi A" <yapatel@gatech.edu>
Date: Wed, 22 Jun 2016 17:39:59 +0000
Message-ID: <BLUPR07MB30717F1B2E872CC730AEF26C82C0@BLUPR07MB307.namprd07.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Advice on optimizing design for low latency real-time
	processing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi -


We are working on designing and prototyping a PCIe based data acquisition s=
ystem for hard real-time, low-latency closed-loop processing. This hardware=
 would interface with our current application which uses Xenomai (rtxi.org)=
.


The base of the system is a Xilinx FPGA that interfaces with the host proce=
ssor for acquisition control, settings, etc. This system will ideally allow=
 sampling from up to 10,000 channels at a rate of about 30kHz each.


One interest of our's is to make this system work with a dedicted RTOS (Xen=
omai, possibly through RTDM). As we are designing this, the question came u=
p of how to minimize latencies for getting data to the processor (and back)=
 for online processing, visualization, etc. So far we have looked into DMA =
schemes, memory mapping, etc.


This is purposefully a broad question - are there considerations we should =
be keeping to minimize the latencies introduced by data transfers alone? An=
y suggestions on "best practices" or "optimal methods" are greatly apprecia=
ted.


Thanks in advance.

