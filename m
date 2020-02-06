Subject: Re: Xenomai 3.1 x86: Duplicate definition of
 arch_io_reserve_memtype_wc() and arch_io_free_memtype_wc() when
 CONFIG_X86_PAT is disabled
References: <CAEkURaYmxbe5xr+ZEQH_hK7-uUcYPyPOyAjoAbG0Ugt64=aJ4Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <228b3432-46af-0d07-cc2f-75aa2347b55c@siemens.com>
Date: Thu, 6 Feb 2020 15:39:26 +0100
MIME-Version: 1.0
In-Reply-To: <CAEkURaYmxbe5xr+ZEQH_hK7-uUcYPyPOyAjoAbG0Ugt64=aJ4Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Yuri Zaporozhets <yuri.zaporozhets@gmail.com>, xenomai@xenomai.org

On 06.02.20 11:44, Yuri Zaporozhets via Xenomai wrote:
> Hello all,
> 
> Compilation of Linux kernel 4.19.94 with Xenomai-3.1 for x86_64 (with
> the latest i-pipe CIP patch for 4.19) cannot be successfully done
> because of two functions mentioned in Subject are doubly-defined.
> 
> ipipe.h includes irq.h which in turn includes "include/linux/io.h",
> where these two functions are defined as stubs. But pat.c also defines
> them, and they are not stubs.
> 
> A quick solution would be to surround these two functions in pat.c
> with #ifdef CONFIG_X86_PAT.
> 
> This problem is not present in Xenomai-3.0.10.

You likely meant 4.14 or older kernels. It's unrelated to Xenomai,
purely an I-pipe + kernel version thing.

> 
> Full inclusion list:
> 
> In file included from ./include/linux/irq.h:20:0,
>                  from ./include/linux/ipipe.h:29,
>                  from ./arch/x86/include/asm/uaccess.h:10,
>                  from ./include/linux/uaccess.h:14,
>                  from ./include/linux/compat.h:19,
>                  from ./arch/x86/include/asm/mtrr.h:99,
>                  from arch/x86/mm/pat.c:28:
> ./include/linux/io.h:177:19: note: previous definition of
> ‘arch_io_reserve_memtype_wc’ was here:
>  static inline int arch_io_reserve_memtype_wc(...)
> 

This looks more and more like an upstream issue that I-pipe happened to
surfaced. I'll write a patch to #ifdef the duplicate functions out in
case X86_PAT is off (which it should not be, in 99.9% of practical
cases), suggest that upstream and put it into our 4.19 kernel as well.

Thanks for reporting,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

