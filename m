Message-ID: <78bac64d-499d-b27d-1a08-894efd787966@rambler.ru>
Date: Tue, 11 Jan 2022 21:05:58 +0300
MIME-Version: 1.0
Subject: Re: IMX8M Nano crash
Content-Language: ru-RU
References: <VI1PR04MB4046410C26B84A6DD10C57ADF3519@VI1PR04MB4046.eurprd04.prod.outlook.com>
From: Leonid Gasheev via Xenomai <feedcom@rambler.ru>
In-Reply-To: <VI1PR04MB4046410C26B84A6DD10C57ADF3519@VI1PR04MB4046.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

11.01.2022 18:37, Kristiansen, Morten (INT) via Xenomai пишет:
> I have a problem with a kernel lockup. It freeze without any messages on the console. It also stop responding to ping. The freeze happens more frequent (i.e. faster after boot) with higher CPU load.
> 
> The Linux kernel and u-boot are built by hand from Vanilla source code.
> 
> Linux-5.4.152
> Xenomai-3.2.2
> U-boot 2020.04
> CPU is IMX8MN (quad core ARM64) on NXP evaluation board 8MNANOD4-EVK.
> Use RT driver for IMX serial port that comes with Xenomai.
> 
> To narrow down the problem I'm only running on one core (Passed nosmp as kernel arg).
> 
> I have a JTAG connection using OpenOCD-0.11. When it locks up I can break execution and inspect registers, etc. What I've found is the core is looping over three instructions. To mee it seems the location is in user space and exceptions are not raised - but I'm still reading on the ARM64 architecture. When it freeze and I halt the processor, OpenOCD writes:
> 
> imx8mn.a53.0 cluster 0 core 0 multi core
> imx8mn.a53.0 halted in AArch64 state due to debug-request, current mode: EL0T
> cpsr: 0x80000000 pc: 0xffff8aa4131c
> MMU: enabled, D-Cache: enabled, I-Cache: enabled
> 
> I have the same problem on Xenoma-3.2.1 and on the Linux kernel supplied from NXP for the board, patched with Xenomai. The problem is also demonstrated on a slightly different evaluation board (8MNANOLPD4-EVK).
> 
> For troubleshooting I've written a Stress module. All it does is introduce switching between Xenomai threads using RT_MUTEX and 100 us delay (rt_task_sleep). This greatly reduce the stability where a crash will happen with 30-60 seconds. Removing the stress module and disabling other activities such as processing of data, network traffic will increase stability to 1-2 hours before a crash.
> 
> Any suggestions?
> 
> 
> /Morten Kristiansen
> 
> 
> Teledyne Confidential; Commercially Sensitive Business Data

Try logging the CPU temperature. If you see a correlation of failures
with an increase in temperature, then consider yourself lucky. In this
case, you should reduce the operating frequency of the processor
relative to the maximum by 10-20%. And improve the heat sink. Here you
can pick up only by experience.

The second option may be related to the firmware of the controller built
into the chip (I do not know your processor. And I don't know if this
chip has a built-in controller or not.) This is a difficult case. I
watched the controller shut down one cluster (4 CPUs) when the
temperature on the processor rose above 60 degrees Celsius. It is this
cluster that I have allocated for RT tasks. The controller firmware was
from a manufacturer unknown to me . In this case, I had to lower the
operating frequency from 1800 MHz to 1600.
Another recorded case is when the controller firmware and the kernel
simultaneously try to read the registers of the system timer and the
kernel randomly freezes for a while.

-- 
Leonid Gasheev

