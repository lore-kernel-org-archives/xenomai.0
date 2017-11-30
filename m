References: <61813822-bfb7-e2ec-bce2-85a508eab0a5@alaxarxa.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <49014e60-4b55-ed4e-a8c1-576231633c50@xenomai.org>
Date: Thu, 30 Nov 2017 14:31:09 +0100
MIME-Version: 1.0
In-Reply-To: <61813822-bfb7-e2ec-bce2-85a508eab0a5@alaxarxa.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno-config options to build Xenomai applications
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, Xenomai List <xenomai@xenomai.org>

On 11/30/2017 01:32 PM, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> I think that this question has been answered partially in the list, but I would
> like to ask it with more detail to clarify and maybe rewrite for the documentation.
> 
> I'm asking for applications in the user space, no kernel space. And cobalt core.
> Are these options correct?
> 
> 1) Simple (C/C++) POSIX application with some threads. We want to use the POSIX
> functions as RT functions when possible.
> 
> To compile: xeno-config --posix --cflags
> To link: xeno-config --posix --ldflags --auto-init

Correct (also: --auto-init is assumed by default).

> 
> 2) C/C++ POSIX shared library with some threads. We want to use the POSIX
> functions as RT functions when possible.
> 
> To compile: xeno-config --posix --cflags
> To link: xeno-config --posix --ldflags --auto-init -auto-init-solib
> 

--auto-init is for pure execs, which is mutually exclusive with
--auto-init-solib which is for DSOs.

xeno-config --posix --ldflags [--auto-init-solib]

One needs --auto-init-solib to have the application attach to the Cobalt
core (for gaining rt services) when it runs dlopen() on that
library/DSO. The Xenomai code in charge of attaching the calling process
to the rt core is contained in the bootstrap*.o files, one to be glued
into pure execs, another one to be glued into PIC modules such as a DSOs.

This configuration is typically useful with plugin architectures, which
may dynamically load a Xenomai-dependent plugin to gain some rt
services, but for which there is no point in having the main executable
depend on or even know about Xenomai by construction. e.g. some language
interpreter which can be dynamically extended by linking in rt features
implemented in an external DSO.

> to build an application that uses that library:
> 
> To compile: xeno-config --posix --cflags + normal cflags
> To link: xeno-config --posix --ldflags --no-auto-init + (ldflags of the library)
> 

Correct, if bootstrapping the Xenomai services for the process is done
at some point though; like by passing --auto-init-solib for building a
DSO this app depends on, as you originally mentioned.

> 3) C/C++ POSIX shared library with native (2.x) (--alchemy) code and xddm
> mechanism to interchange data. The posix code must not be wrapped
>

Assuming you meant: the posix code should not be wrapped (i.e.
application requirement, not a Xenomai requirement).

> To compile: xeno-config --native --cflags --compat
> To link: xeno-config --native --ldflags --auto-init -auto-init-solib --compat
> 
> to build an application that uses that library:
>

Correct, dropping --auto-init in this case though.


> compile and link with normal flags of the application to link against.
> 
> 
> Best regards,
> 
> 
> Leopold
> 


-- 
Philippe.

