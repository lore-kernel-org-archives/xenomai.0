From: "Reitinger, Peter" <preitinger@carl-valentin.de>
Date: Thu, 14 Aug 2014 08:08:20 +0000
Message-ID: <7bf2f8c91c6d45378595d8c024d76685@CVEX13.valentin-carl.de>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] access SPI and DMA hardware from application ("external
 abort on non-linefetch")
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Xenomai people,

first of all, sorry about my last post. I see now that I should have tested it myself before spamming here asking about a specific driver.
Now I have a new question/problem.

I'd like to read and write hw registers of spi and dma on an AM3354... 
Therefore I wrote a little kernel module that registers a device driver and offers an ioctl that maps a 4KB block from the "L4_WKUP Peripheral Memory Map" with the command rtdm_iomap_to_user

	printk("before map: arg=%p\n", *(void**)arg);
	code = rtdm_iomap_to_user(usr, <physical address from memory map>, 4 * 1024, 0/*PROT_READ|PROT_WRITE*/, arg, &myVmOps, NULL);
	printk("after map: arg=%p\n", *(void**)arg);
	printk("rtdm_iomap_to_user: %d\n", code);

About rtdm_iomap_to_user, I would like to ask if the existence of PROT_READ or PROT_WRITE means that reading or writing IS ALLOWED or IS PROTECTED, i.e. not allowed. (Btw PROT_READ was not available in my KM only from xenomai includes but is mentioned in the documentation. I declared PROT_READ myself as 1 and PROT_WRITE as 2 as I read from a linux header file...)

In my correlated application I open a device on the registered device driver and call the ioctl. I give a void pointer with content NULL as arg into ioctl and after the ioctl has completed I receive an address in this arg.
Then I add the offsets for specific hw registers to the received address and access it as normal uint32_t* pointers.

With this procedure I was able to successfully read the Device ID of my cpu, but with the SPI hardware I fail when trying either for McSPI0 or McSPI1.
Is my way to use an rtdm device driver, call rt_dev_open and rt_dev_ioctl in the application and rtdm_iomap_to_user in the related ioctl_rt function correct at all to access spi hw registers (and later dma control registers)? Or is there a different better way?

For completeness I add the complete code of my application and my kernel module as attachments. (Makefile is for the kernel module). The application I build with internal builder of eclipse assigning additional options from related xeno-config outputs.
The application crashes in TestMyRealtimeDriver.c:75 (" 	uint32_t test1 = *((uint32_t*) base);")

Here is the complete output of inserting the Kernel Module and running the test application:

###############################################################################################
root@dimm-am335x:~# insmod /lib/modules/3.14.0/extra/MyRealtimeDriver.ko
[ 2860.013155] MyRealtimeDriver_init
[ 2860.016673] before rtdm_dev_register
[ 2860.021208] after rtdm_dev_register: code=0
root@dimm-am335x:~# /TestMyRealtimeDriver
[ 2872.751062] handleOpen
TestMyRealtimeDriver 0.0
pageSize: 4096[ 2872.754022] before map: arg=  (null)

fd=0
base before dev_ioctl: (nil)
[ 2872.761884] after map: arg=b6fa6000
[ 2872.768139] rtdm_iomap_to_user: 0
rt_dev_ioctl: code=0, base=0xb6fa6000
rt_task_create: 0
rt_task_start[ 2872.774292] Unhandled fault: external abort on non-linefetch (0x1018) at 0xb6fa6000
: 0
before rt_task_join
rtFunc entered
before test1: base=0xb6fa6000
[ 2872.789778] Xenomai: RTDM: closing file descriptor 0.
[ 2872.798021] handleClose
Bus error
root@dimm-am335x:~#
###############################################################################################


Thank you in advance for your help!

Kind regards
Peter Reitinger
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Makefile
Type: application/octet-stream
Size: 228 bytes
Desc: Makefile
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140814/d75b1f5b/attachment.obj>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: MyRealtimeDriver.c
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140814/d75b1f5b/attachment.c>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: TestMyRealtimeDriver.c
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140814/d75b1f5b/attachment-0001.c>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: util.c
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140814/d75b1f5b/attachment-0002.c>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: util.h
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140814/d75b1f5b/attachment.h>
