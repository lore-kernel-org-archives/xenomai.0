From: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
Date: Wed, 10 Aug 2011 14:49:53 -0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201108101449.54243.carlosnov@domain.hid>
Subject: [Xenomai-help] Trouble with rtdm timers and events
Reply-To: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello to all,

I am learning how to use rtdm_timer and also rtdm_event to use on acquisition 
board. The board itself has a FIFO and can be configurated do fill it in a 
predefined time. The problem is that there is no interrupt generated when the 
FIFO is full or on a given number of samples, so I have to poll the data.

As the conversion time is know (based on board latency, conversion time and 
number os channels to scan), a better approach would be let the board do its 
conversion and at given times, where the data should be ready on FIFO (and 
also, the FIFO is far large than the amount of data retrieved) and then, get 
it, setup a new delay based on the estimated remaining data for the next scan, 
fire an event to unblock an read operation and loop the entire proccess 
again...
Also, there is an user space real time application that will open the rtdm 
device, issue some configurations via ioctl and loop reading the device.

The code specific to timming is working almost as good, I can see the app 
returning a increasing counter by the time it is running. The only issue is 
that the CPU hangs if I try to remove the module or run the app one second 
time (or if I close and then reopen the device)
Any call to configure the rtdm_event  will hang the CPU.

Hope you can give some appointments or tell me what I am doing wrong.
Here is the relevant sections of code, only code specific to xenomai and 
related with the issues.

--- For the app
int main(int argc, char **argv)
{
  int device;
  int ret;
  int32_t sample_number;
  
  ret = mlockall(MCL_CURRENT | MCL_FUTURE);...
  ret = rt_task_shadow(&rt_task_desc, NULL, 1, 0);...
  
  sample_number = 0;
  //Open
  device = rt_dev_open(DEVICE_NAME, 0);....

  // IOCTL Start
  ret = rt_dev_ioctl(device, 0x07);...
  
  sleep(3);
  // Read
  ret = rt_dev_read (device, &sample_number, sizeof(sample_number));
  printf("Read %d. Sample %d\n", ret, sample_number);
  ret = rt_dev_read (device, &sample_number, sizeof(sample_number));
  printf("Read %d. Sample %d\n", ret, sample_number);
  sleep(3);
  ret = rt_dev_read (device, &sample_number, sizeof(sample_number));
  printf("Read %d. Sample %d\n", ret, sample_number);
  ret = rt_dev_read (device, &sample_number, sizeof(sample_number));
  printf("Read %d. Sample %d\n", ret, sample_number);
  sleep(3);
  ret = rt_dev_read (device, &sample_number, sizeof(sample_number));
  printf("Read %d. Sample %d\n", ret, sample_number);
  ret = rt_dev_read (device, &sample_number, sizeof(sample_number));
  printf("Read %d. Sample %d\n", ret, sample_number);
  sleep(2);
  ret = rt_dev_read (device, &sample_number, sizeof(sample_number));
  printf("Read %d. Sample %d\n", ret, sample_number);
  
    // IOCTL Stop
  ret = ioctl(device, 0x08);...

  /* close the device */
  ret = rt_dev_close(device);...  
  return 0;
}

---

--- For the Driver
...
static struct rtdm_device RtdmDevice = {
        .struct_version = RTDM_DEVICE_STRUCT_VER,
        .device_flags = RTDM_NAMED_DEVICE,
        .context_size = 0,
        .device_name = DEVICE_NAME,

        .open_nrt = pci18xx_rtdm_open,
        .open_rt  = pci18xx_rtdm_open,


        .ops = {
                .close_nrt = pci18xx_rtdm_close,
                .close_rt  = pci18xx_rtdm_close,
                .read_rt   = pci18xx_rtdm_read_rt,
                .read_nrt   = pci18xx_rtdm_read_rt,
                .write_rt  = pci18xx_rtdm_write_rt,
                .ioctl_rt  = pci18xx_rtdm_ioctl_nrt,
                .ioctl_nrt = pci18xx_rtdm_ioctl_nrt,
        },

        .device_class = RTDM_CLASS_EXPERIMENTAL,
        .device_sub_class = SOME_SUB_CLASS,
        .profile_version = 1,
        .driver_name = DRIVER_NAME,
        .driver_version = RTDM_DRIVER_VER(0, 1, 2),
        .peripheral_name = "Icpdas Daq18xx Board",
        .provider_name = "Carlos Novaes",
        .proc_name = RtdmDevice.device_name,
        .device_id = -1,
};...
...
static int              pci18xx_rtdm_ioctl_nrt(struct rtdm_dev_context 
*context, rtdm_user_info_t *user_info, unsigned int request, void __user *arg)
{
  pci18xx_context_t     *ctx;
  int                   err;
  
  err = 0;
  rtdm_printk("IOCTL Device NRT. Request = %d\n", request);

  ctx = (pci18xx_context_t *)context->dev_private;
  switch (request){
    case IOCTL_START:
      err = pci18xx_start(context, ctx, user_info, arg);
      break;
    case IOCTL_STOP:
      err = pci18xx_stop(ctx, user_info, arg);
      break;
    default:
      return PCI18XX_E_INVALID_IOCTL;
  }
  return PCI18XX_OK;
};...
...
static ssize_t          pci18xx_rtdm_read_rt(struct rtdm_dev_context *context, 
rtdm_user_info_t * user_info, void *buf, size_t nbyte){
  int16_t size;
  int32_t value;
  int err;  
 
  pci18xx_context_t *ctx;
  // following line fails
  //err = rtdm_event_timedwait(&ctx->RtdmReadyEvent,2000000000, NULL);
  
  ctx = (pci18xx_context_t *) context->dev_private;
  size=sizeof(ctx->SampleNumber);
  
  if (rtdm_safe_copy_to_user(user_info, buf, &(ctx->SampleNumber), size)){...
  return size;
};...
...
static int              pci18xx_start(struct rtdm_dev_context *context, 
pci18xx_context_t *ctx, rtdm_user_info_t *user_info, void __user *arg){
  rtdm_timer_init(&ctx->RtdmTimer, pci18xx_timer_proc, context->device-
>device_name);
  // following line fail
  //rtdm_event_init(&ctx->RtdmReadyEvent, 0);
  ctx->Running=1;
  ctx->SampleNumber=0;
  ctx->time = rtdm_clock_read_monotonic();
  ctx->time += 1000000000;
  rtdm_timer_start(&ctx->RtdmTimer, ctx->time, 0, RTDM_TIMERMODE_ABSOLUTE);
  return 0;
};
static int              pci18xx_stop(pci18xx_context_t *ctx, rtdm_user_info_t 
*user_info, void __user *arg){
  rtdm_printk("stop function\n");
  if (ctx->Running){
    ctx->Running=0;
    // following line fail
    //rtdm_event_destroy(&ctx->RtdmReadyEvent);
    rtdm_timer_destroy(&ctx->RtdmTimer);    
  }
  return 0;
};
static void             pci18xx_timer_proc(rtdm_timer_t *timer){
  pci18xx_context_t *ctx;
  int err;
  ctx = container_of(timer, pci18xx_context_t, RtdmTimer);
  ctx->SampleNumber++;
  ctx->time += 1000000000;
  err = rtdm_timer_start_in_handler(&ctx->RtdmTimer, ctx->time, 0, 
RTDM_TIMERMODE_ABSOLUTE);
  // following line fail
  //rtdm_event_pulse(&ctx->RtdmReadyEvent);
};
---

