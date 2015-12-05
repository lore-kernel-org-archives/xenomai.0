From: Steven Seeger <steven.seeger@nasa.gov>
Date: Sat, 5 Dec 2015 03:02:38 -0500
Message-ID: <6309036.vrZ57LHtHK@wirbelwind>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Xenomai] powerpc 440 userspace latency test does nothing
Reply-To: steven.seeger@nasa.gov
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hey guys.

I am running a virtex5 ml507 board from Xilinx configured to use the internal powerpc 440 processor in the FPGA. I compiled a 3.18.20 kernel and patched it and build xenomai 3.0.1.

I am able to run latency -t 1 and latency -t 2

When I try to run just latency, however, I get no results. It seems like userspace threads are not ever waking up. Here's the result of cat /proc/xenomai/sched/stat:

SCLINUX: / # cat /proc/xenomai/sched/stat
CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU  NAME
  0  0      0          3240214    0          0     00018000  100.0  [ROOT]
  0  898    1          1          5          0     000680c0    0.0  latency
  0  900    1          2          5          0     00068042    0.0  display-898
  0  901    2          3          7          0     0004c042    0.0  sampling-898
  0  0      0          3245052    0          0     00000000    0.0  [IRQ512: [timer]]

Before I spend too much time tearing into this I wanted to ask if anyone's seen this issue before.

It should be noted that clocktest runs fine. switchtest runs. xeno-test just sits there though. 

Thanks,
Steven


