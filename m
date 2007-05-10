Message-ID: <4642E706.7000500@domain.hid>
Date: Thu, 10 May 2007 11:33:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1072004B0EE21141A9DEBA9785A77F14658A70@domain.hid>	
	<4641CD8B.8050309@domain.hid>	
	<7289437c0705090643gc9f0ddax6fa6cff44895c9ed@domain.hid>	
	<7289437c0705090735n58b4a0fbm7e31c8571efb7514@domain.hid>	
	<17986.12574.488256.997900@domain.hid>	
	<17986.15326.243315.427529@domain.hid>	
	<1178748178.11688.45.camel@domain.hid>	
	<17986.20728.617772.991566@domain.hid>	
	<1178784303.11688.108.camel@domain.hid> <4642D901.9050304@domain.hid>
	<1178789171.11688.142.camel@domain.hid>
In-Reply-To: <1178789171.11688.142.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with pthread_setschedparam
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Thu, 2007-05-10 at 10:34 +0200, Gilles Chanteperdrix wrote:
> 
>>>> > 
>>>> > Ok, I could reproduce the problem. The issue is most likely an access to
>>>> > the thread memory after it has been freed which breaks the allocator
>>>> > linked list of free pages by replacing a link to a next free page by a
>>>> > NULL pointer. xnheap_alloc interprets this NULL pointer as the end of the
>>>> > linked list and hence considers that it is out of memory.
>>>>
>>>>And the winner is... RPI! The offset of the thread structure member that
>>>>is set to NULL is the one of the rpi pointer. Disabling RPI makes the
>>>>problem vanish.
>>>>
>>>>Philippe, when is this pointer set to NULL ?
>>>>
>>>
>>>When the thread leaves secondary mode or exits, which in turn removes it
>>>from the queue the nucleus considers for priority boosting the root
>>>thread. Check rpi_none().
>>
>>Conclusion: the problem is the one Andrew spotted, there are two
>>hooks and the shadow hook (which calls xnshadow_unmap, which in turn
>>calls rpi_pop, which sets the rpi pointer to null) gets called after the
>>other thread deletion hook which initially called xnfree, and now calls
>>xnfreesafe.
>>
>>But it seems that even xnfreesafe is not safe enough, and it frees the
>>thread pointer immediately whereas we would like the operation to be
>>deferred.
>>
> 
> 
> xnfreesafe was meant to prevent the caller from releasing some memory it
> could still rely on, e.g. stack space, by postponing the actual release
> until the idle thread is resumed. In your case, the problem is that it
> does not account for the primary/secondary mode of a shadow thread.

I am not so sure. I mean, even if the thread was deleted from the
context of another thread, the two hooks would be invoked and we would
need the free operation to be deferred until after the execution of the
second hook.

-- 
                                                 Gilles Chanteperdrix

