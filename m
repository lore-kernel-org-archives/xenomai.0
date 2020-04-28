Subject: Re: RTDM SPI Driver fails to initialize
References: <66E1CF80-1D48-4592-AC7E-7612927314EB@ozu.edu.tr>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <726b892c-98e3-3097-e21a-b48d657d9c2d@siemens.com>
Date: Tue, 28 Apr 2020 18:34:20 +0200
MIME-Version: 1.0
In-Reply-To: <66E1CF80-1D48-4592-AC7E-7612927314EB@ozu.edu.tr>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Deniz Ugur <deniz.ugur@ozu.edu.tr>, xenomai@xenomai.org

On 19.04.20 09:29, Deniz Ugur via Xenomai wrote:
> Hello all,
> 
> My goal is to use RTDM SPI driver with Raspberry Pi 3B. I have built Xenomai 3.0.8 on Linux 4.9.80 with Real-time SPI support enabled as a module. Afterwards I have edited device-tree file (bcm2710-rpi-3-b.dtb) to add support to spi driver. I also enabled SPI inside /boot/config.txt with adding parameter dtparam=spi=on. Then I have blacklisted spidev inside /etc/modprobe.d/blacklist.conf. I have modified the device-tree using fdtput command and modified the tree as shown bellow. When I did this, whenever I boot up the machine I’m presented with a null-pointer exception on dmesg (included bellow).
> 

Why 3.0.8 and Linux 4.9.80? The RPi3 should work with recent Xenomai 3.1 
and 4.19 as well - IIRC.

