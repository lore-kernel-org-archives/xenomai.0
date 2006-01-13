Message-ID: <43C78B3D.1050201@domain.hid>
Date: Fri, 13 Jan 2006 12:13:01 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010408020708010105070407"
Subject: [Xenomai-core] Xenomai t0-2 latency measurements
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------010408020708010105070407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

attached you will find the results of my todays Xenomai latency 
measurements on various PowerPC boards with Linux 2.4 and 2.6.

Wolfgang.

--------------010408020708010105070407
Content-Type: text/x-log;
 name="xenomai-latencies-ppc-new.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-latencies-ppc-new.log"

New latency tests with Xenomai on various PowerPC boards
--------------------------------------------------------

Board   : Processor  CPU-Clk Bus-Clk I-Cache D-Cache Memory Kernel Remarks
                                       
TQM860L : MPC 860     50 MHz  50 MHz    4 KB    4 kB  16 MB 2.4.25
PM825   : MPC 8260   200 MHz  66 MHz   16 KB   16 kB 128 MB 2.4.25 FPU 
Ocotea  : AMCC 440GX 533 MHz 152 MHz   32 KB   32 KB 256 MB 2.6.14 DDR-RAM, L2 256 KB


Linux  : DENX Linux 2.6.14 or DENX Linux 2.4.25 (linuxppc_2_4_devel)
iPipe  : 1.0-02 or 1.1-02
Xenomai: SVN 2006-01-12


LATENCY on TQM860L with load (and -p500):

         |-----lat min|-----lat avg|-----lat max|-overrun|---test-time
     -t0 |       58240|      122240|      217280|       0|    00:05:00
     -t1 |       64480|       97584|      160320|       0|    00:05:00
     -t2 |       24640|       48961|      105280|       0|    00:05:00


LATENCY on PM825 with load:

         |-----lat min|-----lat avg|-----lat max|-overrun|---test-time
     -t0 |       17750|       29125|       64062|       0|    00:05:00
     -t1 |       10188|       22413|       50188|       0|    00:05:00
     -t2 |       15062|       10754|       38438|       0|    00:05:00


LATENCY on Ocotea with load:

         |-----lat min|-----lat avg|-----lat max|-overrun|---test-time
     -t0 |        4897|       10815|       27774|       0|    00:05:00
     -t1 |        3423|        8316|       23935|       0|    00:05:00
     -t2 |        1714|        3701|       12010|       0|    00:05:00


Note: load has been put onto the system by running in a telnet session
      "ping -f <remote-host-ip>" and "calibrator ..." (Cache-Memory and 
      TLB Calibration Tool http://monetdb.cwi.nl/Calibrator/).

Note: all test have been run with CONFIG_XENO_HW_TIMER_LATENCY="1" and
      CONFIG_XENO_HW_SCHED_LATENCY="1" to get correct latancy values.


Old latency measurements:
-------------------------

Linux  : DENX linux-2.6.14-rc3-g4c234921
iPipe  : 1.0-00
Xenomai: SVN 2005-10-15

KLATENCY with load:

         |-----lat min|-----lat avg|-----lat max|-overrun|---test-time
TQM860L  |       50560|       98976|      199040|       0|    00:09:45
Ocotea   |        2953|        5974|       19147|       0|    00:12:05


LATENCY with load:

         |-----lat min|-----lat avg|-----lat max|-overrun|---test-time
TQM860L  |       60480|      120960|      224320|       0|    00:09:46
Ocotea   |        3575|        7438|       24474|       0|    00:10:50


--------------010408020708010105070407--

