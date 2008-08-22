Message-ID: <48AF0378.3030001@domain.hid>
Date: Fri, 22 Aug 2008 20:20:40 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <406CC9939904F143B9D42CEEA3E56E56431F57@domain.hid>
	<48AAF55E.9000206@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E56431FCD@oab1mx1.oneaccess.intra>
	<48ABEF11.6060307@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E56432116@domain.hid>
	<48AC6BA0.9010306@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E56432274@domain.hid>
In-Reply-To: <406CC9939904F143B9D42CEEA3E56E56432274@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] uClinux write to pipe returning -ENOMEM
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Filip Van Rillaer <Filip.VanRillaer@domain.hid>
Cc: xenomai@xenomai.org

Filip Van Rillaer wrote:
> Hello Philippe,
> 
> I updated via svn ... and transferring data to the Xenomai domain with a
> pipe now works perfect. I see that also the documentation has been
> updated. Thanks a lot, very nice work.
>

Both the maintenance and the -devel branches have been updated with changes that
make the non-RT write side block until enough memory is available from the pool
(unless O_NONBLOCK is set). The work-around will still work, but the return
value from the NOBUF event handler is now discarded; the nucleus will retry to
get memory automatically.

> I still have 1 thing on my wish-list of the pipe: is it possible to add
> 1 argument Cookie (void* or long) to the rt_pipe_monitor function so
> that when a generic monitor-function is used, it would be possible to
> find it's instance data (that Cookie should then be passed to the
> call-back function).
> Now I have to work around this as follows:
> 
> static rt_vcom_context_t* MonitorCookie[2];
> MonitorCookie[0] = &Instance_data_0; rt_pipe_monitor(Pipe0,
> MonitorFcts[0]);
> MonitorCookie[1] = &Instance_data_1; rt_pipe_monitor(Pipe1,
> MonitorFcts[1]);
> 
> static int cbMonitor0(RT_PIPE* hPipe, int Event, long Arg) {return
> cbMonitor(hPipe, Event, Arg, MonitorCookie[0]);}
> static int cbMonitor1(RT_PIPE* hPipe, int Event, long Arg) {return
> cbMonitor(hPipe, Event, Arg, MonitorCookie[1]);}
> typedef int (*monitor_f)(RT_PIPE *pipe, int event, long arg);
> static monitor_f MonitorFcts[SERIAL_NR_DEVS] =
> {
>    cbMonitor0
>   ,cbMonitor1
> };
> 
> static int cbMonitor(RT_PIPE* hPipe, int Event, long Arg, void* Cookie)
> { /* my generic Monitor implemnetation for all instances */
>   rt_vcom_context_t* Mycontext = (rt_vcom_context_t*)Cookie;
>   /* .... */
> }
> 
> However, with an improved version of the Xenomai interface, I would not
> need the MonitorFcts array, just:
> rt_pipe_monitor(Pipe0, cbMonitor, &Instance_data_0);
> rt_pipe_monitor(Pipe1, cbMonitor, &Instance_data_1);
> 

cookie args are prone to clutter the API and introduce useless overhead for
carrying them, therefore we don't want to add more of them. The preferred way is
something like:

struct instance {

	RT_PIPE pipe_desc;
};

int handler(RT_PIPE *pipe, int event, long arg)
{
	struct instance *p;

	p = container_of(pipe, RT_PIPE, pipe_desc);
	...
}

I.e. the pipe descriptor can be embodied into the instance structure since there
seem to be a 1:1 relationship, so that the container_of() macro can compute the
address of the containing instance structure from the pointer to the pipe
descriptor.

> Please comment.
> 
> 
> Question concerning P_EVENT_NOBUF.  Now I am using the user-space
> endpoint in blocking mode and it works fine with the latest version of
> Xenomai when the memory is exhausted.  So far, so good.  But what would
> happen if I open the endpoint in non-blocking mode? Would it still be
> the implementation of the handler (returning 0) of P_EVENT_NOBUF that
> would have the power to block the writer or will the writer then see the
> ENOMEM (so indeed non-blocking in all cases)?  Please comment.
> 

O_NONBLOCK would prevent the caller to wait for memory, and cause EWOULDBLOCK to
be returned. There is nothing expected from the NOBUF handler anymore to get
that result. The write() system call will only return ENOMEM in case the buffer
to send is larger than the largest contiguous area of memory available from the
pool, which would mean that the allocation request could never be satisfied.

> 
> Best regards,
> Filip.
> 
> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org] 
> Sent: 20 August 2008 21:08
> To: Filip Van Rillaer
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] uClinux write to pipe returning -ENOMEM
> 
> Filip Van Rillaer wrote:
>> Hello,
>>
>> Thank you for your work-around.
>> Though I have some problems with the implementation:
>> pipe_i_handler (Xenomai side) does not know when the xnpipe_write got 
>> errno=ENOMEM (the pipe_i_handler is I think even not called in case 
>> ENOMEM is returned).  So there is I think with the current Xenomai 
>> implementation no way for the pipe_i_handler to correctly fill in the 
>> value of buffer_filled_up_p.  This would mean that my writer-thread 
>> 'userland' would have to set this 'variable'.
>> Then I was thinking about moving the <<rt_sem_p(&bsync, TM_INFINITE)>>
> 
>> to the writer-thread when errno-ENOMEM is returned, but that would 
>> require that the writer-thread has to bind the semaphore that was 
>> created in another program.  This is probably possible via the Xenomai
> 
>> registry.
>>
> 
> Commit #4114 provides P_EVENT_NOBUF (formerly P_EVENT_FULL).
> 
> --
> Philippe.
> 


-- 
Philippe.

