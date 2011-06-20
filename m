Message-ID: <4DFFBBDB.4030703@domain.hid>
Date: Mon, 20 Jun 2011 22:30:03 +0100
From: Jakub Nowacki <j.s.nowacki@domain.hid>
MIME-Version: 1.0
References: <4DF9CA75.1040903@domain.hid>	<4DF9DCE3.70703@domain.hid>	
	<BANLkTinki=NqJ1f1vyGNBMHLZuwiCtrmMw@domain.hid>	
	<4DFBA463.3090902@domain.hid>	<4DFBAEB9.8060106@domain.hid>	
	<4DFBB08B.5020005@domain.hid>	<4DFCC18F.3060207@domain.hid>	
	<BANLkTin00xA-LMikumq1C4_nFyFbCdgi+Q@mail.gmail.com>	
	<4DFF610F.5070602@domain.hid> <4DFF664C.5030504@domain.hid>
	<1308586589.2119.10.camel@domain.hid> <4DFF84C0.6010008@domain.hid>
In-Reply-To: <4DFF84C0.6010008@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on i7-870
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
Cc: Xenomai help <xenomai@xenomai.org>

On 20/06/2011 18:34, Gilles Chanteperdrix wrote:
> On 06/20/2011 06:16 PM, Philippe Gerum wrote:
>> On Mon, 2011-06-20 at 16:25 +0100, Jakub Nowacki wrote:
>>> On 06/20/2011 04:02 PM, Gilles Chanteperdrix wrote:
>>>> You have to increase CONFIG_XENO_OPT_SYS_STACKPOOLSZ.
>>>>
>>> It is 128 Kb now. Should it be more? Is there any (thumb) rule for this
>>> value?
>>
>> Max # of concurrent kernel-based Xenomai threads x stack_size. 8k stack
>> minimum is a safe bet for x86_64.
>>
>> Typically, RTDM (driver) tasks in kernel space are Xenomai ones, so you
>> would need to reserve stack space for each of them in this amount.
>>
>> The switchtest driver is RTDM-based, and may run a number of RTDM tasks,
>> depending on the test scenario.
>
> The default scenario being to run 6 rtdm tasks by cpu (that would make
> 48 on an 8 cores processor).
>
Thanks for the explanation. I've changed the stack pool size to 512kb, 
which is slightly more then minimum, and it allowed the test to run.

As for the tests, I don't think I have to be more pessimistic in it. I 
have to (finally) do some lab testing, which would potentially reveal 
some problems. Nonetheless, thanks for the suggestions.

Cheers,

Jakub



