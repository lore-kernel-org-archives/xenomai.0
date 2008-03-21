From: "Robert McCullough" <rob@domain.hid>
References: <001a01c88a0d$5365af40$9601a8c0@domain.hid>
	<47E2BB0F.9050704@domain.hid>
Date: Fri, 21 Mar 2008 10:57:23 -0400
Message-ID: <001001c88b63$df59b300$9601a8c0@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-reply-to: <47E2BB0F.9050704@domain.hid>
Subject: Re: [Xenomai-help] Non-Real-Time Asynchronous Notification
Reply-To: rob@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Hi Jan,

  --> -----Original Message-----
  --> From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
  --> Sent: Thursday, March 20, 2008 3:29 PM
  --> To: rob@domain.hid
  --> Cc: xenomai@xenomai.org
  --> Subject: Re: [Xenomai-help] Non-Real-Time Asynchronous Notification
  --> 
  --> Robert McCullough wrote:
  --> > Hi,
  --> >
  --> > How do I signal an asynchronous notification from a RTDM real-time
  --> task to a
  --> > non-real-time user-space Linux thread?
  --> > Do I use Non-Real-Time Signaling Services (rtdm_nrtsig_init,..)?
  --> > If so, how?
  --> >
  --> > Here is the current code that I am trying to port to RTDM.
  --> >
  --> > Current driver code to signal non-real-time Linux thread:
  --> >
  --> > 	// If event
  --> > 	if(event){
  --> > 		// and signal asynchronous readers
  --> > 		if (kmdpr_device->async_queue)
  --> > 			kill_fasync(&kmdpr_device->async_queue,
SIGIO,
  --> > POLL_IN);
  --> > 	}
  --> 
  --> Just push this code in the rtdm_nrtsig handler and trigger the handler
  --> execution from RT context.
  --> 
  --> Jan

[Robert McCullough] 
Ok, I understand that but how do I specify the file operation fasync in my
rtdm_device?  How do I replace or update the code marked TODO?

Here is a snippet of my current RTDM.

/* TODO replace fasync with Xenomai counterpart */
int kmdpr_fasync(int fd, struct file *filp, int mode)
{
	kmdpr_context_t *ctx = filp->private_data;

	return fasync_helper(fd, filp, mode, &ctx->async_queue);
}

static int kmdpr_close (struct rtdm_dev_context *context,
						rtdm_user_info_t *
user_info)
{
	kmdpr_context_t *ctx; /* device context information */

	PRODEBUG(MODULE_NAME, "Close: kmdpr\n");

/* TODO replace fasync with Xenomai counterpart */
	// remove this filp from the asynchronously notified filp's 
//	kmdpr_fasync(-1, filp, 0);


	ctx = (kmdpr_context_t *)context->dev_private;
	/*
	 * Shut Down KMDPR port
	 */
	shutdown(ctx);
	return 0;
}

/**
* This structure describe the kmdpr RTDM device
*
*/
static struct rtdm_device kmdpr_device = {
	struct_version:	RTDM_DEVICE_STRUCT_VER,
		 
	device_flags:		RTDM_NAMED_DEVICE,
	context_size:		sizeof(kmdpr_context_t),
	device_name:		DEVICE_NAME,
		 
	open_rt:			kmdpr_open,
	open_nrt: 			kmdpr_open,
		 
	ops: {
		close_rt:		kmdpr_close,
		close_nrt:		kmdpr_close,
		
		ioctl_rt:		kmdpr_ioctl,
		ioctl_nrt:		kmdpr_ioctl,

		read_rt:		NULL,
		read_nrt:		NULL,
		
		write_rt:		NULL,
		write_nrt:		NULL,
		
/* TODO replace fasync with Xenomai counterpart 
		fasync_rt:   	NULL,
		fasync_nrt:   	kmdpr_fasync,
*/
	},
		 
	device_class: 		RTDM_CLASS_KMDPR,
	device_sub_class:	RTDM_SUBCLASS_GENERIC,
	profile_version:	1,
	
	driver_name:		MODULE_NAME,
	driver_version:     RTDM_DRIVER_VER(MODULE_MAJOR_VER, 
	
MODULE_MINOR_VER, 
	
MODULE_BUGFIX_VER),
	peripheral_name:	MODULE_DESC,
	provider_name:		"Promess Incorporated",
	proc_name:			kmdpr_device.device_name,
};

Thanks,
Rob



