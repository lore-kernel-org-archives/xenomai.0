From: Andreas Glatz <andreasglatz@domain.hid>
Date: Fri, 12 Feb 2010 18:36:23 -0500
Message-ID: <1266017786-26290-1-git-send-email-andreasglatz@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai-help] Kernel oops when reading /proc/xenomai/stats
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

>> Hi,
>>
>>>>>> That's the kernel oops with additional debugging info (starts with 'HUHU' - see code below
>+the oops):
>>>>>>
>>>>>> HUHU count=1 xnintr_count=-12
>>>>> That's not good. What is your Xenomai version?
>>>> Hardware=MPC8360, Linux=2.6.32, Xenomai=2.4.10, ipipe=2.8-00
>>>>
>>>>> Does everything work fine if you application terminates normally and
>>>>> deletes the rt_intr objects explicitly?
>>>> Checking...
>>>>
>>> And then you may want to track this down at the site that decrements
>>> xnintr_count, ie. rt_intr_delete -> xnintr_detach.
>>
>> This Email contains three patches.
>
>Good catches! But please post them as separated patches following the
>well-know standards (proper subject, a short description, signed-off,
>inlined patch against xenomai.git).

Hope the format is ok now.

Andreas



