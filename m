Message-ID: <4D34A82F.6070000@domain.hid>
Date: Mon, 17 Jan 2011 21:35:59 +0100
From: WONG Sheng Chao <wong@domain.hid>
MIME-Version: 1.0
References: <4D31B6C3.5060007@domain.hid> <4D34642E.9090300@domain.hid>
In-Reply-To: <4D34642E.9090300@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] [SOLVED] Re:  Question on periodic task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Problem solved, it was a problem with unsigned long long (ULL). Thanks 
Gilles and Philippe.

On 1/17/2011 4:45 PM, Gilles Chanteperdrix wrote:
> Wong Sheng Chao wrote:
>> Hi
>>
>> I'm a newbie in real time programming and I recently came to know of
>> Xenomai. After patching the Xenomai to the linux kernel, I ran some
>> examples that I found from the Internet to get a better understanding of
>> the periodic task. Everything seems to run fine when I start two tasks
>> with period of 1s and 2s, but the system freezes when I added more tasks
>> ( more than 2 tasks). The period is at 1s, 2s and 3s so i think the
>> processor has more than enough time to process the tasks.
>>
>> I also read that the periodic mode is emulated by a software driver
>> which uses one-shot mode programming. Thus i did not enable periodic
>> timing when I compile the Linux kernel, is this the cause of the problem?
>>
>> I'm using a system with Core i7, ubuntu 10.04, linux kernel 2.6.32.15,
>> xenomai 2.5.4
>>
>> Do let me know what I did wrong in the code, thanks in advance!!
>>
>>
>> void demo (void *arg)
>> {
>>    //take in argument
>>    int num = (int *)arg;
>>
>>    RT_TASK *curtask;
>>    RT_TASK_INFO curtaskinfo;
>>
>>    curtask=rt_task_self();
>>    rt_task_inquire(curtask,&curtaskinfo);
>>
>>    // task period in seconds
>>    rt_task_set_periodic(NULL, TM_NOW, (1000000000 * num));
> Should be 1000000000ULL * num here.
>


