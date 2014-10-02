Message-ID: <542D2987.7040104@isc.cnr.it>
Date: Thu, 02 Oct 2014 12:31:35 +0200
From: GianPiero Puccioni <gianpiero.puccioni@isc.cnr.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Setting range in analogy read function
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am having a problem in using analogy calls to read from a NatIns PCI-MIO-16E-4

I installed Xenomai 2.6.3 on a freshly installed Kubuntu 10.4 followed
all the instructions and the kernel running is 3.8.13-xenomai-2.6.3.
The latency test did run without problems.

I tried the example programs in /opt/xenomai-2.6.3/src/utils/analogy/
in particular insn_read it seems to work except for the fact that it
doesn't seem to set the range, but just rescale (wrongly) the result
The raw output (for a square wave 100mv amp) is between 0x0810 and 0x07e8
and  If run "insn_read -R X" it gives values that change i.e
X  max    min
0 0.080 -0.115
1 0.040 -0.057
2 0.020 -0.024
3 0.006 -0.012

And so on: it rescale for a range but it doesn't set it properly

I tried to write a small prog that just does one read using
a4l_sync_read and I have seen from an old message that you should use
PACK() to set the range  but If I pass   PACK(0,1,0) to the function
to pass the range I get this error:
4l_sync_read failed (err=-22)

How can I fix this?

Thanks,

GianPiero
-- 
GianPiero Puccioni               |Istituto dei Sistemi Complessi-CNR
gianpiero.puccioni@isc.cnr.it    |Via Madonna del Piano, 10
T:+39 0555226682 F:+39 0555226683|50019 Sesto F. (Firenze) ITALY

