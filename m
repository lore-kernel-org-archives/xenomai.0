Message-ID: <451BC990.1060205@domain.hid>
Date: Thu, 28 Sep 2006 09:09:36 -0400
From: Randy Smith <rsmith@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: Proper module_cleanup procedure
References: <4506F853.6060502@domain.hid>	<45085027.1000204@domain.hid>
	<17672.23330.753175.711411@domain.hid>
In-Reply-To: <17672.23330.753175.711411@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: xenomai@xenomai.org

Thanks for all of your help and just a quick follow up on this.

I added a call to rt_task_delete() in my module cleanup routine and this 
cleared the memory error I was getting whenever I tried to unload the 
module and then load it again.

I am still trying to discover some mechanism by which the kernel module 
can determine if a particular heap is in use by a user-mode app without 
having coordinating code in the user app. Don't want to jerk the rug out 
from under the user app by deleting the heap before the user app is 
finished with it.

-Randy Smith
Software Engineer,
ImageMap, Inc.


Gilles Chanteperdrix wrote:
> Randy Smith wrote:
>  > Anyone?...Is this mike on?
>  > 
>  > Randy Smith wrote:
>  > > Hello,
>  > >
>  > > I am running the 2.4 kernel with Xenomai-2.1.0 native skin and I have 
>  > > a kernel module that creates 2 shared memory heaps and then creates a 
>  > > a periodic realtime task to do some interesting things.  This periodic 
>  > > realtime task communicates with a linux user mode task through the 
>  > > shared memory that gains access to it through 
>  > > rt_heap_bind/rt_heap_alloc calls.  Things go along swimmingly.
>  > >
>  > > I now want to be able to do an "rmmod" on the module and in its 
>  > > cleanup routine, right now I just have rt_heap_delete calls for the 
>  > > two shared memory heaps.  This completes successfully, but if I then 
>  > > try to install another version (debug for instance) of the module with 
>  > > "insmod", I get a memory error.
>  > > Is this is due to the fact that I didn't suspend the periodic realtime 
>  > > task and then delete it before deleting the heaps?  Is this 
>  > > necessary?  Are there any use counts or other signs that I could check 
>  > > to ensure that everyone was finished with the heaps so that I can 
>  > > delete them?
>  > >
>  > > Is there any consequence to the user mode task due to jerking the rug 
>  > > out from under it?
>
> You should probably delete the task using the heaps before deleting the
> heaps. But I am not sure of the kind of error you would get when
> failing to do it. In order to know if the error you encounter is due to
> this or a bug, we need a concrete (and preferably minimal) excerpt of
> code.
>
> For the general issue of the cleanup of a mixt (kernel-space/user-space)
> application, I would lock the module with try_module_get when it is
> currently used by a user-space application. Actually, I have done it for
> the xeno_switchtest module, opening the RTDM device locks the module and
> closing the device unlocks it.
>
>   

