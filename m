Message-ID: <48AAD751.2040603@domain.hid>
Date: Tue, 19 Aug 2008 16:23:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C1C62166118DFA4A8BBA01A2411F0D170BF3D1BE92@domain.hid>
	<488A073F.1090403@domain.hid>
	<C1C62166118DFA4A8BBA01A2411F0D170BF3DB1DB6@domain.hid>
In-Reply-To: <C1C62166118DFA4A8BBA01A2411F0D170BF3DB1DB6@domain.hid>
Content-Type: text/plain; charset=windows-1256
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: BARRE Sebastien <sbarre@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

BARRE Sebastien wrote:
> Hi,
> 
> As you asked me I've patched a 2.6.26 kernel using latest Adeos patch, I try to compile the kernel and the result is :
> 
> calisto linux-2.6.26 # make
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/linux/compile.h
>   CC      kernel/xenomai/nucleus/heap.o
> In file included from include/asm/xenomai/system.h:2,
>                  from include/xenomai/nucleus/types.h:39,
>                  from include/xenomai/nucleus/stat.h:24,
>                  from include/xenomai/nucleus/thread.h:130,
>                  from include/xenomai/nucleus/pod.h:34,
>                  from kernel/xenomai/nucleus/heap.c:66:
> include/asm/xenomai/system_32.h:46: error: field 'fpuenv' has incomplete type
> kernel/xenomai/nucleus/heap.c: In function 'xnheap_mount':
> kernel/xenomai/nucleus/heap.c:1140: error: implicit declaration of function 'class_device_create'
> kernel/xenomai/nucleus/heap.c:1142: warning: assignment makes pointer from integer without a cast
> kernel/xenomai/nucleus/heap.c: In function 'xnheap_umount':
> kernel/xenomai/nucleus/heap.c:1160: error: implicit declaration of function 'class_device_destroy'
> make[3]: *** [kernel/xenomai/nucleus/heap.o] Error 1
> make[2]: *** [kernel/xenomai/nucleus] Error 2
> make[1]: *** [kernel/xenomai] Error 2
> make: *** [kernel] Error 2
> calisto linux-2.6.26 #
> 
> Xenomai 2.4.4 seems not to be compatible with 2.6.26 ...
> 
> What do you think ?

Yes, sorry, that is a known issue:
https://mail.gna.org/public/xenomai-help/2008-08/msg00035.html

Seeing your response time, I think you can wait a few days for the 2.4.5
release, which will support 2.6.26.

Please do not drop the CC.

Regards.

-- 
                                                 Gilles.

