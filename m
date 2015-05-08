MIME-Version: 1.0
Sender: had2006@gmail.com
Date: Fri, 8 May 2015 12:28:10 +0100
Message-ID: <CAKk99t1TPO3Tv5c+WLqPR0rcypa1bvA6tiKhoqu7cdTvAotDPQ@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Can rtdm_read, rtdm_write,
	be used in userspace in Xenomai 3.x
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I am writing a driver that implements read_rt and read_nrt handlers for
Xenomai 3-rc4 Cobalt.
But I am having problems when trying to read from user space in comand line:

$> cat /dev/rtdm/device0
cat: /dev/rtdm/device0: Invalid argument

and also from a user space real time thread:

f = open("/dev/rtdm/device0");
for(;;){
   rt_task_wait_period(NULL);
   read (f, &count, 1);
//...

This read gives me garbage.

The handler is registered with:

static struct rtdm_driver device_driver = {
        .profile_info           =       RTDM_PROFILE_INFO(DEVICENAME,
                                     RTDM_CLASS_MISC,
                                     RTDM_SUBCLASS_IOPORTS,
                                     DRIVERVER),
        .device_flags           =  RTDM_NAMED_DEVICE|RTDM_EXCLUSIVE,
        .device_count           =       1,
        .context_size           =       0,
        .ops = {
                .open = device_open,
.close = device_close,
                //.write_rt = device_write_rt,
                .read_rt = device_read_rt,
                .read_nrt = device_read_rt,
        },
};

static struct rtdm_device device_devices[2] = {
        [ 0 ... 1 ] = {
                .driver = &device_driver,
                .label = DEVICENAMEN,
        }
};


And the rt and nrt read handlers are the same function:

//Read from the device
static ssize_t device_read_rt(struct rtdm_fd *fd, void __user *buf, size_t
size) {
int err;
unsigned char rawdata[2];

rawdata[0] = 'A';
rawdata[1] = '\0';

        rtdm_printk("rtdm_read called\n");
if ((err=rtdm_safe_copy_to_user(fd, buf, rawdata, RAWDATALEN))) {
rtdm_printk("radaradcdriverRTDM: rtdm_safe_copy_to_user, error %d\n", err);
return -EFAULT;
}
rtdm_printk("rtdm_safe_copy_to_user, send %d bytes\n", err);
return err;
}

Open and close have just printks to show if they were called:

//Open the device
static int device_open(struct rtdm_fd *fd, int oflags){
rtdm_printk("rtdm_open called\n");
return 0;
}


//Close the device
static void device_close(struct rtdm_fd *fd) {
rtdm_printk("rtdm_close called\n");

}


Looking at kernel log, after accessing the driver from user spcae both:

in cmd line with:

$> cat /dev/rtdm/device0

and from a real time task

it seems that the open, close and read are never called, since there is no
entry in kernel log.

I am doing something wrong?

Should I use rtdm_read in user space to access the driver?

I tried to use it including <rtdm/rtdm.h> on user space app, but when
linking it gave me the error:

radarserver.c:(.text+0x138): undefined reference to `rtdm_read'

I thought that if I set read_nrt I can use just read.
rtdm_read will only be necessary for read_rt.
But I never implemented this kernel/user space transfer before with Xenomai
(only Linux), I just took a look at the implementation of some RTDM drivers
from xenomai sources: <xenomai-3.0-rc4>/kernel/drivers/testing/

But I might have missed something and doing something wrong.


Thanks for any suggestion
