From: Giulio Moro <g.moro@qmul.ac.uk>
Subject: irqchip tps65217 is not pipeline-safe!
Date: Thu, 28 Mar 2019 19:51:03 +0000
Message-ID: <AM0PR07MB5572FDFC8BB9278EC530F1DCB5590@AM0PR07MB5572.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi there,
booting a 4.14.94-ti kernel with Cobalt 3.0.8 from the "stable/v3.0.x" bran=
ch, on an am3358 (PocketBeagle) I get a warning during boot "irqchip tps652=
17 is not pipeline-safe!". The tps65217 is the power-management IC for the =
board. What does this message mean exactly? Is it something to be concerned=
 about? The board has behaved fine when running Xenomai tasks, in spite of =
this issue.
Thanks,
Giulio

Relevant log below, full `dmesg` can be found here https://github.com/Rober=
tCNelson/ti-linux-kernel-dev/issues/31#issuecomment-470118685

[    2.010215] ------------[ cut here ]------------
[    2.010255] WARNING: CPU: 0 PID: 64 at kernel/irq/chip.c:57 irq_set_chip=
+0xcc/0xdc
[    2.010262] irqchip tps65217 is not pipeline-safe!
[    2.010270] Modules linked in:
[    2.010292] CPU: 0 PID: 64 Comm: kworker/0:2 Not tainted 4.14.94-ti-xeno=
mai-r95 #1
[    2.010298] Hardware name: Generic AM33XX (Flattened Device Tree)
[    2.010305] I-pipe domain: Linux
[    2.010332] Workqueue: events deferred_probe_work_func
[    2.010377] [<c0110924>] (unwind_backtrace) from [<c010dedc>] (show_stac=
k+0x20/0x24)
[    2.010395] [<c010dedc>] (show_stack) from [<c0cd71c8>] (dump_stack+0x24=
/0x28)
[    2.010424] [<c0cd71c8>] (dump_stack) from [<c013a418>] (__warn+0xf4/0x1=
0c)
[    2.010440] [<c013a418>] (__warn) from [<c013a488>] (warn_slowpath_fmt+0=
x58/0x74)
[    2.010456] [<c013a488>] (warn_slowpath_fmt) from [<c01963ec>] (irq_set_=
chip+0xcc/0xdc)
[    2.010473] [<c01963ec>] (irq_set_chip) from [<c0197708>] (irq_set_chip_=
and_handler_name+0x24/0x3c)
[    2.010497] [<c0197708>] (irq_set_chip_and_handler_name) from [<c0948970=
>] (tps65217_irq_map+0x40/0x78)
[    2.010515] [<c0948970>] (tps65217_irq_map) from [<c019a214>] (irq_domai=
n_associate+0x84/0x1f8)
[    2.010529] [<c019a214>] (irq_domain_associate) from [<c019abf4>] (irq_c=
reate_mapping+0x144/0x1fc)
[    2.010548] [<c019abf4>] (irq_create_mapping) from [<c094e720>] (mfd_add=
_device+0x204/0x348)
[    2.010563] [<c094e720>] (mfd_add_device) from [<c094e968>] (mfd_add_dev=
ices+0xa0/0x104)
[    2.010577] [<c094e968>] (mfd_add_devices) from [<c094ea60>] (devm_mfd_a=
dd_devices+0x78/0xb8)
[    2.010592] [<c094ea60>] (devm_mfd_add_devices) from [<c0948c9c>] (tps65=
217_probe+0x110/0x328)
[    2.010608] [<c0948c9c>] (tps65217_probe) from [<c0a7ee7c>] (i2c_device_=
probe+0x290/0x2dc)
[    2.010625] [<c0a7ee7c>] (i2c_device_probe) from [<c0919a14>] (driver_pr=
obe_device+0x298/0x478)
[    2.010668] [<c0919a14>] (driver_probe_device) from [<c0919dcc>] (__devi=
ce_attach_driver+0xac/0x14c)
[    2.010683] [<c0919dcc>] (__device_attach_driver) from [<c0917544>] (bus=
_for_each_drv+0x68/0xc8)
[    2.010698] [<c0917544>] (bus_for_each_drv) from [<c09195c8>] (__device_=
attach+0xe0/0x174)
[    2.010713] [<c09195c8>] (__device_attach) from [<c0919ec8>] (device_ini=
tial_probe+0x1c/0x20)
[    2.010727] [<c0919ec8>] (device_initial_probe) from [<c091880c>] (bus_p=
robe_device+0x94/0x9c)
[    2.010742] [<c091880c>] (bus_probe_device) from [<c0916390>] (device_ad=
d+0x418/0x618)
[    2.010756] [<c0916390>] (device_add) from [<c09165b4>] (device_register=
+0x24/0x28)
[    2.010770] [<c09165b4>] (device_register) from [<c0a7fe50>] (i2c_new_de=
vice+0x154/0x308)
[    2.010787] [<c0a7fe50>] (i2c_new_device) from [<c0a82dc8>] (of_i2c_regi=
ster_device+0x148/0x1fc)
[    2.010800] [<c0a82dc8>] (of_i2c_register_device) from [<c0a831f4>] (of_=
i2c_register_devices+0x98/0x118)
[    2.010814] [<c0a831f4>] (of_i2c_register_devices) from [<c0a80514>] (i2=
c_register_adapter+0x184/0x404)
[    2.010828] [<c0a80514>] (i2c_register_adapter) from [<c0a8081c>] (__i2c=
_add_numbered_adapter+0x88/0x138)
[    2.010840] [<c0a8081c>] (__i2c_add_numbered_adapter) from [<c0a809b4>] =
(i2c_add_adapter+0xe8/0x154)
[    2.010853] [<c0a809b4>] (i2c_add_adapter) from [<c0a80a4c>] (i2c_add_nu=
mbered_adapter+0x2c/0x30)
[    2.010869] [<c0a80a4c>] (i2c_add_numbered_adapter) from [<c0a86c58>] (o=
map_i2c_probe+0x524/0x718)
[    2.010885] [<c0a86c58>] (omap_i2c_probe) from [<c091bf9c>] (platform_dr=
v_probe+0x60/0xbc)
[    2.010900] [<c091bf9c>] (platform_drv_probe) from [<c0919a14>] (driver_=
probe_device+0x298/0x478)
[    2.010915] [<c0919a14>] (driver_probe_device) from [<c0919dcc>] (__devi=
ce_attach_driver+0xac/0x14c)
[    2.010928] [<c0919dcc>] (__device_attach_driver) from [<c0917544>] (bus=
_for_each_drv+0x68/0xc8)
[    2.010942] [<c0917544>] (bus_for_each_drv) from [<c09195c8>] (__device_=
attach+0xe0/0x174)
[    2.010956] [<c09195c8>] (__device_attach) from [<c0919ec8>] (device_ini=
tial_probe+0x1c/0x20)
[    2.010970] [<c0919ec8>] (device_initial_probe) from [<c091880c>] (bus_p=
robe_device+0x94/0x9c)
[    2.010984] [<c091880c>] (bus_probe_device) from [<c0918d28>] (deferred_=
probe_work_func+0x74/0x19c)
[    2.011008] [<c0918d28>] (deferred_probe_work_func) from [<c0156b38>] (p=
rocess_one_work+0x178/0x4e4)
[    2.011025] [<c0156b38>] (process_one_work) from [<c0157110>] (worker_th=
read+0x26c/0x5ec)
[    2.011042] [<c0157110>] (worker_thread) from [<c015d494>] (kthread+0x16=
8/0x170)
[    2.011064] [<c015d494>] (kthread) from [<c010952c>] (ret_from_fork+0x18=
/0x24)
[    2.011073] ---[ end trace 7699ea00e776f627 ]---
[    2.014786] input: tps65217_pwr_but as /devices/platform/ocp/44e0b000.i2=
c/i2c-0/0-0024/tps65217-pwrbutton/input/input0
[    2.015419] tps65217 0-0024: TPS65217 ID 0xe version 1.2


