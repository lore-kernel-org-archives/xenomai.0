Subject: Re: an xhci problem on raspberry pi 4b
References: <5ED4BEB7.8070309@tj.kylinos.cn>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5ED4C055.9040005@tj.kylinos.cn>+881CB5882892D3A5
Date: Mon, 1 Jun 2020 16:46:13 +0800
MIME-Version: 1.0
In-Reply-To: <5ED4BEB7.8070309@tj.kylinos.cn>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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

correction:

./xenoami-3.1devel/scripts/prepare-kernel.sh --arch=arm64 
--linux=rpi-kernel --ipipe=ipipe-core-4.19.115-arm64-6.patch


On 2020年06月01日 16:39, chensong via Xenomai wrote:
> hi guys,
>
> I have a raspberry pi 4b and i have had xenoami running on it. Here is
> what i did:
>
> 1,git clone https://github.com/raspberrypi/linux.git
> 2,git checkout -b rpi-4.19.y remotes/origin/rpi-4.19.y
> 3,./xenomai3.1-devel/scripts/prepare-kernel.sh --arch=arm64
> --linux=rpi-kernel
> --ipipe=./nudt-hgj-xenomai-tjrd/scripts/prepare-kernel.sh --arch=arm64
> --linux=rpi-kernel
> 4,make bcm2711_xeno_defconfig
> 5,make
>
> then i got warning during the boot:
>
> [    0.710238] ------------[ cut here ]------------
> [    0.710731] usb usb2: New USB device found, idVendor=1d6b,
> idProduct=0003, bcdDevice= 4.19
> [    0.712926] irq 38 handler xhci_msi_irq+0x0/0x30 enabled interrupts
> [    0.715583] usb usb2: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [    0.718324] WARNING: CPU: 0 PID: 0 at kernel/irq/handle.c:153
> __handle_irq_event_percpu+0x2b8/0x2d0
> [    0.721020] usb usb2: Product: xHCI Host Controller
> [    0.723738] Modules linked in:
> [    0.726483] usb usb2: Manufacturer: Linux 4.19.122-v8-xeno+ xhci-hcd
> [    0.729100] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 4.19.122-v8-xeno+ #21
> [    0.729107] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
> [    0.729115] I-pipe domain: Linux
> [    0.729126] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [    0.731837] usb usb2: SerialNumber: 0000:01:00.0
> [    0.734521] pc : __handle_irq_event_percpu+0x2b8/0x2d0
> [    0.747930] lr : __handle_irq_event_percpu+0x2b8/0x2d0
> [    0.750612] sp : ffffff8008003da0
> [    0.753253] x29: ffffff8008003da0 x28: ffffffc07c6f2980
> [    0.755914] x27: ffffffc07c3d8000 x26: ffffff8008ce8000
> [    0.758561] x25: ffffff8008003e44 x24: ffffff8008cc3018
> [    0.761186] x23: ffffff8008ce86d8 x22: 0000000000000026
> [    0.763820] x21: 0000000000000000 x20: 0000000000000001
> [    0.766452] x19: ffffffc07c386600 x18: ffffffffffffffff
> [    0.769056] x17: 0000000000000abc x16: 0000000000000000
> [    0.771635] x15: ffffff80089b2000 x14: 0000000000000000
> [    0.774189] x13: 0000000000000000 x12: 0000000000000000
> [    0.776698] x11: ffffff80089618a0 x10: 0000000000000001
> [    0.779197] x9 : ffffffc07ff554e8 x8 : ffffffc07ff55530
> [    0.781711] x7 : ffffffc07ff56da8 x6 : 0000000000000000
> [    0.784221] x5 : 0000000000000000 x4 : 0000000000000000
> [    0.786712] x3 : 3be642d6caccc200 x2 : ffffff80081a95e0
> [    0.789213] x1 : 3be642d6caccc200 x0 : 0000000000000000
> [    0.791679] Call trace:
> [    0.794148]  __handle_irq_event_percpu+0x2b8/0x2d0
> [    0.796648]  handle_irq_event_percpu+0x40/0x98
> [    0.799132]  handle_irq_event+0x50/0x80
> [    0.801611]  handle_simple_irq+0xb4/0x118
> [    0.804055]  generic_handle_irq+0x34/0x50
> [    0.806456]  brcm_pcie_msi_isr+0xac/0x1a8
> [    0.808858]  __ipipe_dispatch_irq+0x180/0x1c8
> [    0.811257]  __ipipe_grab_irq+0x6c/0xa8
> [    0.813656]  gic_handle_irq+0x60/0xb0
> [    0.816044]  handle_arch_irq_pipelined+0x28/0x78
> [    0.818436]  el1_irq+0xc0/0x160
> [    0.820812]  ipipe_unstall_root+0x3c/0x58
> [    0.823172]  arch_cpu_idle+0x2c/0x230
> [    0.825520]  default_idle_call+0x4c/0x58
> [    0.827842]  do_idle+0xc4/0x150
> [    0.830154]  cpu_startup_entry+0x28/0x30
> [    0.832452]  rest_init+0xd0/0xe0
> [    0.834717]  start_kernel+0x454/0x480
> [    0.836935] ---[ end trace 6a6caf6ae3e92a68 ]---
> [    0.839227] WARNING: CPU: 0 PID: 0 at kernel/sched/idle.c:229
> do_idle+0x128/0x150
> [    0.841497] Modules linked in:
> [    0.843700] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
>   4.19.122-v8-xeno+ #21
> [    0.845964] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
> [    0.848241] I-pipe domain: Linux
> [    0.850542] pstate: 60000005 (nZCv daif -PAN -UAO)
> [    0.852861] pc : do_idle+0x128/0x150
> [    0.855128] lr : do_idle+0xd0/0x150
> [    0.857385] sp : ffffff8008ce3f20
> [    0.859628] x29: ffffff8008ce3f20 x28: 0000000000c10018
> [    0.861848] x27: b4185184c303f241 x26: 0800180000208953
> [    0.864059] x25: ffffff8008cb1028 x24: ffffffc07ffff500
> [    0.866253] x23: ffffff8008dfe000 x22: ffffff8008ce8680
> [    0.868398] x21: ffffff8008ce8750 x20: 0000000000000001
> [    0.870509] x19: ffffff8008ce86d8 x18: ffffffffffffffff
> [    0.872610] x17: 0000000000000ab4 x16: 0000000000000000
> [    0.874676] x15: ffffff80089b2000 x14: 0000000000000000
> [    0.876722] x13: ffffff80089618c8 x12: 0000000000000038
> [    0.878727] x11: 0101010101010101 x10: 0000000000001930
> [    0.880738] x9 : ffffff8008ce3e60 x8 : ffffff8008cf0650
> [    0.882749] x7 : 0000000000000000 x6 : 0000000002c7b8f9
> [    0.884761] x5 : 00ffffffffffffff x4 : 0000000000000000
> [    0.886765] x3 : ffffff8008e960c0 x2 : 000000407728b000
> [    0.888775] x1 : 0000000000000000 x0 : 0000000000000001
> [    0.890785] Call trace:
> [    0.892771]  do_idle+0x128/0x150
> [    0.894735]  cpu_startup_entry+0x28/0x30
> [    0.896734]  rest_init+0xd0/0xe0
> [    0.898740]  start_kernel+0x454/0x480
>
> Looks like sonething wrong in xhci irq.
>
> As a result, usb is not working appropriately, there is no input devices
> and sometimes system is hanging there when connecting an usb device.
>
> Has anyone managed to enable xenomai on rspberry pi 4b? Can you
> reporduce this problem and how is it fixed? Please help, many thanks.
>
> BR
>
> chensong
>
>
>
>



