Message-ID: <43F34B3F.6030103@domain.hid>
Date: Wed, 15 Feb 2006 16:39:43 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] atomic_t in userspace
References: <C01886AB.23C1%steve@domain.hid>
In-Reply-To: <C01886AB.23C1%steve@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Steven Seeger wrote:
> I just upgraded to the latest SVN after a few months of hiatus, and my
> userspace app that used atomic_t through nucleus/asm/atomic.h no longer
> works. It says it can't find atomic_t, and it seems that all the atomic
> operations have been put inside a kernel only #if. Is there another way to
> use atomics in my shadowed threads from userspace? Is there any equivalent?
> 

Atomic ops were formerly obtained by including linux/include/asm/atomic.h, and 
doing so from user-space context caused a number of troubles, notably to C++ 
users. Additionally, doing so was clearly bad practice since we would cause 
namespace pollution and all sort of conflicts with kernel-only symbols. For this 
reason, it has been decided to (re-)implement the very few atomic ops we need in 
the user-space section of xenomai/include/asm-*/atomic.h, instead of reading them 
from the kernel file(s). But since atomic counters are not needed (anymore) by 
Xenomai's user-space code, they have not been provided.

You should implement your local copy of the missing stuff, or directly include 
linux/include/asm/atomic.h from your own headers, but at your own risk.

> Steven
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

