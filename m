Message-ID: <455B1966.10609@domain.hid>
Date: Wed, 15 Nov 2006 14:43:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] pthread_setname_np
References: <DD39B5C3F4963040ADC9768BE7E430CB0154EF61@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0154EF61@domain.hid>
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
> Hi,
> 
> Gilles Chanteperdrix wrote:
> 
> 
>>I tested pthread_set_name_np with the "switchtest" program on x86 and
>>ARM, and it works. Could you run switchtest on your platform and see
>>if the information in /proc/xenomai/sched is correct ?  
> 
> 
> The switchtest program works here correctly as well. Looking at the
> switchtest code I found out that one has to call this function _after_
> one has actually created the thread with pthread_create() not like
> pthread_attr_setXXXX() functions which have to be called before. After
> changing the order in my code, it worked there as well.
> 
> Is this behaviour intended ?

pthread_set_name_np requires a pthread_t argument, and returns ESRCH if
this argument is invalid. It is supposed to be documented at:
http://www.xenomai.org/documentation/trunk/html/api/group__posix__thread.html#g414a759c928f7be7ac105980d8e73431

-- 
                                                 Gilles Chanteperdrix