> I have also tried to use a custom SPI driver (https://github.com/nicolas-schurando/spi-bcm283x-rtdm <https://github.com/nicolas-schurando/spi-bcm283x-rtdm>) but that also did not worked. For that driver, device did not open but that’s not important.
> 
> I have also built another kernel using same versions of Linux and Xenomai. Only difference was that real-time SPI driver enabled inside kernel. That also did not help.
> 
> I should also add that regular spidev works flawlessly.
> 

Sorry, I don't have a blueprint for your specific case but I can provide 
some hint on the crash you see.

> 
> Thanks in advance,
> Deniz
> 
> Device-tree modification:
> 
> sudo fdtput -t s bcm2710-rpi-3-b.dtb /soc/spi@7e204000/spidev@0 compatible "rtdm-spidev”
> 
> SPI node:
> 
> 	spi@7e204000 {
>              compatible = "brcm,bcm2835-spi";
>              reg = <0x7e204000 0x00001000>;
>              interrupts = <0x00000002 0x00000016>;
>              clocks = <0x00000007 0x00000014>;
>              #address-cells = <0x00000001>;
>              #size-cells = <0x00000000>;
>              status = "disabled";
>              cs-gpios = <0x0000000c 0x00000008 0x00000001 0x0000000c 0x00000007 0x00000001>;
>              dmas = <0x0000000a 0x00000006 0x0000000a 0x00000007>;
>              dma-names = "tx", "rx";
>              pinctrl-names = "default";
>              pinctrl-0 = <0x0000000d 0x0000000e>;
>              phandle = <0x00000025>;
>              spidev@0 {
>                  compatible = "rtdm-spidev";
>                  reg = <0x00000000>;
>                  #address-cells = <0x00000001>;
>                  #size-cells = <0x00000000>;
>                  spi-max-frequency = <0x07735940>;
>                  phandle = <0x0000002f>;
>              };
>              spidev@1 {
>                  compatible = "spidev";
>                  reg = <0x00000001>;
>                  #address-cells = <0x00000001>;
>                  #size-cells = <0x00000000>;
>                  spi-max-frequency = <0x07735940>;
>                  phandle = <0x00000030>;
>              };
>          };
> 
> Dmesg:
> 
> [    5.100726] Unable to handle kernel NULL pointer dereference at virtual address 00000080
> [    5.105161] pgd = b97a4000
> [    5.107378] [00000080] *pgd=00000000
> [    5.109633] Internal error: Oops: 5 [#1] SMP ARM
> [    5.111881] Modules linked in: xeno_spi(+) bcm2835_gpiomem spi_bcm2835 uio_pdrv_genirq uio fixed xeno_gpio_bcm2835 ip_tables x_tables ipv6
> [    5.116851] CPU: 0 PID: 163 Comm: systemd-udevd Not tainted 4.9.80-v7+ #2
> [    5.119361] Hardware name: BCM2835
> [    5.121783] I-pipe domain: Linux
> [    5.124028] task: b7956740 task.stack: b97a0000
> [    5.126443] PC is at __rtdm_spi_setup_driver+0x28/0x16c [xeno_spi]

You have a plain NULL-pointer issue at the beginning of 
__rtdm_spi_setup_driver. Where exactly can either be found out by 
instrumenting that function ("printk debugging") or by using gdb or 
objdump on the kernel image to match the address against the line of 
code. That may tell you which pointer is null, and you can debug deeper.

> [    5.128784] LR is at spi_device_probe+0x60/0x70 [xeno_spi]
> [    5.131194] pc : [<7f0dbb58>]    lr : [<7f0dc05c>]    psr: 60000113
>                 sp : b97a1c88  ip : 7f0dbb44  fp : b97a1ca4
> [    5.136315] r10: b7980a24  r9 : 00000000  r8 : 0000000f
> [    5.138849] r7 : 7f0dc688  r6 : 0000c700  r5 : b78fac00  r4 : b78f9f10
> [    5.141573] r3 : 00000054  r2 : 00000000  r1 : 024000c0  r0 : b78f9f10
> [    5.144309] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [    5.146801] Control: 10c5383d  Table: 397a406a  DAC: 00000055
> [    5.149522] Process systemd-udevd (pid: 163, stack limit = 0xb97a0220)
> [    5.152034] Stack: (0xb97a1c88 to 0xb97a2000)
> [    5.154461] 1c80:                   b78f9f10 b78fac00 00000000 7f0dc688 b97a1cbc b97a1ca8
> [    5.159524] 1ca0: 7f0dc05c 7f0dbb3c b78fac00 7f0dc678 b97a1cdc b97a1cc0 80568088 7f0dc008
> [    5.164721] 1cc0: 80d21778 b78fac00 00000000 7f0dc688 b97a1d04 b97a1ce0 8051ddd4 80568008
> [    5.170233] 1ce0: b78fac00 7f0dc688 b78fac34 00000000 00000000 00000000 b97a1d24 b97a1d08
> [    5.175749] 1d00: 8051df48 8051dbcc 00000000 7f0dc688 8051de80 00000000 b97a1d4c b97a1d28
> [    5.181481] 1d20: 8051bdbc 8051de8c ba5cb95c b78e9734 b78e9abc 7f0dc688 b78e9a80 80c60b18
> [    5.187476] 1d40: b97a1d5c b97a1d50 8051d5d4 8051bd50 b97a1d84 b97a1d60 8051d0d8 8051d5b4
> [    5.193701] 1d60: 7f0dc3f0 b97a1d70 7f0dc688 ffffe000 7f0dc700 b7980ac0 b97a1d9c b97a1d88
> [    5.200173] 1d80: 8051e510 8051cfd0 7f0df000 ffffe000 b97a1dac b97a1da0 80567fb4 8051e494
> [    5.206797] 1da0: b97a1dbc b97a1db0 7f0df020 80567f58 b97a1e34 b97a1dc0 80101e9c 7f0df00c
> [    5.213535] 1dc0: 80742088 802842f0 024000c0 00000001 b97a1e34 b97a1de0 80284258 80113ba8
> [    5.220278] 1de0: b97a1e04 00001fb0 80274678 0000000c bab5e3f0 b7980b00 024000c0 00001fb0
> [    5.227121] 1e00: ba401e40 a0000113 00000001 7f0dc700 00000001 7f0dc700 00000001 7f0dc700
> [    5.233590] 1e20: b7980ac0 00000001 b97a1e5c b97a1e38 8023537c 80101e54 b97a1e5c b97a1e48
> [    5.240100] 1e40: b97a1f44 00000001 7f0dc700 b7980a00 b97a1f1c b97a1e60 801a51f0 80235314
> [    5.246565] 1e60: 7f0dc70c 00007fff 7f0dc700 801a2544 00000000 80963c00 80963bd8 80963c30
> [    5.253028] 1e80: 80963bcc 80803684 7f0dc70c 00000000 b97a1f44 7f0dc8e4 7f0dc748 7f0dc700
> [    5.259486] 1ea0: 7f0dc443 b97a0001 80299b58 802999c4 bc45d000 00000000 00000000 7f0dc0ac
> [    5.265950] 1ec0: 00000005 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    5.272409] 1ee0: 00000000 00000000 00000000 00000000 7fffffff 00000000 0000000f 76e0b8e0
> [    5.278868] 1f00: 0000017b 801086e8 b97a0000 00000080 b97a1fa4 b97a1f20 801a5a48 801a3578
> [    5.285324] 1f20: 7fffffff 00000000 00000003 00000000 0244bfa8 bc45d000 00004be8 00000000
> [    5.291777] 1f40: 00000000 bc45d000 00004be8 bc4615d0 bc461438 bc4603dc 00001900 00002230
> [    5.298234] 1f60: 00000000 00000000 00000000 00001690 00000024 00000025 0000001b 0000001f
> [    5.304689] 1f80: 0000000f 00000000 8b3e3f00 8b3e3f00 00000000 00000000 00000000 b97a1fa8
> [    5.311224] 1fa0: 801086b4 801a599c 8b3e3f00 00000000 0000000f 76e0b8e0 00000000 0244bfa8
> [    5.317691] 1fc0: 8b3e3f00 00000000 00000000 0000017b 0244a020 005911dc 0244bfa8 00000000
> [    5.324140] 1fe0: 7e9b2180 7e9b2170 76e029d8 76ef2af0 60000010 0000000f 00000000 00000000
> [    5.330642] [<7f0dbb58>] (__rtdm_spi_setup_driver [xeno_spi]) from [<7f0dc05c>] (spi_device_probe+0x60/0x70 [xeno_spi])
> [    5.337172] [<7f0dc05c>] (spi_device_probe [xeno_spi]) from [<80568088>] (spi_drv_probe+0x8c/0xbc)
> [    5.343641] [<80568088>] (spi_drv_probe) from [<8051ddd4>] (driver_probe_device+0x214/0x2c0)
> [    5.350090] [<8051ddd4>] (driver_probe_device) from [<8051df48>] (__driver_attach+0xc8/0xcc)
> [    5.356532] [<8051df48>] (__driver_attach) from [<8051bdbc>] (bus_for_each_dev+0x78/0xac)
> [    5.362967] [<8051bdbc>] (bus_for_each_dev) from [<8051d5d4>] (driver_attach+0x2c/0x30)
> [    5.369391] [<8051d5d4>] (driver_attach) from [<8051d0d8>] (bus_add_driver+0x114/0x220)
> [    5.375811] [<8051d0d8>] (bus_add_driver) from [<8051e510>] (driver_register+0x88/0x104)
> [    5.382228] [<8051e510>] (driver_register) from [<80567fb4>] (__spi_register_driver+0x68/0x6c)
> [    5.388665] [<80567fb4>] (__spi_register_driver) from [<7f0df020>] (spi_device_init+0x20/0x24 [xeno_spi])
> [    5.395124] [<7f0df020>] (spi_device_init [xeno_spi]) from [<80101e9c>] (do_one_initcall+0x54/0x180)
> [    5.401553] [<80101e9c>] (do_one_initcall) from [<8023537c>] (do_init_module+0x74/0x1dc)
> [    5.407959] [<8023537c>] (do_init_module) from [<801a51f0>] (load_module+0x1c84/0x22c4)
> [    5.414361] [<801a51f0>] (load_module) from [<801a5a48>] (SyS_finit_module+0xb8/0xc8)
> [    5.420758] [<801a5a48>] (SyS_finit_module) from [<801086b4>] (__sys_trace_return+0x0/0x10)
> [    5.427161] Code: e1a04000 e3a010c0 e3401240 e30c6700 (e593002c)
> [    5.430511] ---[ end trace 042d596f8c6cde7e ]---
> 

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

