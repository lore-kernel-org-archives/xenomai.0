Message-ID: <44195B05.2080900@domain.hid>
Date: Thu, 16 Mar 2006 13:33:09 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] newbie question
References: <0915ad1443edb7af745736fe4aaf3551@domain.hid>	<441949A0.8060100@domain.hid>
	<44194E3E.6040905@domain.hid>
In-Reply-To: <44194E3E.6040905@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Daniele Lugli <daniele.lugli@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Daniele Lugli wrote:
>>
>>>Hello all,
>>>I am new to xenomai although I have already used rtai.
>>>I see that xenomai has a user mode which looks equivalent to rtai's lxrt.
>>>What about calling real-time functions implemented in a module
>>>(rtai_lxrt call, rt_fun_entry table and so on)?
>>>Thank you,
>>>Daniele Lugli
>>>
>>>
>>
>>Have a look at the way a simple skin does it, e.g. ksrc/skins/uvm.
>>[...]
> 
> 
> But before going this way, first consider what kind of functions you
> exported so far via rt_fun_entry. If it was a driver API, you should
> better have a look at RTDM now.
> 

Yep. To be precise, RTDM is a particular skin in Xenomai terminology, that aims at 
providing a consistent interface and behaviour for writing real-time device 
drivers for Xenomai, so that at some point in time, we will hopefully have 
something resembling a standardized device driver factory. RTDM support is 
particularly well integrated with Xeno's POSIX real-time interface in user-space 
for instance.

-- 

Philippe.

