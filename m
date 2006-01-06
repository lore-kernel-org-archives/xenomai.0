Message-ID: <43BEB938.7010906@domain.hid>
Date: Fri, 06 Jan 2006 19:38:48 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Oops, I broke something
References: <43BE5E3E.1060208@domain.hid>	<43BE626A.6000500@domain.hid>
	<17342.26740.324646.221814@domain.hid>
	<43BE771C.2090005@domain.hid> <43BEA273.5090808@domain.hid>
In-Reply-To: <43BEA273.5090808@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Gilles Chanteperdrix wrote:
>>
>>
>>>Philippe Gerum wrote:
>>> > Jan Kiszka wrote:
>>> > > But this raised the question to me again if we really need the
>>>"xenomai"
>>> > > prefix for all the skin headers /from within xenomai/. Why not
>>>doing the
>>> > > same linking dance for the other skins as well? Or do you also
>>>prefer
>>> > > that user include <xenomai/native/task.h> instead of just
>>><native/task.h>?
>>> >  > We need this for building from within the kernel. Other options
>>>would  > require to either alter the Xenomai source tree adding
>>>symlinks there,  > pollute linux/include with symlinks to reach the
>>>individual Xeno  > components, or refer to some external tree that
>>>eventually redirects to  > the Xenomai tree, which is not acceptable
>>>in any case.
>>>
>>>Maybe we could add EXTRA_CFLAGS=-I$(TOPDIR)/include/xenomai to every
>>>xenomai kernel makefile
>>
>>
>>Yes, I would preferably merge that instead of playing with symlinks.
>>
>> and to the cflags returned by xeno-config for
>>
>>
>>>kernel-space applications ?
>>>
>>
>>There no such support in xeno-config anymore. Kernel module flags and
>>dependencies now exclusively belong to the kernel build system;
>>xeno-config is only relevant for building user-space apps.
>>
> 
> 
> Actually, my concerns only targeted the userspace applications, more
> precisely those few being built inside the xeno tree. External user apps
> can still use the standard, non-prefixed headers. Thus my idea was to
> unify the includes for those in-tree applications so that users who are
> taking them as reference only see the standard way.

Ack, but this is a matter of general consistency. Now that the issue is 
raised and that we need to address it, it's better if we don't have to 
fiddle with exception cases uselessly, so using the proper include 
directives for both internal/external cases is the best way to go; 
provided it works, but it should.

> 
> External kernel applications and drivers can and should catch this
> prefix by adding <linuxsrc>/include/xenomai to their makefiles.
> 
> Jan


-- 

Philippe.

