Message-ID: <48CE6E48.6030808@domain.hid>
Date: Mon, 15 Sep 2008 16:16:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48CE3096.7040502@domain.hid>
In-Reply-To: <48CE3096.7040502@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] probably error in api document
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Harco Kuppens <h.kuppens@domain.hid>
Cc: xenomai@xenomai.org, "hooman >> \"Hooman, J.\"" <Jozef.Hooman@domain.hid>

Harco Kuppens wrote:
> Hi,
> 
> I noticed in the Xenomai native API that  the longer rt_create_intr :
> 
>     int rt_intr_create 
> <http://www.xenomai.org/documentation/trunk/html/api/group__interrupt.html#ga0a9d98556ec838008f408a56e79d304> 
> (RT_INTR *intr, const char *name, unsigned irq, rt_isr_t isr, rt_iack_t 
> iack, int mode)
> 
> says in its documentation :
> 
>     This service can be called from:
> 
>         * Kernel module initialization/cleanup code
>         * Kernel-based task
>         * *User-space task*
> 
> I find it strange that it could be called from a user-space task.
> I looked in /usr/xenomai/include/native/intr.h but there it really is 
> defined when __KERNEL__ is defined.
> 
> So I guess this is an error in the  API documention?

No, there is no error: the service is implemented both in user-space and
 kernel-space, and if you look at native/intr.h, you will see two
definitions of rt_intr_create: one for kernel-space and one for user-space.

Note however that the interface in user-space is not the same as in
kernel-space, that is because in user-space, you are supposed to call
rt_intr_wait to wait for the next interrupt.

-- 
                                                 Gilles.

