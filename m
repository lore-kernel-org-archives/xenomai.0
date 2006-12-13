From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4580307C.3040401@domain.hid>
References: <45802F00.1090008@domain.hid>  <4580307C.3040401@domain.hid>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 18:28:08 +0100
Message-Id: <1166030889.5360.175.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Re: [PATCH] 2.6.19: Fix irq_disable in early
	start_kernel
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Wed, 2006-12-13 at 17:55 +0100, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > Hi Philippe,
> > 
> > this was a nice bug: After applying some totally unrelated cleanup patch
> > that removes a few useless EXPORT_SYMBOLS from ipipe, I got this during
> > boot:
> > 
> > ...
> > Xenomai: hal/x86 started.
> > BUG: unable to handle kernel NULL pointer dereference at virtual address
> > 000000f1
> > ...
> > EIP is at kref_get+0x9/0x43
> > ...
> > Call Trace:
> >  [<c020e077>] kobject_get+0x12/0x17
> >  [<c01c28ae>] sysfs_create_link+0xda/0x140
> >  [<c02412bb>] class_device_add+0x217/0x3dc
> >  [<c0241492>] class_device_register+0x12/0x15
> >  [<c0241519>] class_device_create+0x84/0xa5
> >  [<c022fe47>] misc_register+0x109/0x140
> >  [<c0142748>] xnheap_mount+0x9a/0xa2
> >  [<c03fad0c>] __xeno_sys_init+0xd9/0x15d
> >  [<c01004d0>] init+0x127/0x2dc
> >  [<c0103e97>] kernel_thread_helper+0x7/0x10
> > 
> > The reason: xnheap_dev.dev=1!? But that field is located untouched in a
> > static structure, i.e. *must* be 0! Interrupting the kernel shortly
> > after boot already returned it as 1. Finally, after breaking at the
> > beginning of start_kernel, I got the expected 0 and then quickly found
> > the messed-up piece of code a few lines below.
> > 
> > Please apply attached patch, I suspect it is a typo (ipipe isn't
> > initialised at this point to handle such requests, so the stall bit
> > ended up in xnheap_dev for me - who knows what can happen on other
> > setups...).
> > 

Gasp. Fixed, thanks.

-- 
Philippe.



