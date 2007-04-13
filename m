Message-ID: <461F4D88.9030304@domain.hid>
Date: Fri, 13 Apr 2007 11:29:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <46098E8101A344BD@> (added by postmaster@domain.hid)
In-Reply-To: <46098E8101A344BD@> (added by postmaster@domain.hid)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai suspends my kernel thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Branko <branko.kolasinovic@domain.hid>
Cc: xenomai@xenomai.org

Branko wrote:
>> -----Original Message-----
>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
>> Sent: Thursday, April 12, 2007 11:16
>> To: Branko
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai-help] Xenomai suspends my kernel thread
>> 
>> Branko wrote:
>> 
>>>Hello all!
>>>
>>> 
>>>
>>>I would be most grateful for your help.
>>>
>>> 
>>>
>>>I ported my PowerPC GNU/Linux C/C++ application to Xenomai.
>>>
>>>When I ran the application everything looked fine.
>>>
>>>However, with more intense data exchange, one of my interrupt handler
>>>threads did not react any longer.
>>>
>>>I looked at the /var/log/messages file and I saw that Xenomai suspended
>>>my thread due to the exception 768.
>>>
>>> 
>>>
>>>According to
>>>https://mail.gna.org/public/xenomai-help/2006-11/msg00233.html I
>>>disabled CONFIG_XENO_OPT_DEBUG
>>>
>>>from my kernel configuration, but the behaviour of my application did
>>>not change.
>> 
>> What version of Xenomai do you use ? Does your application use fork ? If
>> yes, then you should switch to Xenomai 2.3.1.
>> 
> I use Xenomai 2.3.1. I don't use fork in my application.

Philippe, Wolfgang, any idea ?

-- 
                                                 Gilles Chanteperdrix

