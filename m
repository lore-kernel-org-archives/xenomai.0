Message-ID: <4726141A.1030507@domain.hid>
Date: Mon, 29 Oct 2007 10:10:50 -0700
From: Dennis Nguyen <dennisnguy@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Can't patch linux-2.6.20.21 with
 adeos-ipipe-2.6.20-i386-1.10-10.patch - xenomai 2.3.4
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

I tried to patch the linux-2.6.20.21 with 
adeos-ipipe-2.6.20-i386-1.10-10.patch without success.

There my prepare:
[root@domain.hid linux-2.6.20.21]# 
linux_tree=/usr/src/kernels/linux-2.6.20.21
[root@domain.hid linux-2.6.20.21]# 
xenomai_root=/home/dennisn/work/ethercat/xenomai-2.3.4/
[root@domain.hid linux-2.6.20.21]# 
xenomai_root=/home/dennisn/work/ethercat/xenomai-2.3.4
[root@domain.hid linux-2.6.20.21]# 
adeos_patch=/home/dennisn/Download/adeos-ipipe-2.6.20-i386-1.10-10.patch
[root@domain.hid linux-2.6.20.21]# cd $xenomai_root
[root@domain.hid xenomai-2.3.4]# scripts/prepare-kernel.sh --arch=i386 
--adeos=$adeos_patch --linux=$linux_tree

These are error:
patching file arch/i386/kernel/entry.S
Hunk #9 FAILED at 426.
1 out of 29 hunks FAILED -- saving rejects to file 
arch/i386/kernel/entry.S.rej
patching file mm/vmalloc.c
prepare-kernel.sh: Unable to patch kernel 2.6.20.21 with 
adeos-ipipe-2.6.20-i386-1.10-10.patch.

I found out that the adeos patches only worked with kernel upto 
linux-2.6.20.10.
Any suggestion please.
Thanks,
Dennis

