Subject: Re: [PATCH] Re: Kernel crash at startup when enabling RTNet + RTIPv4
References: <b80-5d945480-e5-62bca880@213363268>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <07efe0e4-d2b3-e5c3-afa8-ed6c7f0de843@siemens.com>
Date: Wed, 2 Oct 2019 10:06:49 +0200
MIME-Version: 1.0
In-Reply-To: <b80-5d945480-e5-62bca880@213363268>
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
Cc: xenomai@xenomai.org

On 02.10.19 09:40, François Legal wrote:
> 
> Le Mardi, Octobre 01, 2019 16:37 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit:
>> On 01.10.19 15:26, François Legal wrote:
>> > Hello,
>> >
>> > Could you please clarify what "upstream" is ? RTNet project ? There does not
>> > seem to be activity there since 2012 ?
>>
>> RTnet was merged into Xenomai 2014. I thought you knew when you were posting
>> here ;).
> That's what I though, but I was surprised by the mention to "upstream".

Yeah, I didn't mean the upstream kernel - if that was your first thought.

>>
>> > I'll be happy to contribute on this. You mention "glue scripting", could you be
>> > more precise to let me try to fix that part too.
>>
>> xenomai/utils/net/rtnet.in. But I suspect that will be rather simple.
> So the attached patch (against master) allows one to get the RTNet code builtin, 
> plus the rtnet script modified to take that into account. I can make a patch to 
> 3.0.9 available if that's needed.
> About the stable init that does not depend on link order, I'll be glad to work 
> on that, but I need some hints on where to start if possible.

Just cross-checked with the kernel documentation, and it's actually correct to 
build the initialization order from the link order. So please format your 
changes into a proper patch against next, see CONTRIBUTING.md and also other 
patches on the list for the structuring.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

