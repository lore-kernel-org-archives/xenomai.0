MIME-Version: 1.0
Date: Mon, 30 Jun 2008 09:40:14 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <1493ab12c63e2d90490767fb70872a57@domain.hid>
References: <1493ab12c63e2d90490767fb70872a57@domain.hid>
Message-ID: <d56164e6ffb0da5884adb260d0e67c09@domain.hid>
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

Hi,

I finally succeed in using tick_arg=3D0 : The use of a watchdog (wdStart)=
 is
a goog test to show the effect of tick_arg. With tick_arg=3D0, the watchd=
og
doesn't start the specified routine as no tick has elapsed. When
tick_arg=3D0, I really think that taskDelay and tickGet or tickSet
instructions don't use the ticks anymore but a timer for time arguments o=
r
returns. For my application, it doesn't matter anyway. I only need
watchdogs.

As Philippe suggest me, I tried a tiny RTDM driver, but tickAnnouce()
doesn't works. Here is the code of my RTDM driver. Could you tell me what
doesn't work ?


#include <linux/module.h>
#include <linux/init.h>
#include <linux/fs.h>
#include <vxworks/vxworks.h>
#include <rtdm/rtdm_driver.h>

static int major =3D 0;
int tick_period =3D 1; // dure d'un tick par dfaut en ms

// RT_TASK vxworks_tick_task;
rtdm_task_t vxworks_tick_task;

/* Tache temps reel priodique, qui tick le scheduler vxworks */
void vxworks_tick(void *arg)
{
        while (1) {
		// dort pendant tick_periode ms
		rtdm_task_sleep(tick_period*1000000);
		// tick le scheduler vxworks
		tickAnnounce();
        }
}

/* ioctl qui permet d'envoyer a la tache temps reel priodique la valeur d=
e
la priode (en ms) */
static int my_ioctl_function(struct inode *inode, struct file *file,
unsigned int cmd, unsigned long arg)
{
	//recupere la priode
	tick_period =3D cmd;
	printk(KERN_DEBUG "vxworks_tick_mod : modification de la dure d'un tick =
:
%d ms\n",tick_period);
	return 0;
}

static struct file_operations fops =3D
{
	ioctl : my_ioctl_function
};

static int __init vxworks_tick_mod_init (void)
{
	int ret;
	int err;
	ret =3D register_chrdev(major,"vxworks_tick_mod", &fops);
	if (ret < 0)
	{
		printk(KERN_WARNING "vxworks_tick_mod : Problme sur le major\n");
	}
	printk(KERN_DEBUG "vxworks_tick_mod : Module charg !\n");
	err =3D rtdm_task_init(&vxworks_tick_task, "vxworks_tick_task",
&vxworks_tick, NULL, 99, 0);
	if (err) {
    		printk("vxworks_tick_mod: error rt_task_spawn\n");
    		return 0;
  	}
	return 0;
}

static void __exit vxworks_tick_mod_exit(void)
{
	int ret;
	unregister_chrdev(major, "vxworks_tick_mod");
	rtdm_task_destroy(&vxworks_tick_task);
	printk(KERN_DEBUG "vxworks_tick_mod : Module dcharg !\n");
}

module_init(vxworks_tick_mod_init);
module_exit(vxworks_tick_mod_exit);



Thank you in advance

Matthieu



