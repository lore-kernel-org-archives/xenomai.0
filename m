Message-ID: <43553B94.4070801@domain.hid>
Date: Tue, 18 Oct 2005 20:14:44 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai latency tests on various PowerPC boards
References: <4354C0A9.5060901@domain.hid> <4354DB29.9060004@domain.hid>
	<4354E039.9010305@domain.hid> <4354E6A3.2010500@domain.hid>
In-Reply-To: <4354E6A3.2010500@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
> On 10/18/2005 01:44 PM Philippe Gerum wrote:
> 
>>Philippe Gerum wrote:
>>
>>>Wolfgang Grandegger wrote:
>>>
>>>
>>>>Hallo,
>>>>
>>>>attached you will find the results of Xemonai latency measurements on
>>>>various embedded PowerPC boards using MPC 8xx and AMCC 4xx processors,
>>>>from low to high end covering a worst case latency range from 25 to 225
>>>>us. It also includes a comparison with RTAI 3.0r5 on the slowest CPU.
>>>>Here are some remarks and comments:
>>>>
>>>>- On low-end processor code size matters a lot and it's difficult to
>>>>  beat RTAI/RTHAL.
>>>>
>>>
>>>Beat no, get closer, yes, probably. The good news is that looking at the 
>>>figures, we do have a margin of improvement! :o>
>>>
>>>Btw, the nucleus can be configured so that the user-space threading 
>>>engine is compiled out (i.e. CONFIG_XENO_OPT_PERVASIVE from the nucleus 
>>>menu), which would be the corresponding profile to compare with klatency 
>>>(i.e. sched_up). Disabling this option reduces the code size for the 
>>>nucleus from:
>>>
>>>   text       data        bss        dec        hex    filename
>>>  66740        792       6540      74072      12158    
>>>nucleus/xeno_nucleus.ko
>>>
>>>to:
>>>
>>>  text       data        bss        dec        hex    filename
>>>  52596        576       3956      57128       df28    
>>>nucleus/xeno_nucleus.ko
>>>
>>
>>Disabling the periodic timer support which is unused for the klatency test 
>>brings this down to:
>>
>>    text	   data	    bss	    dec	    hex	filename
>>   51040	    544	   3956	  55540	   d8f4	nucleus/xeno_nucleus.ko
> 
> 
> OK, here are the new figures with (*)
> 
>  CONFIG_XENO_OPT_PERVASIVE is not set
>  CONFIG_XENO_HW_PERIODIC_TIMER is not set:
> 
>            |-----lat min|-----lat avg|-----lat max|-overrun|---test-time
> RTAI 3.0r5 |       23120|       31838|       70520|       ?|    00:12:26
> Xenomai    |       50560|       98976|      199040|       0|    00:09:45
> Xenomai (*)|       44160|       96215|      200640|       0|    00:09:53
> 
> The min latency decreases as expected.
> 

I just discovered that -00 did not include some recent changes I had in my tree, 
aimed at prevent high latencies during fork pressure. I've committed -01 which 
does include them. When time allows, I'd be interested to know if this has some 
impact on the Ocotea figures. TIA,

-- 

Philippe.

