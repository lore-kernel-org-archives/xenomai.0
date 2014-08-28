MIME-Version: 1.0
Date: Thu, 28 Aug 2014 16:09:21 -0400
Message-ID: <CAEGbdifyuoCnxOnSfo7gXY0Ra1yUcJQY-7HXto5EvsjXEGXFNw@mail.gmail.com>
From: Matthew Lindner <mattlindn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Linux ATA driver issues and lockups
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

We are using an Advantech-PCM9389 board running Linux 3.10.32 with
Xenomai 2.6.3. Regularly there is an error that occurs. Sometimes
operation continues as normal, sometimes the operating system freezes
(with no panic). We have narrowed it down that when compiling a Linux
3.10.32 kernel there are no issues but when Xenomai patches are
applied and Xenomai suggested kernel settings are changed these errors
start occurring. They appear to happen most commonly when network file
transfers are occurring but has been seen to happen when nothing was
running. A Xenomai user-space application does not need to be running
for these errors to occur. Has anyone experienced things similar to
this?

Jul 29 04:34:09 delta kernel: ata1.00: exception Emask 0x0 SAct 0x0
SErr 0x0 action 0x6 frozen
Jul 29 04:34:09 delta kernel: ata1.00: BMDMA stat 0x24
Jul 29 04:34:09 delta kernel: ata1.00: failed command: WRITE DMA
Jul 29 04:34:09 delta kernel: ata1.00: cmd
ca/00:10:68:11:40/00:00:00:00:00/e0 tag 0 dma 8192 out
Jul 29 04:34:09 delta kernel:         res
50/00:00:68:11:40/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
Jul 29 04:34:09 delta kernel: ata1.00: status: { DRDY }

Matthew Lindner

