Message-ID: <001801c9a734$e0c7ac90$0109220a@domain.hid>
From: "Henry Bausley" <hbausley@domain.hid>
References: <004301c9a683$c6b00200$0109220a@domain.hid>	<004801c9a69a$4a63aaf0$0109220a@domain.hid>
	<49BFBF48.7080102@domain.hid> <49BFCAEB.8080007@domain.hid>
Date: Tue, 17 Mar 2009 12:16:30 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ENXIO error with large shared memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

The patch makes it work for 32M.  However if I try to go larger ie.48M or 
64M I get the following


  Program buffer: 67108864
     User buffer: 1048576
    Table buffer: 1048576
LookAhead buffer: 16777216
RT User Program ftruncate No Error
------------[ cut here ]------------
Badness at c00b6a94 [verbose debug info unavailable]
NIP: c00b6a94 LR: c00b7064 CTR: 00000000
REGS: ef1edbe0 TRAP: 0700   Not tainted  (2.6.26.8)
MSR: 00029000 <EE,ME>  CR: 48008248  XER: 00000007
TASK = ef8f75a0[2143] 'insmod' THREAD: ef1ec000
GPR00: 00000001 ef1edc90 ef8f75a0 ef1716c0 0000033b ef1edcc8 c1727978 
ffffffff
GPR08: ef817800 00000000 c1726be0 ef034a54 88008284 100197d8 f4fc0000 
f4fc0cf0
GPR16: f4fc0d2c ef9a106c c040b228 f4fc0000 ef1edd30 00101420 ffc00ffd 
c03f0000
GPR24: 0000033b ef1716c0 ff16cfff c03cafe0 ff16d000 ef1edcc8 ff16d000 
ff100000
NIP [c00b6a94] map_vm_area+0xb0/0x174
LR [c00b7064] __vmalloc_area_node+0xd8/0x164
Call Trace:
[ef1edc90] [00101420] 0x101420 (unreliable)
[ef1edcc0] [c00b7064] __vmalloc_area_node+0xd8/0x164
[ef1edcf0] [c0051ff8] xnheap_init_mapped+0x13c/0x4a8
[ef1edd20] [c0094324] ftruncate+0x3a0/0x528
[ef1edd80] [f4fa2c5c] init_module+0x374/0x91c [rtpmac]
[ef1ede70] [c00476ec] sys_init_module+0x134/0x1784
[ef1edf40] [c000e06c] ret_from_syscall+0x0/0x3c
Instruction dump:
418200cc 57e0bd38 7d090215 41820098 817d0000 81480004 39200000 7d205379
814b0000 38000000 41820008 38000001 <0f000000> 2f8a0000 3bff1000 7f1ef800
------------[ cut here ]------------

----- Original Message ----- 
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
To: "Henry Bausley" <hbausley@domain.hid>
Cc: <xenomai@xenomai.org>
Sent: Tuesday, March 17, 2009 9:08 AM
Subject: Re: [Xenomai-help] ENXIO error with large shared memory


> Gilles Chanteperdrix wrote:
>> Henry Bausley wrote:
>>> ftruncate returns 0
>>
>> Ok. I think I understood what the problem is, I will try to send a patch
>> tonight.
>>
>
> The following not very subtil patch seems to fix the issue:
>
> Index: include/nucleus/heap.h
> ===================================================================
> --- include/nucleus/heap.h      (revision 4692)
> +++ include/nucleus/heap.h      (working copy)
> @@ -156,6 +156,7 @@
>
> static inline size_t xnheap_rounded_size(size_t hsize, size_t psize)
> {
> +       size_t rounded_size;
>        /*
>         * Account for the minimum heap size (i.e. 2 * page size) plus
>         * overhead so that the actual heap space is large enough to
> @@ -167,7 +168,10 @@
>        if (hsize < 2 * psize)
>                hsize = 2 * psize;
>        hsize += xnheap_overhead(hsize, psize);
> -       return xnheap_align(hsize, psize);
> +       rounded_size = xnheap_align(hsize, psize);
> +       while (rounded_size - xnheap_overhead(rounded_size, psize) < 
> hsize)
> +               rounded_size += psize;
> +       return rounded_size;
> }
>
> #ifdef __cplusplus
>
>
> -- 
>                                                 Gilles. 



**********************************************************
Outbound scan for Spam or Virus by Barracuda at Delta Tau
**********************************************************

