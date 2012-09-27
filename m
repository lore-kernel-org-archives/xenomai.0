MIME-Version: 1.0
In-Reply-To: <506496C2.9030302@xenomai.org>
References: <CAOiXNkCgA42HcOWaLuzmkaLPaSW2zCTEux3rdzKmUYeu1Egzyg@mail.gmail.com>
	<506496C2.9030302@xenomai.org>
Date: Thu, 27 Sep 2012 23:05:19 +0200
Message-ID: <CAOiXNkA3NLDDzt6PaYj670jGuAeES_r8pm0Q6qo9vAk=zgO9VA@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Error requesting IRQ on DM3730 (BeagleBoard xM)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> The message is likely a false positive. Could you post the init_module code?

Sure, here it is. I removed some simple array initializations and
error handling code which is not invoked in this scenario to make
functions shorter. Two relevant places are marked with <<<

static struct rtdm_device device = {
  .struct_version = RTDM_DEVICE_STRUCT_VER,

  .device_flags = RTDM_NAMED_DEVICE,
  .context_size = sizeof(context_t),
  .device_name = DEVICE_NAME,

  .open_nrt = pwm_rtdm_open_nrt,

  .ops = {
    .close_nrt = pwm_rtdm_close_nrt,
    .read_nrt = pwm_rtdm_read_nrt,
    .write_nrt = pwm_rtdm_write_nrt,
  },

  .device_class = RTDM_CLASS_EXPERIMENTAL,
  .device_sub_class = SOME_SUB_CLASS,
  .profile_version = 1,
  .driver_name = "TB6612FNG-CTL",
  .driver_version = RTDM_DRIVER_VER(0, 1, 2),
  .peripheral_name = "TB6612FNG dual motor driver",
  .provider_name = "Andrey Nechypurenko",
  .proc_name = device.device_name,
};

int __init pwm_rtdm_init(void)
{
  int res;

  res = rtdm_dev_register(&device);
  if(res == 0)
    rtdm_printk("TB6612FNG: driver registered without errors\n");
  else
    {
          ... error handling
   }

  res = initpwm();
  return res;
}

int
initpwm(void)
{
  int i;
  int retval;

  // Set GPIO mode and configuration
  retval = InitGPIO(channels, sizeof(channels) / sizeof(channels[0]));
  rtdm_printk("TB6612FNG: Starting PWM generation timers.\n");
  retval = rtdm_timer_init(&up_timer, pwm_up, "up timer");

  for(i = 0; i < RC_NUM; i++)
    {
      retval = rtdm_timer_init(&down_timer[i], pwm_down, "down timer");
    }

  retval = rtdm_timer_start(&up_timer,
                            PERIOD, // we will use periodic timer
                            PERIOD, // PERIOD period
                            RTDM_TIMERMODE_RELATIVE);

  rtdm_printk("TB6612FNG: initializing encoder handlers\n");
  retval = initializeEncoders(); // <<<< this is the function where
irq is requested and warning is printed

  return 0;
}

int
initializeEncoders(void)
{
  void __iomem *confmem = NULL;
  int res = 0;
  const int irq = gpio_to_irq(143);
  rtdm_printk("IRQ for GPIO 143: %i\n", irq); // 303 for 143

  // Enable interrupts for rotary encoders
  confmem = ioremap(0x48200000, 0x05cc);

  iowrite32(0, confmem + 0x0010); // sysconfig
  iowrite32(1, confmem + 0x0050); // idle
  iowrite32(0, confmem + 0x0174); // ILRm
  // 15 = (gpio)143 - 128
  iowrite32(1 << 15, confmem + 0x0088); // clear MIRn (INTCPS_MIR_CLEARn)

  iounmap(confmem);

  res = rtdm_irq_request(&irq_handles[0],
                         irq, //303 - something happens,
                         encoderIrqHandler,
                         RTDM_IRQTYPE_EDGE,
                         "wheel-encoder1",
                         NULL);   <<<<<< This call causing the WARNING message
  return res;
}

int
encoderIrqHandler(rtdm_irq_t *irq_handle)
{
  ++irq_count;
  return RTDM_IRQ_HANDLED;
}


Thank you,
Andrey.

