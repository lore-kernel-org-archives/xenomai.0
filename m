Subject: Re: Xenomai kernel for BBB
References: <CAFc1U0uSt1WVzeDWfzPp+07SqCD=t=ET8X+2NXieYE0WE66Xfw@mail.gmail.com>
 <4a8a6ec5-cc87-19b5-3ebe-8d0d6da6027b@xenomai.org>
 <072ec5f2-7bee-9cca-cdb6-040bb3afa59d@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <21a9ee2c-90e7-b6f3-f0cd-f57277f20a57@siemens.com>
Date: Thu, 4 Apr 2019 10:40:13 +0200
MIME-Version: 1.0
In-Reply-To: <072ec5f2-7bee-9cca-cdb6-040bb3afa59d@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai@xenomai.org

On 04.04.19 10:31, Philippe Gerum via Xenomai wrote:
> On 4/3/19 7:16 PM, Philippe Gerum wrote:
>> On 4/3/19 9:55 AM, Pierre FICHEUX via Xenomai wrote:
>>> Hi,
>>>
>>> Xenomai kernel (-xenomai branches) is available for BBB (AM335x) from
>>> https://github.com/beagleboard/linux for some kernel releases (4.4, 4.9,
>>> 4.14). I've tried 4.9 and 4.14 but jitter is very bad with latency tool (>
>>> 200 µs).
>>>
>>> According to Xenomai wiki, AM335x SoC is supported for "vendor branch",
>>> hope this is the same thing (?)
>>>
>>> Dos anybody use AM335x with success? I did it a long time ago with Xenomai
>>> 2 and 3.8.13 kernel.
>>>
>>
>> CONFIG_ARM_CPUIDLE hurts badly on this platform, disabling it restores
>> proper latency figures.
>>
>> A quick port of the latest I-pipe code ported to the bbb kernel 4.14 can
>> be pulled from this URL (lightly tested):
>> https://lab.xenomai.org/ipipe-rpm.git/log/?h=arm/4.14.110-bbb
>>
> 
> too much haste: clone from [1], branch arm/4.14.108-bbb, which is based
> on the 4.14 branch of the Beagleboard tree (as of yesterday).
> 
> [1] git://lab.xenomai.org/ipipe-rpm.git
> 

Does the BBB really still need a vendor kernel? Definitely not for booting and 
core functionality.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

