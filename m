Message-ID: <4D38886F.7060802@domain.hid>
Date: Thu, 20 Jan 2011 20:09:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
	<alpine.DEB.1.10.1101200922440.1211@domain.hid>
	<4D384CC9.2040303@domain.hid>
	<alpine.DEB.1.10.1101201702340.1990@domain.hid>
	<4D386922.5080807@domain.hid>
	<alpine.DEB.1.10.1101201811090.1990@domain.hid>
	<4D387148.3030306@domain.hid>
	<alpine.DEB.2.00.1101201943440.2425@domain.hid>
In-Reply-To: <alpine.DEB.2.00.1101201943440.2425@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

Waschk,Kolja wrote:
> Hi,
> 
>> reference, and the program is bogus in the way it handles
>> pthread_cond_wait errors, as I already explained,
> 
> You're certainly right with that. It's just that I have to deal with foreign
> code that contains exactly such tight loops with pthread_cond_wait as its
> only brake, and this code I'd like to use unmodified, as far as possible. Now
> the test code try.c started as a clone of the original, so it has the same
> obvious shortcomings.
> 
>> missing a call to mlockall without which it can not possibly run under
>> Xenomai.
> 
> Oh, you're right (but it's present in the original code)

Ok. mlockall may not be needed on uclinux after all.

> 
>> program, since you should be using #include <pthread.h>, instead of
>> #include <posix/pthread.h>, and more importantly, this program is
> 
> Yes. That's an artefact of another problem which seems more toolchain-related
> in my case. Already noted in our issue tracking system. However, I tried to
> verify that everything is wrapped and linked as supposed;

As reminder, the correct way to compile a xenomai posix skin program is
described here:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_flags.

> 
>> So, to settle the matters, could you post here the result of
>> "bfin-linux-uclibc-nm -s try".
>> ?
> 
> The result is
> 
> 00002158 A ___bss_start
> 00002158 b _completed.4861
> 000021ac B _cond
> 00001f78 d ___CTOR_END__
> 00001f74 d ___CTOR_LIST__
>           w ___deregister_frame_info@domain.hid
> 00000e5c t ___do_global_ctors_aux
> 00000a58 t ___do_global_dtors_aux
> 00002068 D ___dso_handle
> 00000ea0 R _dt
> 00001f80 d ___DTOR_END__
> 0000215c b _dtor_idx.4863
> 00001f7c d ___DTOR_LIST__
> 00001f88 d _DYNAMIC
> 00002158 A __edata
> 00000f70 r ___EH_FRAME_BEGIN__
> 000021b8 A __end
> 00002184 B _errbits
>           U ___errno_location
> 00000e8c T __fini
> 00000ac4 t _frame_dummy
> 00000f70 r ___FRAME_END__
> 000020e0 d __GLOBAL_OFFSET_TABLE_
> 00000780 T __init
> 00001f84 d ___JCR_END__
> 00001f84 d ___JCR_LIST__
>           w __Jv_RegisterClasses
> 00002178 B _loopcount
> 00000c7c T _main
> 00002190 B _mutex
> 00002160 b _object.4883
>           U _printf
> 00000b0c W _pthread_atfork
>           U _pthread_attr_init
>           U _pthread_join
>           w ___register_frame_info@domain.hid
> 00000f70 R __ROFIXUP_END__
> 00000f1c R __ROFIXUP_LIST__
> 000021a8 B _run
> 000008ec t ___self_reloc
> 00000b20 W _shm_open
> 00000b3c W _shm_unlink
>           U _sleep
> 00020000 A __stacksize
> 00000888 T __start
> 00000b54 T _test_thread
>           U ___uClibc_main
>           U ___wrap_pthread_cond_broadcast
>           U ___wrap_pthread_cond_init
>           U ___wrap_pthread_cond_wait
>           U ___wrap_pthread_create
>           U ___wrap_pthread_mutex_init
>           U ___wrap_pthread_mutex_lock
>           U ___wrap_pthread_mutex_unlock
>           U ___wrap_pthread_yield
> 
> 

you sure this is the "try" program for which you sent the sources? I do
not understand the references to shm_open, shm_unlink, for instance.


-- 
                                                                Gilles.

