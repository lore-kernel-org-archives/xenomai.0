Message-ID: <478BC989.6020103@domain.hid>
Date: Mon, 14 Jan 2008 21:43:53 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200801141627.32289.peter.soetens@domain.hid>
In-Reply-To: <200801141627.32289.peter.soetens@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Is rt_task_set_mode( T_PRIMARY, 0,
 0 ) temporary ?
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
To: Peter Soetens <peter.soetens@domain.hid>
Cc: xenomai@xenomai.org

Peter Soetens wrote:
> Hi,
> 
> Is it possible that this call only clears the T_PRIMARY flag temporary, and 
> that after 'some' rt_ call, the flag is set again ? 
>

Any potentially blocking rt-syscall for instance, occurring between 
rt_task_set_mode() and rt_task_inquire(), would indeed switch the thread 
back to primary, clearing the XNRELAX bit from the status.

> I tried to check this with rt_task_inquire(	task, &info ) and check  
> info.status & XNRELAX but that always returned false.
> 
> Peter


