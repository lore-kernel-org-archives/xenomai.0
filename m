Message-ID: <4A54582E.5070407@domain.hid>
Date: Wed, 08 Jul 2009 10:26:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <852117.36446.qm@domain.hid>
In-Reply-To: <852117.36446.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_create memory size
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yigal Goldberger <yigal_gold@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Yigal Goldberger wrote:
> Hi again,
> I've performed the cat proc/pid/maps

Ok, could you try /proc/pid/smaps? It gives you the sizes. Anyway:

> 
> I see a lot of libraries that were loaded .
> Can you assist me in understanding this output :
> 
> 
> 
>  -bash-3.2# cat proc/1203/maps
> uart_ioctl, cmd is 802c7415
> in set_termios
> in change_termios
> 00100000-00103000 r-xp 00100000 00:00 0          [vdso]
> 0fa60000-0fb9c000 r-xp 00000000 00:0b 3577533    /lib/libc-2.6.so
> 0fb9c000-0fbdb000 ---p 0013c000 00:0b 3577533    /lib/libc-2.6.so
> 0fbdb000-0fbdd000 r--p 0013b000 00:0b 3577533    /lib/libc-2.6.so
> 0fbdd000-0fbe0000 rwxp 0013d000 00:0b 3577533    /lib/libc-2.6.so
> 0fbe0000-0fbe3000 rwxp 0fbe0000 00:00 0
> 0fbf3000-0fc06000 r-xp 00000000 00:0b 3577554    /lib/libgcc_s.so.1
> 0fc06000-0fc45000 ---p 00013000 00:0b 3577554    /lib/libgcc_s.so.1
> 0fc45000-0fc46000 rwxp 00012000 00:0b 3577554    /lib/libgcc_s.so.1
> 0fc56000-0fcf6000 r-xp 00000000 00:0b 3577583    /lib/libm-2.6.so
> 0fcf6000-0fd35000 ---p 000a0000 00:0b 3577583    /lib/libm-2.6.so
> 0fd35000-0fd36000 r--p 0009f000 00:0b 3577583    /lib/libm-2.6.so
> 0fd36000-0fd39000 rwxp 000a0000 00:0b 3577583    /lib/libm-2.6.so
> 0fd49000-0fd4c000 r-xp 00000000 00:0b 3508708    /usr/xenomai/lib/librtdm.so.1.0
> .0
> 0fd4c000-0fd8b000 ---p 00003000 00:0b 3508708    /usr/xenomai/lib/librtdm.so.1.0
> .0
> 0fd8b000-0fd8c000 rwxp 00002000 00:0b 3508708    /usr/xenomai/lib/librtdm.so.1.0
> .0
> 0fd9c000-0fe8a000 r-xp 00000000 00:0b 3577648    /lib/libstdc++.so.6.0.9
> 0fe8a000-0fec9000 ---p 000ee000 00:0b 3577648    /lib/libstdc++.so.6.0.9
> 0fec9000-0fecd000 r--p 000ed000 00:0b 3577648    /lib/libstdc++.so.6.0.9
> 0fecd000-0fece000 rwxp 000f1000 00:0b 3577648    /lib/libstdc++.so.6.0.9
> 0fece000-0fed5000 rwxp 0fece000 00:00 0
> 0fee5000-0feec000 r-xp 00000000 00:0b 3577633    /lib/librt-2.6.so
> 0feec000-0ff2b000 ---p 00007000 00:0b 3577633    /lib/librt-2.6.so
> 0ff2b000-0ff2c000 r--p 00006000 00:0b 3577633    /lib/librt-2.6.so
> 0ff2c000-0ff2d000 rwxp 00007000 00:0b 3577633    /lib/librt-2.6.so
> 0ff3d000-0ff51000 r-xp 00000000 00:0b 3577623    /lib/libpthread-2.6.so
> 0ff51000-0ff91000 ---p 00014000 00:0b 3577623    /lib/libpthread-2.6.so
> 0ff91000-0ff92000 r--p 00014000 00:0b 3577623    /lib/libpthread-2.6.so
> 0ff92000-0ff93000 rwxp 00015000 00:0b 3577623    /lib/libpthread-2.6.so
> 0ff93000-0ff95000 rwxp 0ff93000 00:00 0
> 0ffa5000-0ffb0000 r-xp 00000000 00:0b 3509109    /usr/xenomai/lib/libpthread_rt.
> so.1.0.0
> 0ffb0000-0ffef000 ---p 0000b000 00:0b 3509109    /usr/xenomai/lib/libpthread_rt.
> so.1.0.0
> 0ffef000-0fff0000 rwxp 0000a000 00:0b 3509109    /usr/xenomai/lib/libpthread_rt.
> so.1.0.0
> 10000000-1003e000 r-xp 00000000 00:0b 3509108    /802Rdr
> 1007e000-1007f000 rwxp 0003e000 00:0b 3509108    /802Rdr
> 1007f000-10081000 rwxp 1007f000 00:00 0
> 10081000-100eb000 rwxp 10081000 00:00 0          [heap]
> 48000000-4801d000 r-xp 00000000 00:0b 3577520    /lib/ld-2.6.so
> 4801d000-4801e000 rw-p 4801d000 00:00 0
> 4801e000-4801f000 rw-p 4801e000 00:00 0
> 4801f000-48020000 rw-s 10000000 00:0b 3506904    /dev/mem
> 48020000-48021000 rw-s 00010000 00:0b 3506904    /dev/mem
> 48023000-48026000 rw-p 48023000 00:00 0
> 48026000-4802e000 rw-s 10010000 00:0b 3506904    /dev/mem
> 4805c000-4805d000 r--p 0001c000 00:0b 3577520    /lib/ld-2.6.so
> 4805d000-4805e000 rwxp 0001d000 00:0b 3577520    /lib/ld-2.6.so
> 4805e000-4805f000 ---p 4805e000 00:00 0
> 4805f000-4885e000 rw-p 4805f000 00:00 0

This is typically a thread stack: the page with only the 'p' flag is the
"guard page", which will cause a segmentation fault in case of stack
overflow. The other area is the stack, its size is 8 MB.

> 4885e000-4885f000 ---p 4885e000 00:00 0
> 4885f000-4905e000 rw-p 4885f000 00:00 0

8 MB

etc...


> 4d85e000-4d85fuart_ioctl, cmd is 402c7413

These uart_ioctl are printks in one of your drivers probably

> bfe75000-bfe8a000 rw-p bffeb000 00:00 0          [stack]

The main thread stack, strangely, is only 86K large (I believe it is
allocated on demand).

Did you try to check pthread_attr_setstacksize return value when calling it?

Please do not forget to cc the mailing list.

-- 
                                          Gilles


