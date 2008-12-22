Message-ID: <494F9007.5060600@domain.hid>
Date: Mon, 22 Dec 2008 13:03:03 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081127175234.163sujmgcgcgs4gk@domain.hid>	<492EF786.4040303@domain.hid>	<20081128181906.mnv2mvjgo44wgoc0@domain.hid>	<49301B0B.9010208@domain.hid>	<20081128182944.qp8yhwpk6cw8cwss@domain.hid>	<49302630.4080104@domain.hid>	<D6B7B711-7E2F-466D-857F-53EB7A7C30DC@su.sabanciuniv.edu>	<B41FD0F2-09C0-4DB6-B36C-892B72A63875@domain.hid>	<C7714144-0328-4258-95BD-133AB45C72E9@domain.hid>	<494F6250.50707@domain.hid>
	<20081222133253.lscsfad40kswkwsc@domain.hid>
In-Reply-To: <20081222133253.lscsfad40kswkwsc@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Zombie user tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mehmet Alphan Ulusoy <alphan@domain.hid>
Cc: xenomai@xenomai.org

Mehmet Alphan Ulusoy wrote:
> On Mon 22 Dec 2008 11:48:00 EET, Gilles Chanteperdrix wrote:
>> What would be really interesting too, is to have the process status. So,
>> in function sched_show_task, file kernel/sched.c, could you try and
>> print p->state in hexadecimal? In the dump you sent, the state is shown
>> as a question mark, so we do not really know in what state the task is.
>>
> 
> The output of the sched says the task is 'relaxed shadow', I believe  
> what you ask for is something else. I will try to make the change you  
> suggested and hopefully send you the dump once the task turns into a  
> zombie.

Unless I misunderstood something, the zombie task (called actuatorTask)
does not appear in /proc/xenomai/sched and /proc/xenomai/stat, the task
which appears there is "Actuator Aperiodic Task". actuatorTask, however,
appears in the sysrq+T output, and its state (for Linux scheduler, not
for xenomai scheduler, since for xenomai scheduler it does not even
exist) is "?", so, what I would like to know is its real state, printed
in hexadecimal. For this, you just have to print p->state using 0x%08x
as printk format.

-- 
                                                 Gilles.

