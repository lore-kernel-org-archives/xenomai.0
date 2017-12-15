MIME-Version: 1.0
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Fri, 15 Dec 2017 09:21:59 +0000
Message-ID: <CAKJ14NfNCoGWq0i_vDY5ORKcKWGR_jWABPU-MFO0yb-FpTKRvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] mode switch caused by __lll_lock_wait_private()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

>>
>> We're testing our application now by running it continuously over
>> weeks. I randomly reports the following mode switches in the log:
>>
>> <SIGXCPU: MSW(invoked syscall) BT(4): 0x2ade5bc8 0x2af95840
>> 0x2b03a420 0x93980 >
>>
>> With the process memory map from /proc/<pid>/maps:
>>
>> ...
>> 2af68000-2b084000 r-xp 00000000 00:0d 22235 /lib/libc-2.14.1.so
>> ...
>>
>> and output from <cross-arm>-objdump -d /lib/libc-2.14.1.so
>>
>> I could figure out that 0x2b03a420 corresponds to glibc's
>> __lll_lock_wait_private() function, which seems to cause SIGXCPU.
>
> I guess translating the other 3 ips to symbols would be helpfull as
> well ;).

After using the unstripped debug libc binary we got the following
stack trace from which it's fairly clear that our third party code is
using the C++ standard list allocator. So need to change that to our
C++ allocator that uses RT_HEAP....

<snip>
Program received signal SIGXCPU, CPU time limit exceeded.
0x2b03b420 in __lll_lock_wait_private (futex=0x2c700010)
    at ../nptl/sysdeps/unix/sysv/linux/lowlevellock.c:34
34      ../nptl/sysdeps/unix/sysv/linux/lowlevellock.c: No such file
or directory.
        in ../nptl/sysdeps/unix/sysv/linux/lowlevellock.c
(gdb) bt
#0  0x2b03b420 in __lll_lock_wait_private (futex=0x2c700010)
    at ../nptl/sysdeps/unix/sysv/linux/lowlevellock.c:34
#1  0x2afd7174 in __libc_free (mem=<value optimized out>) at malloc.c:3736
#2  0x2adab5d8 in deallocate (this=0x0)
    at /opt/OSELAS.Toolchain-2011.11.3/arm-cortexa9-linux-gnueabi/gcc-4.6.2-glibc-2.14.1-binutils-2.21.1a-kernel-2.6.39-sanitized/lib/gcc/arm-cortexa9-linux-gnueabi/4.6.2/../../../../arm-cortexa9-linux-gnueabi/include/c++/4.6.2/ext/new_allocator.h:98
#3  _M_put_node (this=0x0)
    at /opt/OSELAS.Toolchain-2011.11.3/arm-cortexa9-linux-gnueabi/gcc-4.6.2-glibc-2.14.1-binutils-2.21.1a-kernel-2.6.39-sanitized/lib/gcc/arm-cortexa9-linux-gnueabi/4.6.2/../../../../arm-cortexa9-linux-gnueabi/include/c++/4.6.2/bits/stl_list.h:331
#4  _M_erase (this=0x0)
    at /opt/OSELAS.Toolchain-2011.11.3/arm-cortexa9-linux-gnueabi/gcc-4.6.2-glibc-2.14.1-binutils-2.21.1a-kernel-2.6.39-sanitized/lib/gcc/arm-cortexa9-linux-gnueabi/4.6.2/../../../../arm-cortexa9-linux-gnueabi/include/c++/4.6.2/bits/stl_list.h:1539
#5  pop_front (this=0x0)
    at /opt/OSELAS.Toolchain-2011.11.3/arm-cortexa9-linux-gnueabi/gcc-4.6.2-glibc-2.14.1-binutils-2.21.1a-kernel-2.6.39-sanitized/lib/gcc/arm-cortexa9-linux-gnueabi/4.6.2/../../../../arm-cortexa9-linux-gnueabi/include/c++/4.6.2/bits/stl_list.h:974
---Type <return> to continue, or q <return> to quit---
#6  RemoveHead (this=0x0) at ./src/stack/850870/tools/../oem/listdef.h:388
#7  RemoveHead (this=0x0) at ./src/stack/850870/tools/listbase.h:58
</snip>


PS: With our setup, ptxdist 2011.11.0 and OSELAS.Toolchain-2011.11.3,
we ran into the same problem as reported elsewhere [1] when trying to
get a stack trace with the stripped libc binaries... our solution to
circumvent this issue was to use the unstripped debug binaries.


[1] https://sourceware.org/ml/libc-help/2015-06/msg00017.html

