Message-ID: <43980B96.9020809@domain.hid>
Date: Thu, 08 Dec 2005 12:31:50 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] insmod: error inserting './xeno_posix.ko': -1
	Unknown symbol in module
References: <002301c5fbde$7534e740$0200000a@domain.hid>
In-Reply-To: <002301c5fbde$7534e740$0200000a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Martijn Hazenberg (GOVA)" <martijn@domain.hid>
Cc: xenomai@xenomai.org

Martijn Hazenberg (GOVA) kirjoitti:
> Hi all,
> 
> I have downloaded a 2.6.14 kernel from kernel.org.
> Also have I applied the adeos patch belonging to this kernel. Rebooted with
> this kernel, and all ok.
> 
> Then I configured and compiled the xenomai tree. All ok. Only thing I
> changed to the config was the enable of the serial driver. 
> 
> Added the path to /usr/realtime/bin
> 	with PATH=$PATH:/usr/realtime/bin
> went to the /usr/realtime/testsuite/latency
> en did ./run
> 
> I got :
> 
> linux-test ~ #
> linux-test ~ #
> linux-test ~ #
> linux-test ~ # cd /usr/realtime/
> linux-test realtime # echo $PATH
> /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:/usr/i
> 686-
> pc-linux-gnu/gcc-bin/3.3.5-20050130
> linux-test realtime #
> linux-test realtime #
> linux-test realtime # PATH=$PATH:/usr/realtime/bin
> linux-test realtime #
> linux-test realtime # cd /usr/realtime/testsuite/latency/ 
> linux-test latency # ./run
> head: `-1' option is obsolete; use `-n 1' since this will be removed in the
> futu re
> *
> *
> * Type ^C to stop this application.
> *
> *
> insmod: error inserting '/usr/realtime/modules/xeno_hal.ko': -1 No such
> device
> ERROR: cannot load /usr/realtime/modules/xeno_hal.ko
> Xenomai: native skin or user-space support unavailable.
> (did you load the xeno_native.ko module?)
> linux-test latency # 
> linux-test latency #
> linux-test latency #
> linux-test latency #
> linux-test latency # cd ../../modules/
> linux-test modules # ls -all
> total 536
> drwxr-xr-x  2 root root   4096 Dec  7 17:15 .
> drwxr-xr-x  9 root root   4096 Dec  7 17:16 ..
> -rw-r--r--  1 root root  16413 Dec  7 17:15 xeno_16550A.ko
> -rw-r--r--  1 root root  20255 Dec  7 17:14 xeno_hal.ko
> -rw-r--r--  1 root root 136473 Dec  7 17:15 xeno_native.ko
> -rw-r--r--  1 root root 135807 Dec  7 17:14 xeno_nucleus.ko
> -rw-r--r--  1 root root 160091 Dec  7 17:15 xeno_posix.ko
> -rw-r--r--  1 root root  43588 Dec  7 17:15 xeno_rtdm.ko 
> # linux-test modules 
> # linux-test modules 
> # linux-test modules 
> # linux-test modules 
> # linux-test modules 
> # insmod ./xeno_native.ko
> insmod: error inserting './xeno_native.ko': -1 Unknown symbol in module 
>  linux-test modules 
> # insmod ./xeno_nucleus.ko
> insmod: error inserting './xeno_nucleus.ko': -1 Unknown symbol in module
> linux-test modules 
> # insmod ./xeno_posix.ko
> insmod: error inserting './xeno_posix.ko': -1 Unknown symbol in module
> linux-test modules 

How about insmodding xeno_hal, then xeno_nucleus and then the others.

-- hl

