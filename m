Message-ID: <4D514109.9060103@domain.hid>
Date: Tue, 08 Feb 2011 14:11:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinvryUHtzDWQa9j=Z83jNe1FbJtRYaqMHNORfvp@domain.hid>	
	<4D5039AD.2070205@domain.hid>	
	<AANLkTincD+0eKF7tM8aj5s4tepF0KwQ6xkJ52G1Lq4iT@mail.gmail.com>	
	<4D50433D.1040804@domain.hid>	
	<AANLkTi=SfPm6HVK2abFWV8uAd5wWnWv9vf0mkby8282r@domain.hid>	
	<1297154320.2023.6.camel@domain.hid>	
	<AANLkTim4Q_F5wY77TBH5T0oT3P2X2pex7B-8cr6Q+XyS@mail.gmail.com>	
	<1297156556.2023.9.camel@domain.hid> <4D513278.4090606@domain.hid>	
	<1297167172.2023.11.camel@domain.hid> <4D513427.6050707@domain.hid>	
	<1297167750.2023.13.camel@domain.hid> <4D5137B0.8050006@domain.hid>	
	<AANLkTikh_Z8Jg0nYb=089Szzh=_gn=ZZnvBcswnGuTur@domain.hid>
	<1297169771.2023.15.camel@domain.hid>
In-Reply-To: <1297169771.2023.15.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Exception handlers in primary domain /
 user-space signals
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Tue, 2011-02-08 at 13:51 +0100, Henri Roosen wrote:
>> On Tue, Feb 8, 2011 at 1:31 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> Philippe Gerum wrote:
>>>> On Tue, 2011-02-08 at 13:16 +0100, Gilles Chanteperdrix wrote:
>>>>> I was not talking about the Xenomai case specifically, but since Henri
>>>>> would like to have the full signals implementation with Xenomai, this
>>>>> does a apply to Xenomai too.
>>>>>
>>>>>
>>>> I think we all agree that having a complete signal implementation for
>>>> Xenomai in pure rt mode won't happen overnight. So the point is now: how
>>>> could it be mimicked, at least for the most useful part.
>>>>
>>> My point is that whatever you do, a switch user-kernel, then kernel-user
>>> is not going to be lightweight, so avoiding it in the application in the
>>> first place may be a better idea.
>>>
>>> My aim with implementing complete signals was rather for things like
>>> timer_* and mq_notify, where the interface requires them, I did not even
>>> imagine implementing SIGFPE, SIGILL, SIGTRAP, which I thought could not
>>> be time critical anyway, for the reasons explained earlier. So, my
>>> question (rather to Henri) is: what would we need SIGFPE, SIGILL,
>>> SIGTRAP in an real-time application for?
>> I agree it might be unusual. For the tracing use case: the SIGTRAP we
>> use as a means for tracing whether code is actually executed, just
>> like breakpoints, we exchange the code to 0xcc and handle the
>> exceptions do book-keeping but don't stop the task. We know this has
>> overhead, it also had when using our old OS. The old OS handled it in
>> an accepted amount of time. Using the Xenomai kernel it also works,
>> however the overhead is not acceptable anymore.
>> Installing a floating point exception handler was also provided to our
>> customers with the old OS and we have to make that available now too.
>> So actually it is all because of legacy reasons, we have to provide
>> similar functionality as with the old OS.
>>
>> I'm afraid we cannot mimic enough so it suits our use cases. We need
>> the fault context to handle the exception and to set the IP one
>> instruction back.
> 
> So you need the signal rebase over the mayday support I merged a few
> months ago. Back to square one I'm afraid, this won't be available soon,
> albeit this might happen in the 2.6 timeframe. We'll see.

Well, not necessarily, the fault handler may set the IP, suspend the
task, wake-up the dedicated fault-handler thread, then, the dedicated
fault-handler may wake-up the suspended task when the work has been done.

-- 
					    Gilles.

