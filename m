From: Jean-Baptiste Tredez <jean-baptiste.tredez@alstefgroup.com>
Subject: Re: Updating fec driver for kernel 5.4 and I.MX8Q
References: <2dce9fd3-bc7e-d308-4485-7f7fe4df5eb7@alstefgroup.com>
 <98f70f97-142c-1f18-f3cb-9cccf1bf55ca@siemens.com>
 <87zgxj3b3v.fsf@xenomai.org> <87wnsn3ac8.fsf@xenomai.org>
Message-ID: <134ed1e6-36e6-7e98-5f00-ec1ce04e46c1@alstefgroup.com>
Date: Thu, 29 Apr 2021 11:20:46 +0200
In-Reply-To: <87wnsn3ac8.fsf@xenomai.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org


Le 27/04/2021 à 19:29, Philippe Gerum a écrit :

> Philippe Gerum via Xenomai<xenomai@xenomai.org>  writes:
>
>> Jan Kiszka via Xenomai<xenomai@xenomai.org>  writes:
>>
>>> On 26.04.21 14:21, Jean-Baptiste Tredez via Xenomai wrote:
>>>> Hello,
>>>>
>>>> Do you have plans for updating fec drivers on xenomai 3.1 ?
>>>>
>>>> We tried to merge uptream linux driver and Philippe Gerum work (commit
>>>> 1b7a4bd9598aa0d777016fda7e51d2e22aa51e77). Here is the result, it seems
>>>> to work on kernel 5.4 (I.MX8Q target).
>>>>
>>>> Any testing / help to improve this driver is welcomed.
>>>>
>>> Unfortunately, the change you shared is massive and does not apply at
>>> all to Xenomai (you patched in the kernel tree, not in Xenomai). Could
>>> you rebase over next and provide that as patch for review?
>>>
>>> I do not have any test targets, so we would definitely need feedback
>>> from other users if there are no regressions. But as the change is so
>>> significant, that will likely remain a 3.2 topic, nothing for stable
>>> anymore (unless you can prove that current 3.1 is broken for anyone).
>>>
>> This is a complete rewrite of the RTnet driver for FEC, rebasing over
>> 4.14.85 required just that unfortunately. This updated driver is part of
>> a larger patch set mostly written by Gilles, I ported from Xenomai 2.6.x
>> to 3.x some time ago. He added support for multicast and VLANs to RTnet;
>> the code was contributed to us by iXblue (https://ixblue.com) who funded
>> the initial development for 2.x.
> And the port to 3.x as well.

On xenomai 3.1, current fec driver seems broken, XENO_DRIVERS_NET_DRV_FEC is not in kconfig (fec driver can't be selected) and indeed, if you add the option in kconfig file, the old driver does not compile for kernel 5.4.

>> It may be better to review and consider the whole set once rebased on
>> -next at some point, since there may be some dependencies on other
>> patches from the same set.

Ok, I will rebase on the whole set on next.

