Message-ID: <4CB45B06.2070905@domain.hid>
Date: Tue, 12 Oct 2010 14:56:38 +0200
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4CB33738.206@domain.hid>	<4CB338AB.3070803@domain.hid>	<4CB339F9.5080202@domain.hid>	<4CB33F04.3000600@domain.hid>	<4CB34031.5090505@domain.hid>	<4CB3424A.5090504@domain.hid>
	<4CB4299D.70600@domain.hid> <4CB43704.4020504@domain.hid>
In-Reply-To: <4CB43704.4020504@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and capabilities
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2010-10-12 12.23, Anders Blomdell wrote:
> On 2010-10-12 11.25, Anders Blomdell wrote:
>> On 2010-10-11 18.58, Jan Kiszka wrote:
>>> Am 11.10.2010 18:49, Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Am 11.10.2010 18:23, Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> enabling the Xenomai watchdog should provide a reasonably safe&secure
>>>>>>> environment.
>>>>>> AFAIK, the BIG FAT warning at the bottom of this page still applies. You
>>>>>> can make an environment with no hardware lockups, but secure, I do not
>>>>>> think so. We do not know how Xenomai APIs could be exploited for a
>>>>>> non-root user to become root.
>>>>>
>>>>> For sure, no one audited the interface for security so far. There is no
>>>>> hole in design that comes to my mind ATM, but I would be surprised as
>>>>> well if you couldn't develop any exploit for some bug or missing check.
>>>>> Still, there is a huge difference between giving anyone root access and
>>>>> confining Xenomai access this way.
>>>>
>>>> I was just reacting to "reasonably secure". The experience proves that
>>>> if you do not do any particular effort for security, then your code is
>>>> not secure. Not even reasonably.
>>>
>>> This is no black-or-white domain, and I wouldn't say we spend no effort
>>> on security at all. We do have interest in making the userspace APIs
>>> robust which addresses security up to a certain level as well.
>>>
>>> What is still definitely not secure, though, is RTnet as it consequently
>>> lacks any kind of check on user-passed addresses. But that's not
>>> Xenomai's fault (rather mine).
>> If I understand manpages and code correctly, xenomai is insecure by design (not
>> a major problem here, I hope), but I had hoped to be able to avoid CAP_SYS_RAWIO
>> which I think is the biggest security problem (access to /proc/kcore IS scary),
>> but since CAP_SYS_NICE implies CAP_SYS_RAWIO via shadow.c:
>>     if (!capable(CAP_SYS_NICE) &&
>>         (xn_gid_arg == -1 || !in_group_p(xn_gid_arg)))
>>         return -EPERM;
>>
>>      wrap_raise_cap(CAP_SYS_NICE);
>>      wrap_raise_cap(CAP_IPC_LOCK);
>>      wrap_raise_cap(CAP_SYS_RAWIO);
>>
>> I will go for the group thing (simple and totally insecure) for now, and put
>> some more thought into it later on.
> Well, obviously this feature is somewhat broken:
> 
>> testprog
> Xenomai: binding failed: Cannot allocate memory.
> 
> This is what syslog says:
> Xenomai: testprog[2367] cannot map MAYDAY page
> 
> Running as root works as it should.
CAP_DAC_OVERRIDE fixes this issue (and how safe is that :-( )

How necessary are CAP_SYS_RAWIO and CAP_DAC_OVERRIDE [the two capabiltities i
think have the most severe security implications] when main has started running,
i.e. could I drop them after initialization and still do something useful?

/Anders

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

