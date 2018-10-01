References: <759115071.1538372023382.JavaMail.root@webmail>
 <590994061.262338.1538379738455.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9f06fbf0-f940-1b5a-e59f-4b3d4015844c@siemens.com>
Date: Mon, 1 Oct 2018 09:48:21 +0200
MIME-Version: 1.0
In-Reply-To: <590994061.262338.1538379738455.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] What does activating SMP mean?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 01.10.18 09:42, Per Oberg wrote:
> Hello
> 
> ----- Den 1 okt 2018, på kl 7:33, 박재호 jaeho@seoultech.ac.kr skrev:
> 
>> Hi, all
> 
>> I thought that activating SMP makes tasks using all cpu cores, but I realized
>> that it doesn't.
> 
>> I did not explicitly specify the CPU when I created the task.
> 
>> I have created two xenomai tasks and checked to see how much cpu share the task
>> has on any cpu with / proc / xenomai / stat.
> 
>> As a result, we confirmed that only one cpu of two cpu works.
> 
>> So we used T_CPU () to allocate different CPU cores for each task when we
>> created the task.
> 
>> As a result, you can see that both tasks are running on two CPUs.
> 
>> I expected to use both CPUs when I enabled SMP, but I did not. Why is not it?
> 
>> Also, does one task only run on one cpu?
> 
>> The environment I used is shown below.
> 
>> ------------------------------------------------------------------------
> 
>> zybo-z7-20(zynq-7000)
> 
>> Dual-Core ARM Coretex-A9 MPCore Up to 866MHz
> 
>> xenomai 2.6.5
> 
>> kernel 3.14.2
> 
>> ubuntu 14.04
> 
>> ------------------------------------------------------------------------
> 
>> thank you for your advice.
> 
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai
> 
> Not sure that I can answer your question as it was formulated, but perhaps I can contribute with something. Do your test-task use all your CPU time or do you have idling? I would -guess- that as long as one CPU is sufficient the scheduler won't use any other unless it was specified on the command-line.
> 
> I answer, even though I am not sure about this  because I would like to be corrected if I'm wrong.

Xenomai does no load-balancing of RT threads across CPUs. You need to explicitly 
assign a thread to a CPU if you want to spread out on multiple ones. You may see 
this by chance if Linux decides to spawn the non-RT thread part on different 
CPUs prior to Xenomai creating its RT part, but you cannot rely on that.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

