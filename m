MIME-Version: 1.0
From: Michael Smith <2michael.smith@gmail.com>
Date: Tue, 29 Sep 2015 15:10:38 +0200
Message-ID: <CANWkrRMksLWR10fuM=M1Oc25GYzDHTzFqEq5cDJmGBpjdyxwyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Oops message on rtdm_read()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi. I'm unclear what I am doing wrong. But I get a oops message when I am
trying to do a read() (RTDM) from user space into my device driver.

The read function in the driver has been setup as follows:

    .ops = {
            .open           = open_dev,
            .close          = close_dev,
            .ioctl_rt       = device_ioctl,
            .ioctl_nrt      = device_ioctl,
            .read_nrt       = read_dev,
            .read_rt        = read_dev,
            .write_nrt      = write_dev,
            .write_rt       = write_dev,

As can be seen I call the same read routine in real-time and non
real-time, because they both boil down to the same type of callback
function nl.

ssize_t rtdm_read_handler(struct rtdm_fd * fd,void __user * buf,size_t size )

When the read() call is done from user space (non real-time) I get a
oops as follows:

[62847.263710] I-pipe: Detected illicit call from head domain 'Xenomai'
[62847.263710]         into a regular Linux service
[62847.263716] CPU: 2 PID: 4466 Comm: flash.out Tainted: G
OE 3.16.0-xenomai-3.0.6 #2
[62847.263718] Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./Z87 Extreme4, BIOS P2.30 07/03/2013
[62847.263719]  0000000000051730 ffff880092d6fd50 ffffffff817530ca
000000000000dde0
[62847.263723]  ffff880092d6fd80 ffffffff8110b59d 0000000000000001
0000000000000004
[62847.263727]  0000000000020000 0000000000002000 ffff880092d6fd98
ffffffff8110c922
[62847.263731] Call Trace:
[62847.263738]  [<ffffffff817530ca>] dump_stack+0x45/0x56
[62847.263742]  [<ffffffff8110b59d>] ipipe_root_only+0x18d/0x1b0
[62847.263745]  [<ffffffff8110c922>] ipipe_restore_root+0x12/0x50
[62847.263747]  [<ffffffff8175a17a>] _raw_spin_unlock_irqrestore+0x2a/0x30
[62847.263751]  [<ffffffff816344e3>] pci_conf1_read+0xd3/0x130
[62847.263754]  [<ffffffff81637763>] raw_pci_read+0x23/0x40
[62847.263757]  [<ffffffff816377ac>] pci_read+0x2c/0x30
[62847.263761]  [<ffffffff813e3dd6>] pci_bus_read_config_dword+0x66/0xa0
[62847.263765]  [<ffffffffc08ffe75>] read+0xc5/0x180 [apmclx40]
[62847.263769]  [<ffffffff8117144b>] rtdm_fd_read+0x11b/0x320
[62847.263772]  [<ffffffff81178290>] ? cobalt_ioctl+0x20/0x20
[62847.263775]  [<ffffffff8117829e>] cobalt_read+0xe/0x10
[62847.263778]  [<ffffffff8118bada>] ipipe_syscall_hook+0x17a/0x340
[62847.263781]  [<ffffffff8110d99f>] __ipipe_notify_syscall+0x9f/0x400
[62847.263784]  [<ffffffff8175aa6a>] pipeline_syscall+0xa/0x17
[62847.263785] I-pipe tracer log (100 points):
[62847.263787]     +*func               0 ipipe_trace_panic_freeze+0x0
(ipipe_root_only+0x16a)
[62847.263797]  |  +*end     0x80000001      0 ipipe_trace_end+0x19
(ipipe_root_only+0xc3)
[62847.263806]  |  +*begin   0x80000001      0 ipipe_root_only+0xa3
(ipipe_restore_root+0x12)
[62847.263814]     +*func               0 ipipe_root_only+0x0
(ipipe_restore_root+0x12)
[62847.263822]     +*func               0 ipipe_restore_root+0x0
(_raw_spin_unlock_irqrestore+0x2a)
[62847.263830]     +*func               0
_raw_spin_unlock_irqrestore+0x0 (pci_conf1_read+0xd3)
[62847.263839]     +*func               0
__ipipe_spin_unlock_debug+0x0 (pci_conf1_read+0xc4)
[62847.263847]     +*func              -2 _raw_spin_lock_irqsave+0x0
(pci_conf1_read+0x65)
[62847.263855]     +*func              -2 pci_conf1_read+0x0 (raw_pci_read+0x23)
[62847.263864]     +*func              -2 raw_pci_read+0x0 (pci_read+0x2c)
[62847.263872]     +*func              -2 pci_read+0x0
(pci_bus_read_config_dword+0x66)
[62847.263881]     +*func              -3 _raw_spin_lock_irqsave+0x0
(pci_bus_read_config_dword+0x48)
[62847.263890]     +*func              -3
pci_bus_read_config_dword+0x0 (read+0xc5 [apmclx40])
[62847.263899]  |  +*end     0x80000001     -3 ipipe_trace_end+0x19
(__ipipe_spin_unlock_irqrestore+0x39)
[62847.263908]  |  #*func              -3
__ipipe_spin_unlock_irqrestore+0x0 (printk+0x1e0)
[62847.263917]  |  +*begin   0x80000001     -4
__ipipe_spin_lock_irqsave+0x8b (printk+0x199)
[62847.263926]     +*func              -4
__ipipe_spin_lock_irqsave+0x0 (printk+0x199)
[62847.263934]  |  +*end     0x80000001     -4 ipipe_trace_end+0x19
(printk+0x15c)
[62847.263943]  |  +*begin   0x80000001     -4 printk+0x66 (read+0x9d
[apmclx40])
[62847.263952]     +*func              -4 printk+0x0 (read+0x9d [apmclx40])
....
flash.out[4466]: segfault at ffffc90015b08008 ip 00000000004012e2

I'm not sure if there are something else I should be doing. Not sure
what the error refers to either.
Any direction would be appreciated

Regards
Michael

