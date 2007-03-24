Message-ID: <4605149A.5090802@domain.hid>
Date: Sat, 24 Mar 2007 13:07:54 +0100
From: Viktor STARK <abraar@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [RT_PIPE] - User space read() not waking up
References: <20070322215707.232970@domain.hid>	
	<b647ffbd0703230142n46a215ddv5ab0e2c984d0d93c@domain.hid>	
	<460481F2.5010408@domain.hid>	
	<b647ffbd0703240320ta4f54ccg344108ddd1f47958@domain.hid>
	<1174737325.20953.24.camel@domain.hid>
In-Reply-To: <1174737325.20953.24.camel@domain.hid>
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
To: rpm@xenomai.org
Cc: Viktor STARK <stark.viktor@domain.hid>, Xenomai help <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Sat, 2007-03-24 at 11:20 +0100, Dmitry Adamushko wrote:
>
>   
>>         3) Pipes seemed to be a good way to transfer data from kernel
>>         space.
>>         What other (maybe more deterministic) way would you suggest?
>>         I'm not 
>>         asking for a complete program architecture here just a half
>>         dozen words 
>>         describing how you would have done it.
>>
>> rt_queue_*
>>  
>>     
>
> I would add that if you really want to keep the pipe semantics for
> exchanging data without crossing domains between real-time tasks, then
> you may access the real-time API of message pipes from user-space too.
> i.e.
> rt_pipe_create/bind/delete/read/write/stream() are all available from a
> user-space application, in which case data exchange will happen in
> primary mode.
>   
Now, that is interesting. I was left under the impression that in user 
space, the only option to access pipes was using regular 
open()/read()/write().
I guess I overlooked something in the documentation. Thank you for 
pointing this out.

> To sum up, given that you want to create a pipe in kernel space, to
> exchange data with a user-space program, the options with Xenomai's
> message pipes are:
>
> 1) Implementing a real-time communication path between two Xenomai
> tasks, crossing the kernel/user-space boundary without leaving the
> deterministic primary domain: you have to create the kernel-side
> endpoint in your module, then bind the user-space endpoint to the latter
> using the proper interface, as shown below in the REALTIME_TO_REALTIME
> illustration.
>
> 2) Implementing a communication path between a real-time Xenomai task in
> kernel space, and a regular user-space program: you still have to create
> the kernel-side endpoint in your module, then use the standard
> open/read/write routines to access to the pipe channel. This is what you
> are doing right now.
>
> kernel-side:
>
> void foo_task(void)
> {
> 	for (;;) {
> 		rt_pipe_read/write(&pipe_desc, ...);
> 	}
> }
>
> int init_module(void)
> {
> 	rt_pipe_create(&pipe_desc, "channel", ...);
> }
>
> user-space side:
>
> int main(int argc, char *argv[])
> {
> #ifdef REALTIME_TO_REALTIME
> 	/* promote main() to the Xenomai real-time space */
> 	rt_task_shadow(&task_desc, __FUNCTION__, ...);
> 	/* bind to the pipe created in kernel space */
> 	rt_pipe_bind(&pipe_desc, "channel", TM_INFINITE);
> 	for (;;) {
> 		rt_pipe_read/write(&pipe_desc, "channel", ...);
> 	}
> #else /* REALTIME_TO_REGULAR */
> 	fd = open("/proc/xenomai/registry/native/pipes/channel",O_RDWR);
> 	for (;;) {
> 		read/write(fd, ...);
> 	}
> #endif
> }
>   
That looks like a pretty good solution. I'll be able to test this out on 
Monday. I'll keep the list posted about my results.

Thanks a lot for your enlightening comments / example. It's very much 
appreciated.


Viktor STARK

