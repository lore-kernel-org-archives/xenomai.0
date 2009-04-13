From: "Wayne Call" <wcall@domain.hid>
References: <000001c9ba1a$02e1ac70$08a50550$@com>
	<49E0FB28.8000104@domain.hid>
In-Reply-To: <49E0FB28.8000104@domain.hid>
Date: Mon, 13 Apr 2009 15:24:47 -0600
Message-ID: <002301c9bc7e$478c7ba0$d6a572e0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: Re: [Xenomai-help] Section Mismatch
Reply-To: wcall@domain.hid
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

The code that causes a mismatch is posted below.

Wayne


/***************************************************************************
 *   Copyright (C) 2009 by Lone Peak Labs, Inc.                            *
 *   wcall@domain.hid
*
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 
***************************************************************************/

#include <linux/kernel.h>
#include <linux/ctype.h>
#include <xenomai/rtdm/rtdm_driver.h>
#include <linux/i2c.h>
#include <linux/lm73.h>
#include <asm/mach-bf537/lm73_rtdm.h>

#define COMPILE_LPL_DEBUG_KERNEL    1
#include <linux/lplDebug.h>



// Store pointer for sensor device
static rtlm73_sensor_device_t  *m_lm73Dev[2];
static int                      m_lm73Count;



/////////////////////////////////////////
// rt_lm73_sensor_open
//   Open the real time device
// 
static int rt_lm73_sensor_open(struct rtdm_dev_context *context,
rtdm_user_info_t *user_info, int oflags)
{
    LPL_DEBUG_KERNEL("rt_lm73_sensor_open", oflags, %d);
    return 0;
}


/////////////////////////////////////////
// rt_lm73_sensor_close
//   Close the real time device
// 
static int rt_lm73_sensor_close(struct rtdm_dev_context *context,
rtdm_user_info_t *user_info)
{
    LPL_DEBUG_KERNEL("rt_lm73_sensor_close", user_info, %p);
    return 0;
}


