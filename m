References: <2dce9fd3-bc7e-d308-4485-7f7fe4df5eb7@alstefgroup.com>
 <98f70f97-142c-1f18-f3cb-9cccf1bf55ca@siemens.com>
 <87zgxj3b3v.fsf@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Updating fec driver for kernel 5.4 and I.MX8Q
In-reply-to: <87zgxj3b3v.fsf@xenomai.org>
Date: Tue, 27 Apr 2021 19:29:11 +0200
Message-ID: <87wnsn3ac8.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Jean-Baptiste Tredez <jean-baptiste.tredez@alstefgroup.com>, xenomai@xenomai.org


Philippe Gerum via Xenomai <xenomai@xenomai.org> writes:

> Jan Kiszka via Xenomai <xenomai@xenomai.org> writes:
>
>> On 26.04.21 14:21, Jean-Baptiste Tredez via Xenomai wrote:
>>> Hello,
>>> 
>>> Do you have plans for updating fec drivers on xenomai 3.1 ?
>>> 
>>> We tried to merge uptream linux driver and Philippe Gerum work (commit
>>> 1b7a4bd9598aa0d777016fda7e51d2e22aa51e77). Here is the result, it seems
>>> to work on kernel 5.4 (I.MX8Q target).
>>> 
>>> Any testing / help to improve this driver is welcomed.
>>> 
>>
>> Unfortunately, the change you shared is massive and does not apply at
>> all to Xenomai (you patched in the kernel tree, not in Xenomai). Could
>> you rebase over next and provide that as patch for review?
>>
>> I do not have any test targets, so we would definitely need feedback
>> from other users if there are no regressions. But as the change is so
>> significant, that will likely remain a 3.2 topic, nothing for stable
>> anymore (unless you can prove that current 3.1 is broken for anyone).
>>
>
> This is a complete rewrite of the RTnet driver for FEC, rebasing over
> 4.14.85 required just that unfortunately. This updated driver is part of
> a larger patch set mostly written by Gilles, I ported from Xenomai 2.6.x
> to 3.x some time ago. He added support for multicast and VLANs to RTnet;
> the code was contributed to us by iXblue (https://ixblue.com) who funded
> the initial development for 2.x.

And the port to 3.x as well.

>
> It may be better to review and consider the whole set once rebased on
> -next at some point, since there may be some dependencies on other
> patches from the same set.


-- 
Philippe.

