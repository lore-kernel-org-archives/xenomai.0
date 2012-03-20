Message-ID: <4F68F981.80100@domain.hid>
Date: Tue, 20 Mar 2012 22:41:21 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CB8E6CC0.1EE6B%glen@domain.hid>
In-Reply-To: <CB8E6CC0.1EE6B%glen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Linux Serial Does not work with
 CONFIG_XENO_OPT_PERVASIVE enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Glen Wernersbach <glen@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/20/2012 10:20 PM, Glen Wernersbach wrote:
> I know that there are some compile bugs if you turn off
> CONFIG_XENO_OPT_PERVASIVE.
>
> What is the downside to running without it?
>

Don't bother for these build bugs, they were innocuous and due to 2.6.0 
being the first code drop of a major release. The system is stable with 
or without.

PERVASIVE gives you real-time support in userland; if you disable it, 
you only have support for writing apps in kernel space directly on top 
RT drivers.

PERVASIVE is by no mean directly related to hw setup, serial links, etc. 
This is only about switching on/off the userland request channel to the 
Xenomai kernel, nothing else. So any interaction with a serial driver 
could only be really remote, and I can't think of any right now.

Disabling this option might simply change the kernel code layout 
significantly enough to trigger a completely unrelated bug, since the 
Xenomai footprints in kernel shrinks in that case, changing the code 
placement for sure.

Starting investigations from the matrix driver seems the best way to 
find the issue.

>
>
> On 3/20/12 4:35 PM, "Gilles Chanteperdrix"
> <gilles.chanteperdrix@xenomai.org>  wrote:
>
>> On 03/20/2012 09:19 PM, Glen Wernersbach wrote:
>>> I actually think in is in the settings because if run just the setup part of
>>> the code without reading and writing, on the kernel that works my activity
>>> LED turns off.
>>>
>>> On the xeno kernel the LED never changes.
>>
>> I actually think that CONFIG_XENO_OPT_PERVASIVE does not make any
>> difference which could cause a difference of hardware behaviour. So, it
>> must be another option triggered by this config change. So, if you want
>> us to help you, please post the .configs.
>>
>


-- 
Philippe.

