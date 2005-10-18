Message-ID: <435520E6.3070704@domain.hid>
Date: Tue, 18 Oct 2005 18:20:54 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai and gdbserver
References: <BF7A670A.18EE%steve@domain.hid>
In-Reply-To: <BF7A670A.18EE%steve@domain.hid>
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
To: Steven Seeger <steve@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> I use remote debug with fusion/2.6.13, but I am using fusion from svn.
> 
> Also, there are bugs. One I have found recently is that if a task is created
> with T_SUSP and then you start stepping through the code, the task seems to
> start up on its own somehow. Weird.

Last time you reported that you actually mentioned the rt_task_spawn() service, 
which is designed to start the task immediately. Reading about the T_SUSP bit 
now seems to mean that you are not using rt_task_spawn() anymore, but that the 
problem indeed appears. Could you be more specific about the code in question?

> 
> Older verisons of fusion had issues with not every task in the application
> halting on breakpoint.
> 

Strange indeed, since there is no reason for the exception triggered by any 
breakpoint to behave in a context-dependent manner, I mean on a task-by-task 
basis. Do you remember the first version that seemed to solve the issue?

> On 10/18/05 8:10 AM, "Marco Cavallini" <rtai@domain.hid> wrote:
> 
> 
>>Hi
>>I wonder if someone has been able to perform a remote debug with
>>xenomai/fusion.
>>I have problems debugging fusion-0.9.1 programs with kernel-2.6.12.2 and
>>Fedora Core 2
>>gdb-6.0
>>
>>When i run GDB chain and step into rt_task_create(...), GDB prompts "[1]+
>>Stopped         gdb chain" and
>>terminates. I can
>>call "gdbserver ipnum:port chain". then connect to it from a remote machine
>>using gdb and "target remote..."
>>
>>
>>_______________________________________________
>>Xenomai-core mailing list
>>Xenomai-core@domain.hid
>>https://mail.gna.org/listinfo/xenomai-core
> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 

Philippe.

