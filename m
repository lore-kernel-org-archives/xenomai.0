Message-Id: <830C764A-65D3-4336-9824-40DD54895A21@gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date: Mon, 31 Mar 2014 11:04:54 +0100
Subject: [Xenomai] rtdm_irq_request() warning
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

I get a warning (see below) when I register a GPIO as interrupt on  
PandaBoardES. Is it critical? According to xenodoc it should be fine  
to register an interrupt during init of a module... I figured  
rtdm_irq_request() should be fine during 'probing' of a module as well.

Thanks.

Andreas




My setup:
pandaboard Es and
root@arm:~# cat /proc/version
Linux version 3.8.13-x3.6 (root@arm) (gcc version 4.6.3 (Debian  
4.6.3-14) ) #61 SMP Fri Mar 28 13:49:05 UTC 2014
root@arm:~# cat /proc/ipipe/version
3
root@arm:~# cat /proc/xenomai/version
2.6.3

The probe code of the module:

<snip>
static int omap2_raw_probe(struct platform_device *pdev)
{
     int ret = 0;
     /* Configure GPIO */
     /* http://comments.gmane.org/gmane.linux.ports.arm.omap/92192 */
     if (!(((gpio_request(OMAP2_RAW_ADC1_RXFIFO_GPIO,
                          "OMAP2_RAW_ADC1_RXFIFO_GPIO") == 0) &&
         (gpio_direction_input(OMAP2_RAW_ADC1_RXFIFO_GPIO) == 0)))) {
         rtdm_printk(KERN_ERR "Could not claim GPIO for  
TX_SPACE_AVAILABLE_GPIO\n");
         return -1;
     }

     /* Configure interrupt line */
     ret = request_irq(gpio_to_irq(OMAP2_RAW_ADC1_RXFIFO_GPIO),
                       omap2_raw_adc1_rxfifo_dummy_handler,
                       IRQF_TRIGGER_FALLING,  
"omap2_raw_adc1_rxfifo_dummy", NULL);
     if (ret) {
         rtdm_printk(KERN_ERR "omap2_raw_probe: could not register  
rxfifo irq ret=%d\n", ret);
         return ret;
     }
     disable_irq(gpio_to_irq(OMAP2_RAW_ADC1_RXFIFO_GPIO));

     /* Setup Xenomai event and irq handler */
     rtdm_event_init(&omap2_raw_adc1_event, 0);

     ret = rtdm_irq_request(&omap2_raw_adc1_rxfifo,
                            gpio_to_irq(OMAP2_RAW_ADC1_RXFIFO_GPIO),
                            omap2_raw_adc1_rxfifo_handler,
                            RTDM_IRQTYPE_EDGE,
                            "omap2_raw_adc1_rxfifo",
                            NULL
                           );
     if (ret) {
         rtdm_printk(KERN_ERR "omap2_raw_probe: could not register  
rxfifo rtdm irq ret=%d\n", ret);
         return ret;
     }
</snip>

dmesg output:
[    4.321136] ------------[ cut here ]------------
[    4.326202] WARNING: at arch/arm/kernel/ipipe.c:157  
ipipe_set_irq_affinity+0x88/0xc8()
[    4.334655] Modules linked in: omap2_raw(+)
[    4.339202] [<c0014dcc>] (unwind_backtrace+0x0/0xf8) from  
[<c003e618>] (warn_slowpath_common+0x4c/0x64)
[    4.349182] [<c003e618>] (warn_slowpath_common+0x4c/0x64) from  
[<c003e64c>] (warn_slowpath_null+0x1c/0x24)
[    4.359497] [<c003e64c>] (warn_slowpath_null+0x1c/0x24) from  
[<c0018fc0>] (ipipe_set_irq_affinity+0x88/0xc8)
[    4.369964] [<c0018fc0>] (ipipe_set_irq_affinity+0x88/0xc8) from  
[<c00ea854>] (xnintr_attach+0x2c/0x388)
[    4.380065] [<c00ea854>] (xnintr_attach+0x2c/0x388) from  
[<c017f5f0>] (rtdm_irq_request+0x68/0xc8)
[    4.389587] [<c017f5f0>] (rtdm_irq_request+0x68/0xc8) from  
[<bf001918>] (omap2_raw_probe+0xa0/0x130 [omap2_raw])
[    4.400421] [<bf001918>] (omap2_raw_probe+0xa0/0x130 [omap2_raw])  
from [<c0501730>] (platform_drv_probe+0x18/0x1c)
[    4.411407] [<c0501730>] (platform_drv_probe+0x18/0x1c) from  
[<c05004a4>] (driver_probe_device+0x78/0x204)
[    4.421661] [<c05004a4>] (driver_probe_device+0x78/0x204) from  
[<c05006bc>] (__driver_attach+0x8c/0x90)
[    4.431671] [<c05006bc>] (__driver_attach+0x8c/0x90) from  
[<c04fed3c>] (bus_for_each_dev+0x54/0x88)
[    4.441223] [<c04fed3c>] (bus_for_each_dev+0x54/0x88) from  
[<c04ffcb4>] (bus_add_driver+0x174/0x240)
[    4.450927] [<c04ffcb4>] (bus_add_driver+0x174/0x240) from  
[<c0500bb4>] (driver_register+0x78/0x144)
[    4.460601] [<c0500bb4>] (driver_register+0x78/0x144) from  
[<c0008adc>] (do_one_initcall+0x34/0x174)
[    4.470336] [<c0008adc>] (do_one_initcall+0x34/0x174) from  
[<c009916c>] (load_module+0x1b44/0x1ebc)
[    4.479949] [<c009916c>] (load_module+0x1b44/0x1ebc) from  
[<c0099598>] (sys_init_module+0xb4/0xe8)
[    4.489471] [<c0099598>] (sys_init_module+0xb4/0xe8) from  
[<c000e340>] (ret_fast_syscall+0x0/0x34)
[    4.498962] ---[ end trace 14db3df94de50363 ]---
[    4.503936] omap2_raw_probe: device registered with ret=0


---
Andreas Glatz
Phone: +44 (0) 793 996 9950
Skype: g_andy