/////////////////////////////////////////
// rt_lm73_sensor_ioctl
//   Read from or write to the real time device
// 
static int rt_lm73_sensor_ioctl(struct rtdm_dev_context *context,
rtdm_user_info_t *user_info, int request, void *umem)
{
    u32                     kmem[1];
    rtlm73_sensor_device_t *dev     = container_of(context->device,
rtlm73_sensor_device_t, rtd);
    lm73_sensor_t          *lm73_sensor_pointer;

    LPL_DEBUG_KERNEL("rt_lm73_sensor_ioctl", request, %d);
    LPL_DEBUG_KERNEL("rt_lm73_sensor_ioctl", umem, %p);

    lm73_sensor_pointer = &dev->lm73_sensor_data;    

    LPL_DEBUG_KERNEL("rt_lm73_sensor_ioctl", lm73_sensor_pointer->address,
%#x);
    LPL_DEBUG_KERNEL("rt_lm73_sensor_ioctl", dev->rtd.device_name, %s);

    switch (request)
    {
        // Temperature read?
	    case TEMPERATURE_READ:
            kmem[0] =
lm73_retrieve_temperature(lm73_sensor_pointer->address);
            LPL_DEBUG_KERNEL("TEMPERATURE_READ", kmem[0], %#x);
            return rtdm_safe_copy_to_user(user_info, umem, kmem,
sizeof(u32));

	    case SET_TEMPERATURE_READ_RATE:
            rtdm_safe_copy_from_user(user_info, kmem, umem, sizeof(signed
int));
            lm73_approximate_temperature_read_rate(kmem[0]);
            LPL_DEBUG_KERNEL("SET TEMPERATURE_READ_RATE", kmem[0], %#x);
            return 0;
	}             
                   	                 	
    return -1;//no such op, need to find the right op code for this.
}


static const struct rtdm_device __initdata device_tmpl = {
    struct_version:     RTDM_DEVICE_STRUCT_VER,

    device_flags:       RTDM_NAMED_DEVICE | RTDM_EXCLUSIVE,
    device_name:        "",
    open_rt:            rt_lm73_sensor_open,
    ops: {
        close_rt:      	rt_lm73_sensor_close,
        ioctl_rt:       rt_lm73_sensor_ioctl,
    },
    device_class:       RTDM_CLASS_LM73,
    driver_name:        "lm73_sensor_rtd",
    driver_version:     RTDM_DRIVER_VER(0, 0, 1),
    peripheral_name:    "i2c_lm73",
    provider_name:      "LonePeakLabs.Inc",
};


int rt_lm73_sensor_device_create(const char *name, u16 address)
{
    int                     deviceSize      =
sizeof(rtlm73_sensor_device_t);
    int                     errorRegister;
    rtlm73_sensor_device_t *dev             =
kmalloc(sizeof(rtlm73_sensor_device_t), GFP_KERNEL);

    // Insert the address
    dev->lm73_sensor_data.address = address;

    LPL_DEBUG_KERNEL("rt_lm73_sensor_device_create",
dev->lm73_sensor_data.address, %d);
    LPL_DEBUG_KERNEL("rt_lm73_sensor_device_create", name, %s);
    LPL_DEBUG_KERNEL("rt_lm73_sensor_device_create", deviceSize, %d);

    memcpy(&dev->rtd, &device_tmpl, sizeof(struct rtdm_device));
    // Insert the name
    strncpy(dev->rtd.device_name, name, RTDM_MAX_DEVNAME_LEN);
    dev->rtd.proc_name = name;

    LPL_DEBUG_KERNEL("rt_lm73_sensor_device_create", dev->rtd.proc_name,
%s);

    // Register the device
    errorRegister = rtdm_dev_register(&dev->rtd);
    if (errorRegister)
    {
        LPL_DEBUG_KERNEL("rt_lm73_sensor_device_create", errorRegister, %d);
        printk("couldn't register rtlm73_sensor device %s\n",
dev->rtd.device_name);	
        kfree(dev);
        return -1;
    }
    printk("Registering LM73 RTDM %s at address %#x\n",
dev->rtd.device_name, dev->lm73_sensor_data.address);

    m_lm73Dev[m_lm73Count] = dev;
    m_lm73Count++;

    return 	0;	
}


int __init lm73_sensor_rtdm_init(void)
{
	printk("Hello LM73 RTDM Driver v0.0.1\n");
    m_lm73Count = 0;
	rt_lm73_sensor_device_create("lm73_sensor1",
LPL_LM73_SENSOR_1_ADDRESS);
	rt_lm73_sensor_device_create("lm73_sensor2",
LPL_LM73_SENSOR_2_ADDRESS);

    return 0;
}


void __exit lm73_sensor_rtdm_exit(void)
{
	printk("Goodbye LM73 RTDM Driver\n");
    // Unregister the two LM73 Sensors
	rtdm_dev_unregister(&m_lm73Dev[0]->rtd, 0);
    rtdm_dev_unregister(&m_lm73Dev[1]->rtd, 0);
}


MODULE_AUTHOR("Wayne Call<wcall@domain.hid>");
MODULE_DESCRIPTION("LM73 RTDM driver");
MODULE_LICENSE("GPL");

module_init(lm73_sensor_rtdm_init);
module_exit(lm73_sensor_rtdm_exit);



-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
Sent: Saturday, April 11, 2009 2:19 PM
To: wcall@domain.hid
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Section Mismatch

Wayne Call wrote:
> I get the following "Section mismatch" warnings when attempting to build
the
> lm73_rtdm.c and lpl_twi_uart_rtdm.c drivers.  What causes a mismatch?

Yes, these are plain Linux debugging messages, completely unrelated to
Xenomai. they tell you that you access object from the init/exit
sections from the text section, which is bad, since the init/exit
sections may not be always available when functions from the text
section are running. Show us the full code, and probably someone will be
able to tell you what the problem is.

-- 
					    Gilles.


