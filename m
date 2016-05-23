MIME-Version: 1.0
Date: Mon, 23 May 2016 09:49:18 +0200
From: mfinkbei <mfinkbei@stud.hs-heilbronn.de>
Message-ID: <0abe0634dbf999057bf8529e0cc0ecd8@stud.hs-heilbronn.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Subject: [Xenomai] Xenomai on Udoo Neo
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am writing to request some Details about the Xenomai using for an Udoo 
Neo.
In my currently Thesis I'm working for the first time with an real-time 
System.
One objective therefore is to install Xenomai 3 on the Udoo Neo board 
with an iMX6 multicore Processor.
For the board exist a Linux-Version on the base of the Linux kernel 
3.14.56.
For this kernel Version there no i-pipe patch available. This is why I 
was looking for differences in the affected Files of the kernel 3.14.44 
and 3.14.56 and Change the i-pipe-patch when there are differences.
Afterwards, I was able to patch the Udoo Neo Kernel, to make the config, 
the bzImage and the modules and Install it from an Computer with 
Linux-OS to the SD-Card as described in the Documentation.
At that time of the Installation I kept on working with the Udoo Neo 
Board. For Configuring and building the ARM libraries I use the commands
./scripts/bootstrap
sudo ../configure CFLAGS="-march=armv7-a" LDFLAGS="-march=armv7-a" 
--with-core=cobalt --enable-smp

After the make install Command I wanted to test the Installation with
dmesg | grep -i xenomai
where I get the Output

[    0.147853] [[01;31m[KXenomai[m[K] scheduling class idle 
registered.
[    0.147865] [[01;31m[KXenomai[m[K] scheduling class rt 
registered.
[    0.148004] [[01;31m[KXenomai[m[K] init failed, code -19

  the full dmesg output in this time frame is

[    0.146610] Bus freq driver module loaded
[    0.147489] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.147909] [Xenomai] scheduling class idle registered.
[    0.147921] [Xenomai] scheduling class rt registered.
[    0.148021] I-pipe: high-resolution clock not working
[    0.148063] [Xenomai] init failed, code -19
[    0.155688] VFS: Disk quotas dquot_6.5.2
[    0.155999] Dquot-cache hash table entries: 1024 (order 0, 4096 
bytes)

In the Archive of this mailing list I could find posts with similar 
Problems, where the user have to Change the Frequency scaling in the 
defconfig data.
But when I tried to disable the Frequency scaling with "make 
menuconfig", the kernel of Udoo can't compile.

I hope someone will have an idea to find a solution for this Problem.


Melanie
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: udoo_neo_defconfig
URL: <http://xenomai.org/pipermail/xenomai/attachments/20160523/1ce893f7/attachment.ksh>
