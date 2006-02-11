Message-ID: <43ED3165.3090300@domain.hid>
Date: Sat, 11 Feb 2006 01:35:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] provide rtdm_mmap_to_user / rtdm_munmap
References: <43EBD9D6.5090404@domain.hid>
	<43EBE032.40302@domain.hid>	<200602101858.21108.lbocseg@domain.hid>
	<200602101928.52899.lbocseg@domain.hid>
In-Reply-To: <200602101928.52899.lbocseg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

Rodrigo Rosenfeld Rosas wrote:
> Hi Jan, it just happened once and I couldn't reproduce (I didn't want to 
> reproduce it too since I would need to restart my computer because the driver 
> wouldn't unload)...
> 
> When it happened I forgot to start the timer running the latency program and 

Already running latest SVN version? rt_timer_start&friends became
deprecated last weekend, so you can't forget this step anymore.

> my driver failed to load and due to some mistake I've made (I have not 
> indentified it yet), it crashed on rmmoding. I need to check this, but I 
> still think it is a good idea to make the sanity checks...

We need some XENO_ASSERT that is only active when CONFIG_XENO_OPT_DEBUG
is set. I don't want to put such checks in production code, but I see
that they may help debugging early drivers.

> 
> I have not written the user-space program yet, so you'll have to wait until 
> monday, when I'll be able to test it, hopefully. But it seems to be 
> working... I changed my driver design. I do the mmap's on driver 
> initialization and just pass the returned addresses on the IOCTL, so I can do 
> them in a RT-context. The problem is that even if the user call an IOCTL to 

Hmm, I guess there is still some lacking documentation about what is
possible with RTDM. If you call an IOCTL from RT context, you end up in
the _rt-handler the driver of a device may have registered (if there is
no _rt-handler at all, the _nrt one is invoked, but this is likely not
relevant here).

I assume that you were wondering how to call rtdm_mmap_to_user from this
real-time handler, right? Well, the trick is to return -ENOSYS for those
IOCTL codes that can only be handled by the _nrt-handler. Xenomai will
then switch your RT task to secondary mode, restart the IOCTL, and the
mmap can safely be executed.

Well, maybe you do not have any arguments for rtdm_mmap_to_user that
should be influenced by the user's IOCTL. In this case your current
driver design is ok as well. I just wanted to underline that it is not
necessarily the only way.

> munmap, it will still be possible to him to continue using the provided 
> address and this would result in a problem. But, as in all situations, there 

When rtdm_munmap is executed, the virtual address range becomes invalid
for the user. Thus any further access to it will raise a segfault.
That's the only problem, but it will not influence the driver integrity.

> are trade-offs and I prefer to rely on the user, while providing a 
> RT-MMAP-IOCTL. Of course it isn't really a mmap, but if the user don't mess 
> with the pointers, it will work like if it was...

The user can only access the window you mapped in and only as long as it
is mapped. And if you map it read-only, there is even no chance to
destroy potential management structures of the hardware or the driver
within this range.

> 
> Hope you understood me, I wrote it a little confusing... :)

We will see...

> 
> Until monday! ;)
> 
> Rodrigo.
> 

Happy WE,
Jan

