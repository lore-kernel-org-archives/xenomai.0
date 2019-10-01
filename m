Subject: Re: Kernel crash at startup when enabling RTNet + RTIPv4
References: <b7f-5d935400-4b-344a2840@235460703>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1e32b0f4-a1e9-cd72-7024-974308b09d3f@siemens.com>
Date: Tue, 1 Oct 2019 16:37:59 +0200
MIME-Version: 1.0
In-Reply-To: <b7f-5d935400-4b-344a2840@235460703>
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

On 01.10.19 15:26, François Legal wrote:
> Hello,
> 
> Could you please clarify what "upstream" is ? RTNet project ? There does not 
> seem to be activity there since 2012 ?

RTnet was merged into Xenomai 2014. I thought you knew when you were posting 
here ;).

> I'll be happy to contribute on this. You mention "glue scripting", could you be 
> more precise to let me try to fix that part too.

xenomai/utils/net/rtnet.in. But I suspect that will be rather simple.

More tricky is a stable init ordering, ideally something that does not depend on 
link ordering. And maybe there is more.

> 
> Shall I send the patch to this list ?

Exactly. Against the master branch. If it's a fix, we can consider backporting 
to 3.0.x and 3.1.x (3.1 is already in feature freeze state).

Jan

> 
> Thanks
> 
> François
> 
> Le Mardi, Octobre 01, 2019 15:10 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit:
>> On 01.10.19 15:04, François Legal via Xenomai wrote:
>> >
>> > Hello list,
>> >
>> > I've been struggling to get the RTNet + RTIPv4 part to work on a Zynq 7000 
>> board. Using source code from stable Xenomai 3.0.9 tarball, and patching a 
>> vanilla 4.4.189 linux.
>> > I consistently had the kernel crash (0 pointer dereference error) at startup 
>> when enabling either RTIPv4, RTCFG or RTMAC.
>> >
>> > I finally found that there "might" be a problem with the Makefile 
>> in kernel/drivers/net/stack.
>> > It turns out that (on my system at least), the order in which the protocol 
>> stacks appear in the Makefile is wrong because (I running a kernel with 
>> everything builtin, no modules) the protocols are loaded in that order, and 
>> thus, (in my case) RTIPv4 gets initialized before stack_mgr does which cause 
>> it to fail while registering (calling __rtdev_add_pack with a not 
>> initialized rt_packets array).
>> >
>> > When I reorder the protocols in the Makefile, everything works flawlessly.
>> >
>> > I can provide a patch if this needs to be fixed.
>> >
>>
>> Upstream does not support built-in RTnet. I suspect we need to sort this and
>> more issues out systematically in order to permit that. Also, the glue scripting
>> will need adjustments because of assumptions that RTnet comes in modules.
>>
>> That said, contributions in that directions are welcome!
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>> Corporate Competence Center Embedded Linux
> 
> 
> 


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

