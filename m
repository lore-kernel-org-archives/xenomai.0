From: Dharma R Bhushan <Dharma.Bhushan@sdc.canon.co.in>
Date: Fri, 30 Nov 2012 19:34:02 +0530
Message-ID: <E715748DB106B94DAE5D77B7F3D1DC4101BB100291@CIPL-MAIL.in.canon-asia.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Problem with bringing up Xenomai User Space
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello Community Members,

I am trying to run test cases present in xenomai-2.5.6 test suite. We are getting the "Segmentation fault".

Environment is as follows

 Board:                         Bagle-board XM rev C
 Kernel:                      2.6.35.14(2.6.35 from kernel.org+patch-2.6.35.10+linaro-2.6.35.10 patch+ patch-2.6.35.11+ patch-2.6.35.12+patch-2.6.35.13+ patch-2.6.35.14)
 I-Pipe patch:          adeos-ipipe-2.6.35.9-arm-1.18-03.patch(slightly modified to apply the above kernel)
 Tool chain:                  arm-none-linux-gnueabi-
 Config command:              ./configure --build=i686-pc-linux-gnu --host=arm-none-linux-gnueabi --enable-arm-mach=omap3 --enable-arm-tsc --enable-arm-eabi
                          make DESTDIR=/root/nfsroot install

 Then I tried to run the xenomai latency test case. Then got the following error

 root@armv7a-target:~# /usr/xenomai/bin/latency == Sampling period: 1000
 us == Test mode: periodic user-mode task == All results in microseconds
 Segmentation fault

 Strace log of is attached. Upon debug I found a simple program with one
 rt_task_create and rt_task_start is also giving segmentation fault.

 I tried the approach in the below post without any success.
 http://www.mail-archive.com/xenomai-help@gna.org/msg02216.html

 I am getting the same working with the following combination.
 Board:                         Bagle-board XM rev C
 Kernel:                      3.2.21(3.2.21-kernel.org+minor fixes to boot the board)
 I-Pipe patch:          ipipe-core-3.2.21-arm-1.patch
 Tool chain:                  arm-none-linux-gnueabi-
 Config command:              ./configure CFLAGS="-march=armv7-a" LDFLAGS="-march=armv7-a" --build=i686-pc-linux-gnu --host=arm-none-linux-gnueabi-
                         make DESTDIR=/root/nfsroot install

 I feel I am missing something w.r.t ./configure command in xenomai
 2.5.6. I have attached my kernel config(2.6.35.14 kernel) too for the
 reference.

Regards,
Dharma

This e-mail and any files transmitted with it are confidential and intended solely for the use of the individual(s) or entity addressed above. If you are not the intended recipient of this e-mail, then (i) please notify us at cipl.administrator@canon.co.in (ii) do not use the information contained  & (iii) delete it from your system. E-mail communications are not secure. Though efforts have been taken to ensure that this communication has not been tampered with; however,  Canon India Pvt. Ltd. is not responsible for any changes made to the contents of or any attachments to this message without its consent.
All information contained in this message which are not of an official nature shall not be deemed as given or endorsed by Canon India Pvt. Ltd.
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: strace_latency.TXT
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20121130/285729f0/attachment.ksh>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Beaglexm_2635_adeos_defconfig
Type: application/octet-stream
Size: 61951 bytes
Desc: Beaglexm_2635_adeos_defconfig
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20121130/285729f0/attachment.obj>
