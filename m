Message-ID: <4AA91060.70608@domain.hid>
Date: Thu, 10 Sep 2009 16:42:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BB99A6BA28709744BF22A68E6D7EB51F032442FBF6@domain.hid>
	<4AA824F3.9090108@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F03248BD696@domain.hid>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F03248BD696@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Testsuite fails on 2.5-rc3
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonathan Haws <Jonathan.Haws@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jonathan Haws wrote:
>>> All,
>>> 
>>> I am trying to run Xenomai 2.5-rc3 on a 2.6.30.3 kernel from Denx
>>> 
>> on an AMCC 405EX CPU.  I have it all installed and ran the 
>> testsuite, but the latency, switchtest, switchbench, and cyclictest
>>  tests fail with these messages:
>>> 
>>> 
>> ====================================================================
>>  =
>>> running: ./run -- -sh -T 120 -t0 # latency * * * Type ^C to stop
>>> this application. * * Xenomai: open: No such file or directory 
>>> Xenomai: mmap(local sem heap): No such file or directory
>> You probably have not run make install correctly, so you are
>> missing /dev/rtheap on the target.
> 
> You are right, there is no /dev/rtheap on the target.  However, I am
> building a ramdisk that uses a device table file to create all the
> devices in /dev when I create them EXT2 image.  What are the
> major/minor numbers for /dev/rtheap and how many of those devices
> does Xenomai need?  If I have that information, I should be able to
> add the device to the table.

These tables exist in many formats, here is the one I use:

crw-    10,254  /dev/rtheap
crw-    150,0   /dev/rtp0
crw-    150,1   /dev/rtp1
crw-    150,2   /dev/rtp2
crw-    150,3   /dev/rtp3
crw-    150,4   /dev/rtp4
crw-    150,5   /dev/rtp5
crw-    150,6   /dev/rtp6
crw-    150,7   /dev/rtp7
crw-    150,8   /dev/rtp8
crw-    150,9   /dev/rtp9
crw-    150,10  /dev/rtp10
crw-    150,11  /dev/rtp11
crw-    150,12  /dev/rtp12
crw-    150,13  /dev/rtp13
crw-    150,14  /dev/rtp14
crw-    150,15  /dev/rtp15
crw-    150,16  /dev/rtp16
crw-    150,17  /dev/rtp17
crw-    150,18  /dev/rtp18
crw-    150,19  /dev/rtp19
crw-    150,20  /dev/rtp20
crw-    150,21  /dev/rtp21
crw-    150,22  /dev/rtp22
crw-    150,23  /dev/rtp23
crw-    150,24  /dev/rtp24
crw-    150,25  /dev/rtp25
crw-    150,26  /dev/rtp26
crw-    150,27  /dev/rtp27
crw-    150,28  /dev/rtp28
crw-    150,29  /dev/rtp29
crw-    150,30  /dev/rtp30
crw-    150,31  /dev/rtp31


> 
> I have used RTAI in the past and it seems like when I would insmod an
> RTAI module, it would create the necessary devices.  How does Xenomai
> get its devices into /dev normally?

In the past, devfs was a kernel thing handling automatic creation of
devices nodes. Now, devfs is dead and buried, udev, a user-space tool
replaces it. So, you need scripts, which are also normally appended to
the /etc/udev/udev.rules of your target when running make install with
the proper DESTDIR. However, for this to work, you need to start udev as
part of your target boot scripts.

> 
>>> /usr/local/xenomai/bin/xeno-test: cd: line 1: can't cd to
>> /usr/local/xenomai/share/xenomai/testsuite/switchbench
>> 
>> Do you have a
>> /usr/local/xenomai/share/xenomai/testsuite/switchbench on the
>> target ?
>> 
>>> Thu Jan  1 00:00:22 UTC 1970 running: ./run -- -h # switchbench 
>>> /usr/local/xenomai/bin/xeno-test: eval: line 1: ./run: not found
>> That follows from the previous error (can not cd to the directory 
>> where "run" is supposed to be found, so can not run "run" either).
> 
> Right again.  There is no switchbench on the target's testsuite.

Ok. Will check on my target if switchbench is properly installed.


> The version returned in 2.7-00.  However, that is after I ran the
> 2.5-rc3 patch on the kernel.  I ran prepare_kernel.sh again on my
> kernel source tree from 2.4.9.1 to try and make sure I was using
> version 2.4.9.1 and my xeno-test ran like it did before, but with
> slightly different output:

Ok. For this issue, I will let Philippe answer.

-- 
                                          Gilles


