MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 22 Jun 2011 09:08:47 +0200
From: Michael Thalmeier <michael@domain.hid>
In-Reply-To: <4E011869.2070307@domain.hid>
References: "<f801f3950e5f79192ebc8824bfd54545@domain.hid>"
	<4DFF5FEE.8060901@domain.hid>
	<loom.20110621T110521-226@domain.hid>
	<4E011869.2070307@domain.hid>
Message-ID: <4c54d6289dd4237b16e9dab98d96bde1@domain.hid>
Subject: Re: [Xenomai-help] mprotect in Xenomai
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

 On Wed, 22 Jun 2011 00:17:13 +0200, Gilles Chanteperdrix wrote:
> On 06/21/2011 11:08 AM, Michael Thalmeier wrote:
>> Gilles Chanteperdrix <gilles.chanteperdrix <at> xenomai.org> writes:
>>
>>>
>>> On 06/20/2011 04:14 PM, Michael Thalmeier wrote:
>>>>  Hello !
>>>>  ...
>>>
>>> I am afraid this is platform dependent, on what architecture do you 
>>> get
>>> this behaviour?
>>>
>> I have only tested this behaviour on x86 until now.
>> The system runs a kernel 2.6.32.15 with xenomai 2.5.6.
>
> Issue reproduced, and seem specific to x86 (32, the application
> segfaults on x86_64).
>
> The answer to the original question is no: we do not provide any 
> service
> to do the same thing as mprotect, so, if you want this application to
> work, you will have to dig in the kernel mm code and find exactly 
> what
> is going on.

 Thanks for your efforts.
 I am already studying the kernel mm code to find the cause of our 
 problem.

-- 
 Michael Thalmeier

