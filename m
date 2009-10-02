Message-ID: <4AC65CEB.7080107@domain.hid>
Date: Fri, 02 Oct 2009 22:04:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4AC61F57.2010404@domain.hid> <4AC62804.7090903@domain.hid>
	<4AC62B41.3050404@domain.hid> <4AC65172.8060900@domain.hid>
In-Reply-To: <4AC65172.8060900@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RTDM fd support.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Hi Jan,
>>>>
>>>> from discussions on the mailing list, it seems that we are going to need
>>>> that unified file descriptors thing. However, since everybody wants
>>>> 2.5.0 to be released ASAP, we should try to think about any changes for
>>>> this support which would break the ABI, do them now, and keep the rest
>>>> for later.
>>>>
>>>> One such problem is the translation which currently exists between rtdm
>>>> file descriptors and descriptors passed to the posix skin, by adding
>>>> 1024 - 128. So, I propose to fix this issue.
>>>>
>>>> The idea Philippe had, and which I tend to agree to, was, in case of
>>>> open/socket/accept, to open("/dev/null"), and use an association table
>>>> somewhere to associate with the kernel-space descriptor number. Since
>>>> we are at it, this association table could in fact be the file
>>>> descriptor table, which we would put in the core skin ppd. The actual
>>>> data structure should be sparse, a linked list does not scale, so,
>>>> probably a hash would do. (I could also propose a solution based on avl
>>>> trees, but their implementation is not nearly as simple).
>>>>
>>>> Additionnally, this would allow our open/socket to conform to posix
>>>> which states that open should return the lowest free file descriptor.
>>>>
>>>> Should I propose a patch in that direction? Do you see any other
>>>> possible cause of ABI breakage when we migrate to an unified file
>>>> descriptors structure?
>>> Right now this sounds like a plan - but I don't feel 100% comfortable to
>>> predict that we will get along with it. Converting some skin-specific
>>> service to a generic one involves quite a lot of refactoring. It is not
>>> really unlikely that we define some ABI now that will later turn out to
>>> be insufficient for what we want to achieve.
>> For the posix skin, I can live with a two hops solution right now, and
>> implement the one-hop solution later.
>>
>> user-space fd
>>       |
>>       | core skin fd table
>>       v
>> kernel-space fd
>>       |
>>       | posix skin registry
>>       v
>> actual object
>>
>> If we do this, there is not much re-factoring involved.
>>
>> The question really boils down to whether you accept this solution for
>> the rtdm skin too.
> 
> Let me check if I got the idea: the first change would only modify the
> librtdm and the rtdm part of libpthread_rt, right?

The idea was to also modify the kernel-space skins. Only make it
superficial: only modify the part which communicates the file
descriptors to user-space, to include a lookup through the fd table.

So, this means that when a user-space applications calls read() for
instance, the fd table is used to get the kernel-space RTDM descriptor,
and then the internal functions of the RTDM skin, go through their own
lookup mechanim to get the actual object.

So, there are two lookups, that is the two hops I was talking about. I
was worried that you would not like the impact on performance.

-- 
					    Gilles.

