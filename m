Message-ID: <4DA2C94C.1010005@domain.hid>
Date: Mon, 11 Apr 2011 11:26:36 +0200
From: Jesper Christensen <jbc@domain.hid>
MIME-Version: 1.0
References: <4D9F0679.7080109@domain.hid>	<20110408191529.GA2802@domain.hid>	<4DA2A514.4090702@domain.hid>	<20110411065527.GA3617@domain.hid>
	<4DA2A6D0.8000705@domain.hid> <4DA2C767.3070507@domain.hid>
In-Reply-To: <4DA2C767.3070507@domain.hid>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] kernel threads crash
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Yeah we've been stupid enough not to use the version from the git
repository, but i'll see what i can do over the next few days (snowed
under at work :(  ). I should be able to do some diffs against the git
repository.

/Jesper


On 2011-04-11 11:18, Jan Kiszka wrote:
> On 2011-04-11 08:59, Jesper Christensen wrote:
>   
>> There you go.
>>
>>     
> Even better would be individual patches (one for each topic) so that we
> can more easily review/merge your improvements into RTnet. If you are
> not familiar with this process, maybe you can convince Richard to do the
> break-up... :)
>
> Also, please follow up on RTnet-list(s) about RTnet topics.
>
> TIA,
> Jan
>
>   
>> On 2011-04-11 08:55, Richard Cochran wrote:
>>     
>>> On Mon, Apr 11, 2011 at 08:52:04AM +0200, Jesper Christensen wrote:
>>>   
>>>       
>>>> I have made a number of changes to rtnet (scatter gather support, icmp
>>>> fixes etc.) so maybe i could send you a tar ball of the entire directory?
>>>>     
>>>>         
>>> Yes, please do.
>>>
>>> thanks,
>>> Richard
>>>
>>>   
>>>       
>>>> On 2011-04-08 21:15, Richard Cochran wrote:
>>>>     
>>>>         
>>>>> On Fri, Apr 08, 2011 at 02:58:33PM +0200, Jesper Christensen wrote:
>>>>>
>>>>>   
>>>>>       
>>>>>           
>>>>>> I have ported the "gianfar" driver from linux to rtnet.
>>>>>>     
>>>>>>         
>>>>>>             
>>>>> Can you publish this driver? I have been wanting to make a rtnet
>>>>> gianfar myself.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Richard
>>>>>
>>>>>   
>>>>>       
>>>>>           
>   


