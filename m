Message-ID: <43DCA352.60700@domain.hid>
Date: Sun, 29 Jan 2006 12:13:22 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] anonymous user-space tasks (again)
References: <200601152002.36397.kisda@domain.hid>
	<17355.32872.996051.514072@domain.hid>
In-Reply-To: <17355.32872.996051.514072@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Stefan Kisdaroczi wrote:
>  > A small program only calling rt_task_shadow with NULL-name fails if i start it 
>  > a second time. Error EEXIST (-17). Same for a program calling only 
>  > rt_task_spawn with NULL-name.
> 
> I am able to observe this behaviour. I am on it.
> 
>  > Apropos registry:
>  > In the trunk there is no file src/native/registry.c anymore. I do not really 
>  > miss it, but the API documentation still says these calls can be made from 
>  > user-space. Should I create a patch to update the docs? Or should it be 
>  > there?
> 
> I will update the doc too. There are no registry syscalls in
> ksrc/skins/native/syscall.c, and no skins/native/lib/registry.c in 2.0.x
> branch either, so it looks intentional. Registry services are not
> accessible from user-space. Philippe will be able to explain here.

Existing registry calls are intended for use in code implementing RT interfaces in 
kernel space, not by applications. This is why we do not have any user-space 
syscalls to reach them.

> 
> Thanks for reporting.
> 


-- 

Philippe.

