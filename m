Message-ID: <522337CF.2010402@xenomai.org>
Date: Sun, 01 Sep 2013 14:49:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52232BE0.6050400@laposte.net>
In-Reply-To: <52232BE0.6050400@laposte.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai]
 =?utf-8?b?RXJyb3IgImZpZWxkIOKAmHBzZTUxX3Np4oCZIGhhcyBp?=
 =?utf-8?q?ncomplete_type=22_in_syscall=2Eh_after_upgrading_Ubuntu_Distrib?=
 =?utf-8?q?_to_13=2E04?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marc Le Douarain <marc.le-douarain@laposte.net>
Cc: Xenomai <xenomai@xenomai.org>

On 09/01/2013 01:58 PM, Marc Le Douarain wrote:
> Hello everybody,
> 
> I have an application using Xenomai that do no more compile after I have 
> recently upgraded from Ubuntu 12.10 to 13.04
> 
> Here the error I have in one one file including "phread.h" :
> gcc -c tasks.c -o tasks.o -march=i486 ...(custom defines)... 
> `xeno-config --skin posix --cflags`
> In file included from /usr/xenomai/include/asm/xenomai/syscall.h:23:0,
>                   from /usr/xenomai/include/nucleus/trace.h:52,
>                   from /usr/xenomai/include/nucleus/system.h:27,
>                   from /usr/xenomai/include/asm/xenomai/system_32.h:137,
>                   from /usr/xenomai/include/asm/xenomai/system.h:2,
>                   from /usr/xenomai/include/nucleus/types.h:41,
>                   from /usr/xenomai/include/nucleus/thread.h:25,
>                   from /usr/xenomai/include/posix/pthread.h:136,
>                   from tasks.c:34:
> /usr/xenomai/include/asm-generic/xenomai/syscall.h:78:17: erreur: field 
> ‘pse51_si’ has incomplete type
> make: *** [tasks.o] Erreur 1
> 
> gcc installed on this version is 4.7.3
> My project based on Linux kernel 2.6.38.8 and Xenomai 2.5.6
> 
> any one have an idea, on something that could be done...?
> else I'm thinking to install an older version in virtual machine to no 
> more encounter bad surprises with upgrades !

You are probably lacking a #include, add the missing include and it
should be fine. Also, Xenomai 2.5.6 and Linux 2.6.38 are really old,
updating is recommended.


-- 
                                                                Gilles.

