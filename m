Subject: Re: [PATCH] Allow RTNet to be builtin kernel
References: <30dd-5d94c580-17-21e4bb80@177052564>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8a055cb4-035b-605b-0a4a-90aba32a10a5@siemens.com>
Date: Wed, 2 Oct 2019 18:06:04 +0200
MIME-Version: 1.0
In-Reply-To: <30dd-5d94c580-17-21e4bb80@177052564>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>
Cc: Xenomai <xenomai@xenomai.org>

[re-adding the list]

On 02.10.19 17:43, François Legal wrote:
> Le Mercredi, Octobre 02, 2019 17:30 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit:
>   
>> On 02.10.19 15:45, François Legal via Xenomai wrote:
>>> From: François LEGAL <devel@thom.fr.eu.org>
>>>
>>> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
>>>
>>> Subject: [PATCH] Allow RTNet to be builtin kernel
>>>
>>
>> Proper ordering is
>>
>> - one subject (first line of your commit message)
>> - optionally a "From:", specifically when your provider rewrites the
>>     sender address
>> - commit message body
>> - signed-off
>> - separator ("---")
>> - optionally some message that should not be in git afterwards, e.g. a
>>     changelog of what you edited in this revision of the patch. I don't
>>     see all of my comments addressed in code. So you should at least tell
>>     us why you didn't change something.
>> - the diff
> 
> Allright. Thanks for the clarification and sorry to bother you with this kind of stuff.

No problem. This can be a lot when writing a first patch, even worse when that 
is "only" a short one, but it helps a lot to keep the project consistent.

> Regarding the comments in the patch, to be honest, I did not see those in the first place.
> Let me clarify these points here :
> 
>> Maybe we should add "set -x" to the script so that every unhandled failure becomes visible. Can be done separately, though.
> 
> Yes. I did that during testing but removed it afterwards. I thought leaving a set -x in would be a nogo for commit. I'll set it back.

With "can be done separately", I mean that such a change would be desired, not 
needed for this patch, and when done, it should come as an additional patch.

> 
>> rtpacket does not depend on rtipv4.
> 
> I thought the RT_PROTOCOLS would be in udp, icmp, (tcp maybe). I'll have to check how to address rtpacket.
> 
>> Reformatting is appreciated, but this is better done separately, to ease my review. :)
> 
> Got it. I'll restore the tabs.

You can also convert them to something consistent, but then please send two 
patches: One that only does the style conversion without functional changes, and 
one that does the other things.

> 
>> I think you are missing the rmmod in the "stop" path.
> 
> No, I made that intentionally, as the rmmod comes with -f plus > /dev/null
> I thought I could leave it here as any error would be silently discarded. Moreover, I'm not sure how I can handle it as the files/dirs I use to check if RTNet is builtin should probably appear whenever the modular RTNet gets loaded.

Ah, makes sense!

> 
> So if these replies are ok by you, I'll modify the patch and send it back to the list.

Yes, please.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

