MIME-Version: 1.0
In-Reply-To: <CADXNiGXDwfAtX3f7FpjeSRe0NsJcZi_EW2=+9MZd-93xWBQkJA@mail.gmail.com>
References: <CADXNiGXcYVk8JUDv24_TVLtvRQ=hJaaSiMzwQPct5V92U-jGYw@mail.gmail.com>
 <640d22cb-ac74-6702-8c15-76ace5732262@xenomai.org>
 <CADXNiGW4EB96ovgEqutmYthLS9rk9paHGj0BGQG_dZCmiB2S6Q@mail.gmail.com>
 <CADXNiGW83FQPkVvdsdYzNSjVHmE0pL1YbxuNVpC4bd3uZJBN1g@mail.gmail.com>
 <4d7df01d-e90b-2598-6424-7336732c2be5@xenomai.org>
 <CADXNiGXDwfAtX3f7FpjeSRe0NsJcZi_EW2=+9MZd-93xWBQkJA@mail.gmail.com>
From: Jackson Jones <jackson.jones@gmail.com>
Date: Tue, 1 Aug 2017 19:31:30 -0700
Message-ID: <CADXNiGXfA0EE3BRKQWmDQa8Ks9rfjL+00PTsXg+1xbz3kiY2Bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] real-time spi driver for imx6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Philippe,

I changed the .compatible string in spi-device.c so that it would search
for "spidev". The module now tries to initialize, but I am getting a null
pointer somewhere. The kernel stack trace is pasted below. I put a couple
of printk's in spi_device_probe to try and see where the issue was, but
none of them printed out.

Are there any changes you would recommend that I make to the
imx6ql-var-som.dtsi (it is attached to the previous message). I did not
make any other changes to any of the xenomai spi files. I have not changed
my driver file since the initialization has not gotten to it yet.

I do have one question, should I leave the original spi-imx driver in place
(the Linux driver), or should it be disabled. I was looking online for
examples of how people were using the xeno driver for the Raspberry Pi to
get some sort of idea/example, but I did not find much.

We are using this in a medical device. We have the spi device connected to
an FPGA which in turn communicates with an RF board. The Real-Time software
has to monitor the usual things like voltage on different lines, heat, RF
output, and for various hardware faults that can happen. The FPGA turns the
one spi bus into 4 that send messages to different parts of the RF
generator. The messages coming back are "muxed" into one bus, but the
header tells us where it came from.

Right now we cannot keep up with the demands of the systems since using the
Linux SPI driver causes 100s of context switches between real-time and non
real-time. This slows down the sending and receiving of messages causing
watchdog faults. I am hoping this driver, once working can be cleaned up
and used by the Xenomai community. The only thing I would want to do is to
put back in the logic for the imx6ul which has some minor differences from
the rest of the imx6 variants.

Thanks,

Jackson




