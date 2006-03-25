Message-ID: <44251658.9040707@domain.hid>
Date: Sat, 25 Mar 2006 11:07:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT_TASK descriptor question
References: <1143280058.14325.257499491@domain.hid>
In-Reply-To: <1143280058.14325.257499491@domain.hid>
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
To: Alessandro Pittaluga <xpit@domain.hid>
Cc: xenomai@xenomai.org

Alessandro Pittaluga wrote:
> Hi,
> 
> In the native skin rt_task_create receives a pointer to a RT_TASK struct
> which must be allocated in permanent memory.
> So I thought that the address of this struct would be the task
> identifier used to be passed to the other rt_task functions.
> And it works in this way.
> 
> The strange thing is that rt_task_self does not return the same value of
> RT_TASK*, but allocates a new RT_TASK structure the first time it is
> called in a new task context.
> 
> Why? 
> 

Because the relevant bit of information is not the descriptor struct per 
se, but rather its contents. This way, one can point to the same object 
using a descriptor struct, regardless of the allocation context of such 
struct. This is particularly useful for sharing objects between 
different execution spaces: regardless of the layout of the descriptor 
or the context it has been created, one only has to know that the 
descriptor contains enough information to point back to the registered 
object; IOW, the descriptor address is not part of the indexing information.

Using this property, rt_task_self() can simply fill any descriptor 
_struct_ once, at the time of the first call for any given thread. The 
struct itself is part of TSD/PTD information, and has been pre-allocated 
at thread creation. This way, the kernel is only asked once for filling 
the struct on a pre-allocated memory area, and subsequent calls to 
rt_task_self() just return the PTD value associated with the descriptor 
struct key.

> Many thanks
> 
> Alessandro


-- 

Philippe.

