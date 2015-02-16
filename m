From: Camera.Geomatics@leica-geosystems.com
MIME-Version: 1.0
Sender: Hannes.Wachter@leica-geosystems.com
Message-ID: <OFBD514703.37474029-ONC1257DEE.0048DE4B-C1257DEE.004A4BE3@leica-geosystems.com>
Date: Mon, 16 Feb 2015 14:31:30 +0100
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Event handling, Xenomai: watchdog triggered
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

I am testing HW interrupt latencies with an Altera Development board using=
=20
the 3.10 Kernel and 2.6 xenomai toggling a FPGA Pin. I have a RTDM Modul=20
handling the interrupt generated from a FPGA timer and a user Space real=20
time program.

To synchronize Interrupt handler and IOCTL function rt_event_wait and=20
rt_event_signal are used.=20

When I run the program with 10kHz I get the message Xenomai: watchdog=20
triggered -- signaling runaway thread after several seconds. I get the=20
right signals for several seconds on my oszilloscope.

Is there a better way to synchronize irq and ioctl in a RTDM Modul?

When I disable the irq function and toggle the FPGA Pins via IOCTL=20
controlled from the user space task (rt_task_wait_period) a 10kHz=20
frequency is working.

Best Regards
Hannes