root@ZORRO02:~# Unable to handle kernel NULL pointer dereference at virtual
address 00000028
pgd = c9df8000
[00000028] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in: xeno_spi(+) galcore(O)
CPU: 2 PID: 2043 Comm: modprobe Tainted: G           O    4.1.15 #1
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
task: cfc3cb00 ti: cea2e000 task.ti: cea2e000
PC is at spi_device_probe+0x38/0x88 [xeno_spi]
LR is at __ipipe_restore_head+0x18/0xfc
pc : [<7f048f38>]    lr : [<800aa3f4>]    psr: 60000013
sp : cea2fda0  ip : cec753dc  fp : 3155da9c
r10: 00000001  r9 : ceaa2580  r8 : 0000000b
r7 : 00000000  r6 : 7f049578  r5 : cec72a00  r4 : cec75258
r3 : 00000000  r2 : 00000000  r1 : d0faf944  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 59df804a  DAC: 00000015
Process modprobe (pid: 2043, stack limit = 0xcea2e220)
Stack: (0xcea2fda0 to 0xcea30000)
fda0: 7f049568 cec72a00 7f049578 8042344c 80bc56e8 cec72a00 7f049578
803826d4
fdc0: cec72a00 7f049578 cec72a34 80ad0ae4 00000000 803828e4 00000000
7f049578
fde0: 80382858 80380c38 ce18615c cec6d934 7f049578 cefc6f00 00000000
80381e70
fe00: 7f04947c 80a9e020 cf5389c0 7f049578 80a9e020 cf5389c0 7f04c000
80382ee0
fe20: 80a9e020 80a9e020 cf5389c0 80009a10 00000000 8040003f 00000000
8011db18
fe40: 800ef9b8 ceaa24c0 00000001 ce001f00 80a95c60 80a9774c cea2e000
7f0495fc
fe60: 80a9774c 8011f2d4 80a9774c 000000d0 a0000013 cf5389c0 0006a1a2
7f0495b4
fe80: 7f0495b4 7f0495b4 cf538600 00000001 7f0495fc 00000001 3155da9c
806948f4
fea0: 00000001 7f0495fc cea2ff58 7f0495b4 ceaa2588 8009ba68 7f0495c0
00007fff
fec0: 80098d8c cea95cc0 7f0495fc 7f04970c 80a975e0 00000000 00000107
7f0496fc
fee0: eab35000 00004bf2 00340058 00000000 0b300022 00000000 00000000
7f048fb8
ff00: 00000005 00000000 00000000 00000000 00000000 00000000 00000000
00000000
ff20: 00000000 00000000 00000000 00000000 00000028 00000000 00000003
54b22e80
ff40: 0000017b 8000fb88 cea2e000 00000000 554bc608 8009c0b0 eab35000
00004bf2
ff60: eab374e0 eab3734a eab39390 0000170c 000021dc 00000000 00000000
00000000
ff80: 00000025 00000026 0000001b 0000001f 00000010 00000000 54b23b00
554bb968
ffa0: 4618ed00 8000f940 54b23b00 554bb968 00000003 54b22e80 00000000
54b23670
ffc0: 54b23b00 554bb968 4618ed00 0000017b 00040000 00000000 00000000
554bc608
ffe0: 7efea398 7efea388 54b196c3 76e5ba42 80000030 00000003 00000000
00000000
[<7f048f38>] (spi_device_probe [xeno_spi]) from [<8042344c>]
(spi_drv_probe+0x50/0x74)
[<8042344c>] (spi_drv_probe) from [<803826d4>]
(driver_probe_device+0x174/0x2b4)
[<803826d4>] (driver_probe_device) from [<803828e4>]
(__driver_attach+0x8c/0x90)
[<803828e4>] (__driver_attach) from [<80380c38>]
(bus_for_each_dev+0x68/0x9c)
[<80380c38>] (bus_for_each_dev) from [<80381e70>]
(bus_add_driver+0x148/0x1f0)
[<80381e70>] (bus_add_driver) from [<80382ee0>] (driver_register+0x78/0xf8)
[<80382ee0>] (driver_register) from [<80009a10>]
(do_one_initcall+0x8c/0x1d8)
[<80009a10>] (do_one_initcall) from [<806948f4>] (do_init_module+0x5c/0x1a8)
[<806948f4>] (do_init_module) from [<8009ba68>] (load_module+0x1904/0x1dc8)
[<8009ba68>] (load_module) from [<8009c0b0>] (SyS_finit_module+0x64/0x74)
[<8009c0b0>] (SyS_finit_module) from [<8000f940>]
(ret_fast_syscall+0x0/0x3c)
Code: ebfffed3 e3500000 18bd8070 e5943004 (e5933028)
---[ end trace 3fd6a6580b91393c ]---

107 static int spi_device_probe(struct spi_device *spi)
108 {
109     struct rtdm_spi_remote_slave *slave;
110     struct rtdm_spi_master *master;
111     int ret;
112
113     /*
114      * Chicken and egg issue: we want the RTDM device class name
115      * to duplicate the SPI master name, but that information is
116      * only available after spi_register_master() has returned. We
117      * solve this by initializing the RTDM driver descriptor on
118      * the fly when the first SPI device on the bus is advertised
119      * on behalf of spi_register_master().
120      *
121      * NOTE: the driver core guarantees serialization.
122      */
123     master = spi_master_get_devdata(spi->master);
124     if (master == NULL)
125         printk(XENO_ERR "in spi_device_probe master is null!!!\n");
126
127     if (master->devclass == NULL) {
128         ret = __rtdm_spi_setup_driver(master);
129         if (ret)
130             return ret;
131     }
132
133     if (master->ops->attach_slave == NULL)
134     slave = master->ops->attach_slave(master, spi);
135         printk(XENO_ERR "in spi_device_probe ops are broken!!!\n");
136
137     if (IS_ERR(slave))
138         return PTR_ERR(slave);
139
140     spi_set_drvdata(spi, slave);
141
142     return 0;




154 static const struct of_device_id spi_device_match[] = {
155     {
156         //.compatible = "rtdm-spidev",
157         .compatible = "spidev",
158     },
159     { /* Sentinel */ },
160 };




On Mon, Jul 31, 2017 at 8:18 PM, Jackson Jones <jackson.jones@gmail.com>
wrote:

> Philippe,
>
> So do I need to add "rtdm-spidev" to the .dtsi (attached), or do I need to
> make a special entry to the dtsi file?
>
> Thanks,
>
> Jackson
>
>
>
> On Sat, Jul 29, 2017 at 1:41 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>
>> On 07/29/2017 04:51 AM, Jackson Jones wrote:
>> > Fixed some dumb build errors, did some cleanup on the driver. Built the
>> > driver as a module, it loads but does nothing. It is probably not
>> finding
>> > the spi device.
>> >
>> > Using Xenomai 3.0.5.
>> >
>> > Attaching the .dtsi so show what pins the spidev is mapped to.
>>
>> Check the "compatible" string in the Xenomai SPI core, it looks for
>> "rtdm-spidev" slave devices to talk to, not "spidev" like the regular
>> driver does.
>>
>> --
>> Philippe.
>>
>
>
