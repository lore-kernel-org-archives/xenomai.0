Message-ID: <454713B5.2020707@domain.hid>
Date: Tue, 31 Oct 2006 10:13:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Maximum number of realtime tasks
References: <54b161f50610310051q2ec175a2vb3f5c90872ea0364@domain.hid>
In-Reply-To: <54b161f50610310051q2ec175a2vb3f5c90872ea0364@domain.hid>
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
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org

Frits de Klark wrote:
> Hello everyone,
> 
> I'm thinking about implementing a tcp/ip socket server where I assign 
> each incoming connection 2 realtime tasks; 1 one for transmitting data 
> and 1 for receiving data. I'm aware of the fact that the tasks will lose 
> their realtime capacities, but I want to do some tests nonetheless.
> I was wondering if there is a limit on the number of realtime tasks I 
> can allocate and run at the same time. Is there any?
> And may there be other problems to expect?
> 
> Thanks very much for your help,

Pay attention to the stack size of the user-space tasks: the default of
8 Megabytes will exhaust your RAM rapidly. So, you should either :
- set the default stack size with ulimit;
- or set the the stack size of the created threads, but in this case the
main thread will have an 8 Megabytes stack.

In order to set the stack size of a thread, use
pthread_attr_setstacksize if using the POSIX skin or the stksize 
parameter of rt_task_create if using the native skin.

-- 
                                                  Gilles Chanteperdrix

