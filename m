Message-ID: <44E36CBB.2030006@domain.hid>
Date: Wed, 16 Aug 2006 21:06:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Time representation in RTDM profiles
References: <44E2DC1C.2010304@domain.hid>	<200608161305.54411.Sebastian.Smolorz@domain.hid>	<44E32B21.8060508@domain.hid>
	<200608162020.45918.Sebastian.Smolorz@domain.hid>
In-Reply-To: <200608162020.45918.Sebastian.Smolorz@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Sebastian Smolorz wrote:
> Jan Kiszka wrote:
>> Sebastian Smolorz wrote:
>>> Jan Kiszka wrote:
>>>> Sebastian Smolorz wrote:
>>>>> The possibility of redefinition was not the main goal here. As you
>>>>> mentioned it would be problematic. No, I introduced nanosecs_abs_t and
>>>>> nanosecs_rel_t because they are more intuitive and more "speaking" to
>>>>> the programmer. The meaning of a variable of such a type is clear at
>>>>> first sight.
>>>> Yeah, sounds reasonable to me. Then let's move these typedefs to rtdm.h
>>>> and document them as self-explanatory defines of the underlying standard
>>>> types, freezing their width and signedness at the same time.
>>> Agreed.
>>>
>>>> Actually, this would be useful for the driver API of RTDM as well.
>>> That's right. No objections from my side.
>> Done.
>>
>> Though I checked things more then twice, some regression may be hidden,
>> specifically as I changed the signedness of timeout parameters of a few
>> RTDM driver API functions. All documented under
>> ksrc/skins/rtdm/API.CHANGES, and everyone is warned now.
> 
> Here comes a follow-up patch. Compile-tested successfully.
> 

Just applied, thanks.

[I thought about dropping the RTSER_TIMEOUT_* stuff as well, but A)
there are already users and B) it aligns so well with the other defines
for rtser_config.]

Jan

