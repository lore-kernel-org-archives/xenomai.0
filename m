MIME-Version: 1.0
From: Yuri Zaporozhets <yuri.zaporozhets@gmail.com>
Date: Thu, 6 Feb 2020 11:44:13 +0100
Message-ID: <CAEkURaYmxbe5xr+ZEQH_hK7-uUcYPyPOyAjoAbG0Ugt64=aJ4Q@mail.gmail.com>
Subject: Xenomai 3.1 x86: Duplicate definition of arch_io_reserve_memtype_wc()
 and arch_io_free_memtype_wc() when CONFIG_X86_PAT is disabled
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello all,

Compilation of Linux kernel 4.19.94 with Xenomai-3.1 for x86_64 (with
the latest i-pipe CIP patch for 4.19) cannot be successfully done
because of two functions mentioned in Subject are doubly-defined.

ipipe.h includes irq.h which in turn includes "include/linux/io.h",
where these two functions are defined as stubs. But pat.c also defines
them, and they are not stubs.

A quick solution would be to surround these two functions in pat.c
with #ifdef CONFIG_X86_PAT.

This problem is not present in Xenomai-3.0.10.

Full inclusion list:

In file included from ./include/linux/irq.h:20:0,
                 from ./include/linux/ipipe.h:29,
                 from ./arch/x86/include/asm/uaccess.h:10,
                 from ./include/linux/uaccess.h:14,
                 from ./include/linux/compat.h:19,
                 from ./arch/x86/include/asm/mtrr.h:99,
                 from arch/x86/mm/pat.c:28:
./include/linux/io.h:177:19: note: previous definition of
=E2=80=98arch_io_reserve_memtype_wc=E2=80=99 was here:
 static inline int arch_io_reserve_memtype_wc(...)

--
Regards,
Yuri

