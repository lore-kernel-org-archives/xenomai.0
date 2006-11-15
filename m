Message-ID: <455B11AC.7000300@domain.hid>
Date: Wed, 15 Nov 2006 14:10:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] pthread_setname_np
References: <DD39B5C3F4963040ADC9768BE7E430CB0154EEEB@is-hdq-exchange.marel.net>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0154EEEB@is-hdq-exchange.marel.net>
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
> this function does not change the name inside /proc/xenomai/stat or
> sched for user space Posix threads. As I understand the other function
> pthread_attr_setname_np() is only valid (and available) for Kernel level
> threads.
>  
> Is there any way that works correctly to name a thread to something
> different than simply the executable name ?

I tested pthread_set_name_np with the "switchtest" program on x86 and
ARM, and it works. Could you run switchtest on your platform and see
if the information in /proc/xenomai/sched is correct ?

-- 
                                                 Gilles Chanteperdrix

