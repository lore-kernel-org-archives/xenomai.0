Message-ID: <46C07EDC.4040305@domain.hid>
Date: Mon, 13 Aug 2007 17:55:08 +0200
MIME-Version: 1.0
References: <46C02829.9020009@domain.hid>
	<46C04384.4030805@domain.hid>	<46C05180.5090302@domain.hid>
	<46C05690.2010108@domain.hid> <46C063E0.1010809@domain.hid>
	<46C07005.8000504@domain.hid>
In-Reply-To: <46C07005.8000504@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] [Ethercatmaster-users] EML conflict with RTCAN?
 low_level_input	framebuilding failed.
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid, EML users <ethercatmaster-users@domain.hid>

Hi

>> There is definitely something between the two that is not right.
>>
> 
> In 9 of 10 cases (if not more): timing. Running both alone doesn't
> expose some timing issue (race) or transient overload. I can't help with
> EML complaints, maybe the FMTC guys have an idea what can trigger this
> and how to debug it.
Out of interest, what timing exactly? These two systems (rtcan and eml) 
run separately, they don;t need to access the same address space or 
otherwise share resources that would require timing? What am I not 
understanding?



>>>>>> RTnet:rtskb allocation from real-time cache failed.
>> Could I get some tips as to what I can do about this? I seem to get it 
>> even when I do not have rtcan activity running in my application and 
>> (because I am clueless) I would like to prevent this message which may 
>> signify the root of the problem.
> 
> You have created the socket for some/all EML activity from primary mode
> of some Xenomai thread, 
100% correct.


thus network buffer allocation is ought to run
> against the real-time rtskb pool - which is by default empty :p. See
> README.pools from the RTnet documentation on this.


> I don't have the EML design at hand, but you might be able to avoid this
> by initialising before creating the shadow task or by explicitly
In fact this is what I tried initially. IT does not work at all. so I 
ended up initializing in the thread. Problem?

Is this allocation possibly the cause of the problem or is the rtnet 
warning harmless? At least it is not related to rtcan in any manner 
because it appears even if rtcan is not activated in the application.

Roland



> switching to secondary mode before initialising. [Sorry for this issue,
> it's at least partly due to some outdated RTnet design.]
> 
> Jan
> 

