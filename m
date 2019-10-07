Subject: Re: [ANNOUNCE] Xenomai v3.1-rc2 available
References: <4151508e-0c0e-1460-dca4-9479324ff206@siemens.com>
 <6107e974-260c-2793-a55b-0f1b887a2880@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2b736e19-9e5e-af68-d7eb-30a432e04caa@siemens.com>
Date: Mon, 7 Oct 2019 16:25:44 +0200
MIME-Version: 1.0
In-Reply-To: <6107e974-260c-2793-a55b-0f1b887a2880@siemens.com>
Content-Type: text/plain; charset="utf-8"
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
To: Xenomai <xenomai@xenomai.org>

On 07.10.19 15:18, Jan Kiszka via Xenomai wrote:
> On 07.10.19 14:43, Jan Kiszka wrote:
>> Hi all,
>>
>> just pushed another release candidate, this time hopefully more properly
>> formatted.
> 
> Well, no, it's even more broken: The release string, no "properly"
> stored in config/version-*, is not compatible with prepare-kernel.sh,
> and that prevents any kernel build. A fix will follow.
> 

If you want to try out -rc2 (which would be appreciated), please apply
[1] on top.

Jan

[1] https://xenomai.org/pipermail/xenomai/2019-October/041751.html

> 
>>
>> https://gitlab.denx.de/Xenomai/xenomai/-/archive/v3.1-rc2/xenomai-v3.1-rc2.tar.bz2
>> https://gitlab.denx.de/Xenomai/xenomai/commits/v3.1-rc2
>>
>> Changes since rc1:
>>
>> François LEGAL (1):
>>       Make MACB driver compliant with GEM hardware
>>
>> Jan Kiszka (4):
>>       Bump ABI revisions
>>       cobalt: Add _CC_COBALT_DEBUG_SYNC_BP feature
>>       testsuite/smokey/gdb: Only run basic test if _CC_COBALT_DEBUG_SYNC_BP is missing
>>       config: Bump version number
>>
>> Quirin Gylstorff (1):
>>       testsuite/xeno-test: add --vm option
>>
>> There are some open bug reports waiting for further information.
>> Otherwise, things look good for finalizing the release rather sooner
>> than later.
>>
>> Jan
>>
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

