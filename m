Message-ID: <4447982A.9060409@domain.hid>
Date: Thu, 20 Apr 2006 16:18:18 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_heap_bind in kernel module
References: <200604201442.18803.stefan.eletzhofer@domain.hid>
In-Reply-To: <200604201442.18803.stefan.eletzhofer@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: stefan.eletzhofer@domain.hid
Cc: xenomai@xenomai.org

Stefan Eletzhofer wrote:
> Hi,
> reading the API docs (2.1.0) of the xenomai native API I noticed that the 
> rt_heap_bind() call is a userspace-only call and i'm wondering why that is
> the case? Or am I missing something here?
> 

Binding op are not supported in kernel space, basically because one sees 
a single address space there, and it's always possible to share the 
original object descriptor directly between modules as a plain memory 
area. The synchronization the binding ops provide between the creator 
and the users of a given resource has been ignored for kernel space.

> I'm in the process of porting applications which use the RTAI shm module
> in both user space and kernel space; these applications basically allocate 
> the shared memory chunks in user space and then have kernel modules dump
> data into these areas.
> 
> To port things, I've coded a rt_heap_bind() for kernel space modelled after 
> the code in skins/native/syscalls.c using the nucleus registry API, and that 
> seems to work. So, is this missing call just laziness, then I'd post a patch.
> 
> Thanks,
> Stefan E.
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

