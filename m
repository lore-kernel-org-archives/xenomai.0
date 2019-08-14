Subject: Re: [xenomai-images] smokey with qemu-arm and qemu-arm64 stalls gdb
 test
References: <10555689-1a2e-ad9b-d502-1d6696ea358e@siemens.com>
 <9aa0462d-b75b-a909-335f-406453140abd@siemens.com>
 <1274d6ea-f43d-e7e7-5ad8-07e6af07a4a5@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7d0e9a44-20a9-2d79-3a7d-faad0638d52f@siemens.com>
Date: Wed, 14 Aug 2019 12:32:00 +0200
MIME-Version: 1.0
In-Reply-To: <1274d6ea-f43d-e7e7-5ad8-07e6af07a4a5@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>, xenomai@xenomai.org

On 14.08.19 12:21, Quirin Gylstorff wrote:
> 
> 
> On 8/14/19 11:46 AM, Jan Kiszka wrote:
>> On 14.08.19 10:02, Quirin Gylstorff wrote:
>>> Hi,
>>>
>>> I tested smokey with qemu-amd64, qemu-arm and qemu-arm64 from xenomai-images 
>>> with the dh_strip patch active against master and had following results:
>>> qemu-amd64 - smokey run
>>> qemu-arm and qemu-arm64 stall with the attached output.
>>>
>>> Kind regards,
>>> Quirin
>>
>> Which kernel version(s) are showing this issue on arm[64]?
>>
> 
> On arm:
> Linux demo 4.14.85+ #1 SMP Tue Aug 13 16:57:48 UTC 2019 armv7l GNU/Linux

We need ipipe-core-4.14.96-arm-6 at least.

> On arm64:
> Linux demo 4.14.78+ #1 SMP PREEMPT Wed Aug 14 07:11:31 UTC 2019 aarch64 GNU/Linux
> 

Yeah, and we still need patches for arm64 in fact, analogously to 
https://gitlab.denx.de/Xenomai/ipipe-arm/commit/d36ce64b54b9f763fc337e70ebb313fba63f944a.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

