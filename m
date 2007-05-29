From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200705291240.31970.paul_c@domain.hid>
References: <200705291240.31970.paul_c@domain.hid>
Content-Type: text/plain
Date: Tue, 29 May 2007 19:27:13 +0200
Message-Id: <1180459633.29542.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] printk docbook patch
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Tue, 2007-05-29 at 12:40 +0100, Paul wrote:
> Whilst generating some documentation with the mandocs target, I hit an error:
> 
> Error(/tmp/linux-2.6.20//kernel/printk.c:504): cannot understand 
> prototype: 'ipipe_spinlock_t __ipipe_printk_lock = 
> IPIPE_SPIN_LOCK_UNLOCKED; '
> make[1]: *** [Documentation/DocBook/kernel-api.xml] Error 1
> make: *** [mandocs] Error 2
> 
> 
> It would appear that the __ipipe_* stuff between the printk function body and 
> it's corresponding documentation upsets docbook. The attached patch proposes 
> one fix for this problem (looks like it affects all arches).

Merged, thanks.

> 
> 
> Regards, Paul.
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



