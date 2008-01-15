From: Peter Soetens <peter.soetens@domain.hid>
Date: Tue, 15 Jan 2008 10:24:53 +0100
References: <200801141627.32289.peter.soetens@domain.hid>
	<478BC989.6020103@domain.hid>
In-Reply-To: <478BC989.6020103@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200801151024.53483.peter.soetens@domain.hid>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Is rt_task_set_mode( T_PRIMARY, 0,
	0 ) temporary ?
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

On Monday 14 January 2008 21:43:53 Philippe Gerum wrote:
> Peter Soetens wrote:
> > Hi,
> >
> > Is it possible that this call only clears the T_PRIMARY flag temporary,
> > and that after 'some' rt_ call, the flag is set again ?
>
> Any potentially blocking rt-syscall for instance, occurring between
> rt_task_set_mode() and rt_task_inquire(), would indeed switch the thread
> back to primary, clearing the XNRELAX bit from the status.

Thanks, It would be nice to add this sentence to the API docs.

So how do I run a task permanently in secondary mode ? The reason I want to do 
this is two fold: We want to share xenomai native mutexes and semaphores 
between threads running in primary domain and threads running under the Linux 
scheduler. And we want a thread type that allows user code to go in endless 
loops without hanging the machine. In RTAI we did this creating an RTAI task 
which was run in the soft-rt mode.
I believe a plain posix thread can not use the 'native' interface ? 

Peter

-- 
Peter Soetens -- FMTC -- <http://www.fmtc.be>

