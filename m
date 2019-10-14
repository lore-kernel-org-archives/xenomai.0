Subject: Re: [PATCH] kernel/linux: Update arm kernels
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <20191014080708.23033-1-Quirin.Gylstorff@siemens.com>
 <11dbc220-d10d-75a9-ac79-7a6b978f54fe@siemens.com>
Message-ID: <a4c48259-2ffc-0bf9-d545-cacde8672bac@siemens.com>
Date: Mon, 14 Oct 2019 15:09:40 +0200
MIME-Version: 1.0
In-Reply-To: <11dbc220-d10d-75a9-ac79-7a6b978f54fe@siemens.com>
Content-Type: text/plain; charset=utf-8
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
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org

On 14.10.19 13:57, Jan Kiszka wrote:
> On 14.10.19 10:07, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Update arm/arm64 Linux kernel to new versions.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  recipes-kernel/linux/linux-xenomai_4.19.bb | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/recipes-kernel/linux/linux-xenomai_4.19.bb b/recipes-kernel/linux/linux-xenomai_4.19.bb
>> index 1607c58..8623f1b 100644
>> --- a/recipes-kernel/linux/linux-xenomai_4.19.bb
>> +++ b/recipes-kernel/linux/linux-xenomai_4.19.bb
>> @@ -16,12 +16,12 @@ SRCREV_amd64 ?= "f83bda3e0785ae2e0ea8ad530bc903d2b420c2c7"
>>  PV_amd64 ?= "4.19.66+"
>>  
>>  SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;nobranch=1"
>> -SRCREV_arm64 ?= "ipipe-core-4.19.55-arm64-2"
>> +SRCREV_arm64 ?= "ipipe-core-4.19.55-arm64-4"
>>  PV_arm64 ?= "4.19.55+"
>>  
>>  
>>  SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;nobranch=1"
>> -SRCREV_armhf ?= "ipipe-core-4.19.55-arm-3"
>> +SRCREV_armhf ?= "ipipe-core-4.19.55-arm-5"
>>  PV_armhf ?= "4.19.55+"
>>  
>>  S = "${WORKDIR}/git"
>>
> 
> Thanks, applied.
> 
> How do I find out with revision of I-pipe is used during a test? For
> Xenomai, there is that git revision dump during the build. But I think
> we are missing something for I-pipe.
> 
> Background: arm64 test still fails.

Oh, we aren't building latest kernels here. So this patch should resolve
the remaining arm64 failure.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

