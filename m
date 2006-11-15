Message-ID: <455B29BE.3060805@domain.hid>
Date: Wed, 15 Nov 2006 15:52:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] pthread_setname_np
References: <DD39B5C3F4963040ADC9768BE7E430CB0154EFA2@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0154EFA2@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
> Gilles Chanteperdrix wrote:
> 
> 
>>>The switchtest program works here correctly as well. Looking at the
>>>switchtest code I found out that one has to call this function
>>>_after_ one has actually created the thread with pthread_create()
>>>not like pthread_attr_setXXXX() functions which have to be called
>>>before. After changing the order in my code, it worked there as well.
>>>
>>>Is this behaviour intended ?
>>
>>pthread_set_name_np requires a pthread_t argument, and returns ESRCH
>>if this argument is invalid. It is supposed to be documented at:
>>
> 
> http://www.xenomai.org/documentation/trunk/html/api/group__posix__thread
> .html#g414a759c928f7be7ac105980d8e73431
> 
> Yes it is documented and one can guess that the function only should be
> called for a valid thread, i.e. a thread that is already created by
> reading the part of the documentation which mentions the error code.

You are being dishonest: the function expects a pthread_t argument, the
only way to get a valid pthread_t value is to create a thread or to call
pthread_self().


> 
> But as this is a non standard function and normally for Posix threads
> one expects to specify all attributes before spawning a thread (compare
> also pthread_attr_setname_np()), maybe one should add a sentence in the
> documentation, stating that this function is only valid for an already
> running thread.

Look again at the POSIX API: functions which set an attribute before
spawning the thread are all called pthread_attr_*, pthread_set_name_np
is not the only function which allow to change the attribute of a
running thread, there is also pthread_detach or pthread_setschedparam.
Like these standard functions pthread_set_name_np is prefixed with
pthread, and not with pthread_attr.


> 
> Btw. Is there a reason why the call to pthread_attr_setname_np() is
> limited to kernel space ?

It is impossible to implement pthread_attr_setname_np in user-space. I
think I will remove this call, having different APIs in kernel-space and
user-space only adds confusion.

-- 
                                                 Gilles Chanteperdrix

