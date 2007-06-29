Message-ID: <4684C59E.2010901@domain.hid>
Date: Fri, 29 Jun 2007 10:41:02 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB14C@rennsmail04.eu.thmulti.com>
	<4680DA9B.5020501@domain.hid> <46838C9C.7030303@domain.hid>
	<4684BD02.1070002@domain.hid> <4684BEA9.1050705@domain.hid>
	<4684BFA5.8020005@domain.hid>
In-Reply-To: <4684BFA5.8020005@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Group-based RT caps
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
>   
>> Johan Borkhuis wrote:
>>     
>>> One thing I would like to see is to have the xenomai_gid parameter as a
>>> kernel config parameter, next to the module parameter. The default can
>>> be -1, but I would like to have my configured xenomai-group as the
>>> default value, so I don't have to pass an extra parameter or modify
>>> /sys/module/xeno_nucleus/parameters/xenomai_gid.
>>>       
>> Build the nucleus into the kernel, and you'll have it (with kernel 2.6
>> at least): "xeno_nucleus.xenomai_gid=<some-gid>"
>>     
>
> Sorry, I likely misunderstood your request. You mean a build-time config
> parameter? Hmm, that sounds a bit weird, given that you don't build your
> /etc/passwd or /etc/group into the kernel either, do you?
>
> Jan
>
>   
This was indeed what I meant. But I modified the default command line, 
which gives the same result.

I do have a standalone system where I can modify the group-file, so it 
is not a problem to have a fixed value for this option, as the 
xenomai-groups also has a fixed value.

Kind regards,
    Johan Borkhuis


