Message-ID: <4F171C09.8010908@domain.hid>
Date: Wed, 18 Jan 2012 20:22:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <28CCC3D1EEE841E184D8E5663EBDCCBE@TerryHP>
In-Reply-To: <28CCC3D1EEE841E184D8E5663EBDCCBE@TerryHP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Compile error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Terry Fryar <terry.fryar@domain.hid>
Cc: xenomai@xenomai.org

On 01/18/2012 04:12 PM, Terry Fryar wrote:
> Using xenomai 2.6.0 with 2.6.38 kernel.  Turned off
> CONFIG_XENO_OPT_PERVASIVE, and now I can't compile kernel:
>  
> CC      kernel/xenomai/nucleus/synch.o
> kernel/xenomai/nucleus/synch.c: In function 'xnsynch_release_thread':
> kernel/xenomai/nucleus/synch.c:688:3: error: implicit declaration of
> function 'xnthread_get_rescnt'
> kernel/xenomai/nucleus/synch.c:689:4: error: implicit declaration of
> function 'xnshadow_send_sig'
> 
> There are some ifdef's for this flag....how to compile xenomai kernel
> without pervasive user support?  Only using kernel modules with xenomai at
> this point, and I'm trying to optimize the kernel performance....

I am afraid nobody has tried compiling without pervasive support for a
long time. Anyway, you will not gain enough that way: you will not
reduce the interrupt latency from 20us to 500ns. As I said, you can not
have a 500ns latency on any processor where xenomai is available.

-- 
                                                                Gilles.

