Message-ID: <469FD346.4060402@domain.hid>
Date: Thu, 19 Jul 2007 17:10:30 -0400
From: Vincent Levesque <vleves@domain.hid>
MIME-Version: 1.0
References: <760425846A1BC44B8BD24361EF2E3451A69749@domain.hid>	<1184746976.6562.62.camel@domain.hid>	<760425846A1BC44B8BD24361EF2E3451010D9A3F@square.bfh.ch>
	<1184755654.13258.17.camel@domain.hid>
In-Reply-To: <1184755654.13258.17.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Writing from user space direct to
 IO	Ports	without mode switches
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
Cc: xenomai@xenomai.org

Hi Philippe,
> Excepts from your code:
>   while(!end){
>     //switch to primary mode
>     ret = rt_task_set_mode(0, T_PRIMARY, NULL);
>
> Damnit. I knew this particular interface was going to be misused most of
> the time. In short: do ____NOT_____ switch modes manually, this is
> useless because Xenomai syscalls do it for you, and even sub-optimal
> because the kernel knows better when it needs it and saves you a syscall
> when required. The T_PRIMARY bit has been solely provided for internal
> Xenomai purposes (some Xenomai libs have very special requirements in
> very rare cases). rt_task_wait_period() will switch to primary mode if
> needed, and always leave you in primary upon return.
>   
Indeed, I was also doing the same thing. From my understanding of the 
docs, I assumed that manually setting a task to secondary mode was 
allowed and could improve performance. Take for instance a task that 
logs data coming from a RT_QUEUE to a file. Is there anything special 
that should be done to minimize the impact of the frequent mode switches 
in such a case?

Thanks,

Vincent Levesque
vleves@domain.hid

