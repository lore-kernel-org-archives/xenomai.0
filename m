Date: Wed, 17 Jan 2018 17:36:32 +0100
From: ruggero <rrossi@atb-biomag.de>
Message-ID: <20180117173632.38966ec3@laptop.fritz.box>
In-Reply-To: <98376b05-0ed2-3171-7d9d-a77d42782d9f@xenomai.org>
References: <b18a880f-9765-86e1-5274-ba8bfb0cc832@xenomai.org>
 <aa1018f6-a352-5814-7bf4-0a309d84a88a@ma-info.de>
 <20180117112452.1bb130c9@laptop.fritz.box>
 <98376b05-0ed2-3171-7d9d-a77d42782d9f@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel panic xnclock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Gaus Bernhard, Dr. Mergenthaler GmbH & Co. KG" <bernhard.gaus@ma-info.de>, xenomai@xenomai.org

Hallo Philippe,

> 
> With those explanations, it looks clearer now. Please apply this
> patch:
>   

Sorry, but after applying the patch I get a kernel compilation error.
The error is:
ERROR: "__ipipe_smp_key" [drivers/mergenthaler/clc/clc-clock.ko]
undefined! scripts/Makefile.modpost:90: recipe for target '__modpost'
failed

symbol __ipipe_smp_key is used in both the two routines 
xnlock_get_irqsave(&nklock, s);
and
xnlock_put_irqrestore(&nklock, s);

and it looks like it is defined in the kernel:
grep -r ipipe_smp_key * | grep -v patch | grep -v \.o
arch/arm/kernel/ipipe.c:
struct static_key __ipipe_smp_key = STATIC_KEY_INIT_TRUE; 
arch/arm/include/asm/ipipe.h:
extern struct static_key __ipipe_smp_key; 
arch/arm/include/asm/ipipe.h:
#define ipipe_smp_p (static_key_true(&__ipipe_smp_key)) 
System.map:806fad48 D __ipipe_smp_key 
Binary file vmlinux matches

any suggestion?

Thanks in advance, 

Ruggero

