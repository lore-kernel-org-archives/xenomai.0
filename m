From: "Kristiansen, Morten (INT)" <Morten.Kristiansen@Teledyne.com>
Subject: IMX8M Nano crash
Date: Tue, 11 Jan 2022 15:37:05 +0000
Message-ID: <VI1PR04MB4046410C26B84A6DD10C57ADF3519@VI1PR04MB4046.eurprd04.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I have a problem with a kernel lockup. It freeze without any messages on th=
e console. It also stop responding to ping. The freeze happens more frequen=
t (i.e. faster after boot) with higher CPU load.

The Linux kernel and u-boot are built by hand from Vanilla source code.

Linux-5.4.152
Xenomai-3.2.2
U-boot 2020.04
CPU is IMX8MN (quad core ARM64) on NXP evaluation board 8MNANOD4-EVK.
Use RT driver for IMX serial port that comes with Xenomai.

To narrow down the problem I'm only running on one core (Passed nosmp as ke=
rnel arg).

I have a JTAG connection using OpenOCD-0.11. When it locks up I can break e=
xecution and inspect registers, etc. What I've found is the core is looping=
 over three instructions. To mee it seems the location is in user space and=
 exceptions are not raised - but I'm still reading on the ARM64 architectur=
e. When it freeze and I halt the processor, OpenOCD writes:

imx8mn.a53.0 cluster 0 core 0 multi core
imx8mn.a53.0 halted in AArch64 state due to debug-request, current mode: EL=
0T
cpsr: 0x80000000 pc: 0xffff8aa4131c
MMU: enabled, D-Cache: enabled, I-Cache: enabled

I have the same problem on Xenoma-3.2.1 and on the Linux kernel supplied fr=
om NXP for the board, patched with Xenomai. The problem is also demonstrate=
d on a slightly different evaluation board (8MNANOLPD4-EVK).

For troubleshooting I've written a Stress module. All it does is introduce =
switching between Xenomai threads using RT_MUTEX and 100 us delay (rt_task_=
sleep). This greatly reduce the stability where a crash will happen with 30=
-60 seconds. Removing the stress module and disabling other activities such=
 as processing of data, network traffic will increase stability to 1-2 hour=
s before a crash.

Any suggestions?


/Morten Kristiansen


Teledyne Confidential; Commercially Sensitive Business Data
