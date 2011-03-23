Message-ID: <4D89A8EC.1070702@domain.hid>
Date: Wed, 23 Mar 2011 09:01:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimFAxy81d7NErKOT0S4esN20DtQbUu4d42K4_8s@domain.hid>
In-Reply-To: <AANLkTimFAxy81d7NErKOT0S4esN20DtQbUu4d42K4_8s@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Help: What is this in xenomai? rtheap crash?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: alamo hwuang <lovealamo@domain.hid>
Cc: xenomai@xenomai.org

alamo hwuang wrote:
> Hello , I am a new bird using the xemomai! I use my classmate program to run
> on the xenomai and I got the below information .It seems that the rtheap
> crash ??

Nope, this does not seem to have anything to do with rtheap.

> 
> 
> How can I solve this problem ????
> 
> the xenomai is 2.5.4 and the kernel is 2.6.34.5.

Please upgrade to Xenomai 2.5.6 (though the problem is not related).

> 
> 
> 
> 
> 
> thanks for your help.
> 
> linux-xkps1:~/Desktop/linux # Bin/APP_LTE_DEMO config.txt
> Noise Generated
> *** glibc detected *** Bin/APP_LTE_DEMO: malloc(): memory corruption:
> 0x00000000176fbba0 ***

This is the real error message, the heap (malloc heap, not rtheap) is
corrupted.

> ======= Backtrace: =========
> /lib64/libc.so.6(+0x75018)[0x7f6ae8eb6018]
> /lib64/libc.so.6(+0x77f7f)[0x7f6ae8eb8f7f]
> /lib64/libc.so.6(__libc_malloc+0x77)[0x7f6ae8ebb057]
> Bin/APP_LTE_DEMO[0x41f284]
> /usr/xenomai/lib/libnative.so.3(+0x728c)[0x7f6ae961328c]
> /lib64/libpthread.so.0(+0x75f0)[0x7f6ae981e5f0]
> /lib64/libc.so.6(clone+0x6d)[0x7f6ae8f1584d]

This backtrace shows that the error is detected by glibc malloc.

> ======= Memory map: ========
> (...)
> 7f6aea15a000-7f6aea15d000 rw-s 00000000 00:0e 2199
> /dev/rtheapAborted

This is a list of the mapped areas which show that the rtheap is mapped,
which is normal, but the rtheap has nothing to do with the normal heap
corruption.

Heap corruption is a sign that something misbehaves, and write on memory
that is not currently allocated, or some block was freed twice, things
like that. The most probable culprit is the application itself and it is
what should be investigated first.

Same remark as previous mail: you should use xenomai-help for such
questions, not xenomai-core.

-- 
                                                                Gilles.

