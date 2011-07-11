Message-ID: <4E1AE8AD.9060703@domain.hid>
Date: Mon, 11 Jul 2011 14:12:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CALiYb9uRfYeG4NTV7Oy1bMpxtJz0skKsxM9D2k_G5uOZsWWQBQ@mail.gmail.com>	<4E1AD8DD.3060904@domain.hid>
	<CALiYb9t21ijjNnpU4dVjfaKF3V_8XxGypUiiOkVROQdVyx-u8g@domain.hid>
In-Reply-To: <CALiYb9t21ijjNnpU4dVjfaKF3V_8XxGypUiiOkVROQdVyx-u8g@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with gdb and rt_task_delete
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrien LEMAITRE <adrien.lemaitre@domain.hid>
Cc: xenomai@xenomai.org

On 07/11/2011 01:48 PM, Adrien LEMAITRE wrote:
> 2011/7/11 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> 
>> On 07/11/2011 11:50 AM, Adrien LEMAITRE wrote:
>>> Hello,
>>>
>>> I have two problems. Just before explain my problems i would like to
>> clarify
>>> the context. This exercice is for student. In this exercice, they program
>> a
>>> WorkingTask (infini loop)
>>
>> That is the problem, there should not busy inifinite loops.
>> rt_task_sleep(100) asks for 100ns sleep, which is equivalent to not
>> sleeping at all.
>>
>> I seem to remember that I already told you this in answer to your
>> previous post.
>>
> 
> yes and thanks you, i have a better understanding now. So ok if i would like
> to make an infini loop i must add a sleep of 5ms, otherwise i have problems.
> That is why i had needed rt_task_suspend(). And the problem with gdb is
> gone.
> 
> But i don't see information of this in the wiki, could you show me exactly
> where i can find it?
> 

You can probably sleep for shorter times than 5ms, 100us should be
enough. This is not documented, because it is an unwanted shortcoming,
which we hope to avoid one day, by implementing signals for xenomai,
working even for interrupting an infinite busy loop.

-- 
					    Gilles.

