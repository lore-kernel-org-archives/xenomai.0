Date: Mon, 3 Aug 2015 15:49:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150803134922.GG2538@hermes.click-hack.org>
References: <CAOLO654B2E5+oXt4X8pAoWEUmn+kCup60UQrx-WoyCHzqvhmOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLO654B2E5+oXt4X8pAoWEUmn+kCup60UQrx-WoyCHzqvhmOg@mail.gmail.com>
Subject: Re: [Xenomai] Compilation error because of macros __KERNEL__ or
 _XENO_SIM__
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ahmet =?utf-8?B?U295eWnEn2l0?= <ahmedius2@gmail.com>
Cc: xenomai@xenomai.org

On Mon, Aug 03, 2015 at 04:23:09PM +0300, Ahmet Soyyiğit wrote:
> Hello,
> 
> i am trying wrap posix skin of xenoai for C++. My problem is, some of the
> functions in prhread.h (xenomai posix skin)  are causing me compillation
> errors like this:
> 
> g++ -c -fpermissive -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
> -D__XENO__ -I/usr/xenomai/include/posix  ThreadXp.cpp
> ThreadXp.cpp: In constructor ‘ThreadXp::ThreadXp(int, size_t, int, int,
> int, char*, int)’:
> ThreadXp.cpp:47:53: error: ‘pthread_attr_setschedparam_ex’ was not declared
> in this scope
>   pthread_attr_setschedparam_ex (&d_attr, &schedParam);
>                                                      ^
> ThreadXp.cpp:48:40: error: ‘pthread_attr_setname_np’ was not declared in
> this scope
>   pthread_attr_setname_np(&d_attr, name );
>                                         ^
> ThreadXp.cpp:49:46: error: ‘pthread_attr_setfp_np’ was not declared in this
> scope
>   pthread_attr_setfp_np(&d_attr, floatingPoint);
>                                               ^
> ThreadXp.cpp: In static member function ‘static void*
> ThreadXp::threadEntry(void*)’:
> ThreadXp.cpp:198:17: warning: cast to pointer from integer of different
> size [-Wint-to-pointer-cast]
>   return((void *)code);
>                  ^
> make: *** [all] Error 1
> 
> but most of the pthread functions compile with no problem. I tried to
> compile with -v option and i am including the headers of xenomai posix
> skin. Inside pthread.h, the error giving functions are encapsulated like
> this:
> 
> #if defined(__KERNEL__) || defined(__XENO_SIM__)
> 
> ...
> 
> #else /* !(__KERNEL__ || __XENO_SIM__) */
> 
> but i my code doesnt define any of these macros. When I try to define them
> with -D option, or in file, anohter compilation errors came out.
> 
> Can u help me with that?

As is told in the documentation, these functions are only available
in kernel space. Fortunately, they can be replaced in user-space
with:
- nothing for pthread_attr_setfp_np, because FPU is automatically enabled
for all user-space tasks (only when really used with Xenomai 3.x)
- pthread_setname_np for pthread_attr_setname_np
- pthread_setschedparam_ex for pthread_attr_setschedparam_ex

-- 
					    Gilles.
https://click-hack.org

