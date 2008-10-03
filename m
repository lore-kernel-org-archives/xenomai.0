Message-ID: <48E5EBCA.4020702@domain.hid>
Date: Fri, 03 Oct 2008 11:54:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48E5EB4D.4040401@domain.hid>
In-Reply-To: <48E5EB4D.4040401@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] CONFIG_XENO_OPT_SYS_STACKPOOLSZ warning
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Laurent BESSARD <laurent.bessard@domain.hid>
Cc: xenomai@xenomai.org

Laurent BESSARD wrote:
> Hello all,
> 
> Recently, I tried to compile a driver for Xenomai and I received this 
> warning while trying to include rtdm_driver.h:
> In file included from /usr/xenomai/include/nucleus/xenomai.h:25,
>                  from /usr/xenomai/include/rtdm/rtdm_driver.h:37
> /usr/xenomai/include/nucleus/heap.h:110:5: warning: 
> "CONFIG_XENO_OPT_SYS_STACKPOOLSZ" is not defined
> 
> This symbol is provided by kernel config while compiling kernel, but 
> doesn't exist in any other context.
> 
> It would solve the problem if heap.h test if this symbol exist before 
> trying to use it, or define a default value for this symbol like:
> 
> #ifndef CONFIG_XENO_OPT_SYS_STACKPOOLSZ
> #define CONFIG_XENO_OPT_SYS_STACKPOOLSZ 0
> #endif

If you do not use the Linux kernel makefiles to compile your driver,
then it is your driver that is broken and needs fixing.

-- 
                                                 Gilles.

