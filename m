MIME-Version: 1.0
Date: Tue, 1 Jul 2008 10:28:16 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <d56164e6ffb0da5884adb260d0e67c09@domain.hid>
References: <d56164e6ffb0da5884adb260d0e67c09@domain.hid>
Message-ID: <0b7c9c9d30b7cd3a2ecc4b3b5984d59c@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: matthieu.connaulte_xenomai@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I tried an other code, but I didn't succeed too. Can anybody help me ?

here is my code :


#include <rtdm/rtdm_driver.h>
#include <vxworks/vxworks.h>

// our driver context struct: used for storing various information
struct drv_context {
};

long tick_period=3D1;

// RT_TASK vxworks_tick_task;
rtdm_task_t vxworks_tick_task;


/************************************************************/
/*Tache temps rel priodique, qui tick le scheduler vxworks*/
/************************************************************/
void vxworks_tick(void *arg)
{
	while (1) {
		// dort pendant tick_periode ms
		rtdm_task_sleep(tick_period*1000000);
		// tick le scheduler vxworks
		tickAnnounce();
		// rtdm_printk("TickAnnounce\n");
        }
}


/**********************************************************/
/*            DRIVER OPEN                                 */
/**********************************************************/
void open_rt(struct rtdm_dev_context    *context,
                 rtdm_user_info_t           *user_info,
                 int                        oflags)
{

}

/**********************************************************/
/*            DRIVER CLOSE                                */
/**********************************************************/
void close_rt(struct rtdm_dev_context   *context,
                  rtdm_user_info_t          *user_info)
{

}

/**********************************************************/
/*            DRIVER IOCTL                                */
/**********************************************************/
void ioctl_rt(struct rtdm_dev_context   *context,
                  rtdm_user_info_t          *user_info,
                  int                       request,
                  void                      *arg)
{
=20
}


/**********************************************************/
/*            DRIVER OPERATIONS                           */
/**********************************************************/
static struct rtdm_device tick_driver =3D {
    struct_version:     RTDM_DEVICE_STRUCT_VER,

    device_flags:       RTDM_NAMED_DEVICE,
    context_size:       sizeof(struct drv_context),
    device_name:        "vxworks_tick_mod0",

/* open and close functions are not real-time safe due kmalloc
   and kfree. If you do not use kmalloc and kfree, and you made
   sure that there is no syscall in the open/close handler, you
   can declare the open_rt and close_rt handler.
*/
    open_rt:            open_rt,
    open_nrt:           NULL,

    ops: {
        close_rt:       close_rt,
        close_nrt:      close_rt,

        ioctl_rt:       ioctl_rt,
        ioctl_nrt:      NULL,

        read_rt:        NULL,
        read_nrt:       NULL,

        write_rt:       NULL,
        write_nrt:      NULL,

        recvmsg_rt:     NULL,
        recvmsg_nrt:    NULL,

        sendmsg_rt:     NULL,
        sendmsg_nrt:    NULL,
    },

    device_class:       RTDM_CLASS_EXPERIMENTAL,
    device_sub_class:   222,
    driver_name:        "vxworks_tick_mod",
    peripheral_name:    "vxworks_tick_mod",
    provider_name:      "-",
    proc_name:          tick_driver.device_name,
};

/**********************************************************/
/*            INIT DRIVER                                 */
/**********************************************************/
int init_module(void)
{
    rtdm_dev_register(&tick_driver);
    rtdm_task_init(&vxworks_tick_task, "vxworks_tick_task", &vxworks_tick=
,
NULL, 99, 0);
    return 0;=20
}

/**********************************************************/
/*            CLEANUP DRIVER                              */
/**********************************************************/
void cleanup_module(void)
{
    rtdm_task_destroy(&vxworks_tick_task);
    rtdm_dev_unregister(&tick_driver, 1000);
}



Matthieu.




