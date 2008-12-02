Message-ID: <49355A59.4050600@domain.hid>
Date: Tue, 02 Dec 2008 16:55:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <493306F5.2080605@domain.hid>
	<49330CD3.4090700@domain.hid>	<4933BAE2.3000502@domain.hid>
	<4933F1A4.8060209@domain.hid>
	<4933F18F.7080103@domain.hid> <4933FE5A.5060501@domain.hid>
	<49355B5D.8070802@domain.hid>
In-Reply-To: <49355B5D.8070802@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread cancelation and scheduling magics
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Hi Gilles,
> 
> Gilles Chanteperdrix wrote:
>> Gilles Chanteperdrix wrote:
>>>>> Now, the question is, do you realistically plan to write an application
>>>>> which makes no syscall in its real-time loop?
>>>> Unlikely, but it may happen in case of programming errors. Anyhow, the
>>>> pthreads will run legacy code and it would be a pain to add
>>>> pthread_testcancel where necessary. But maybe there is a more elegant
>>>> and simple solution to do a defined exit/abort.
>>> In case of programming error, enable the xenomai watchdog, it will
>>> forcibly kill the problematic thread.
>> To give you a more complete answer: most blocking functions are
>> cancellation points in the PTHREAD_CANCEL_DEFERRED case, so, you
>> probably do not need to add pthread_testcancel at all. The only
>> exception is pthread_mutex_lock: this way, cancellation happens for well
>> defined mutex states, and you may install cleanup handlers with
>> pthread_cleanup_push/pthread_cleanup_pop if ever a thread may be
>> destroyed while holding a mutex. With PTHREAD_CANCEL_ASYNCHRONOUS, the
>> situation is not that clean.
> 
> Well, there seems something wrong with it, also PTHREAD_CANCEL_DEFERRED
> with pthread_testcancel does not work reliably and consistently and it
> still behaves different on my ARM and PowerPC systems. I have attached
> my revised test program allowing to enable/disable various method of
> thread creation, setup and cancellation. They all work fine with the
> Linux POSIX libraries. With Xenomai, only a few work as expected on my
> ARM and PowerPC test systems.

Could you explain us exactly what happens ?

-- 
                                                 Gilles.

