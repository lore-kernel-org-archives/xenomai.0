Subject: Re: [PATCH] linux-xenomai: correct pull of 4.14 arm64 kernel
References: <20190910124526.21953-1-Quirin.Gylstorff@siemens.com>
 <769c9d8d-0d25-d2fb-fc99-bbad8aacbcd0@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6287c5bd-2fd7-58c8-246d-d2937ce07d54@xenomai.org>
Date: Thu, 12 Sep 2019 20:36:40 +0200
MIME-Version: 1.0
In-Reply-To: <769c9d8d-0d25-d2fb-fc99-bbad8aacbcd0@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org

On 9/10/19 2:50 PM, Jan Kiszka wrote:
> On 10.09.19 14:45, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> The arm64 4.14 kernel cannot currently not be build. Use tag instead
>> of branch + commit.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   recipes-kernel/linux/linux-xenomai_4.14.bb | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/recipes-kernel/linux/linux-xenomai_4.14.bb
>> b/recipes-kernel/linux/linux-xenomai_4.14.bb
>> index 14030d6..f147eed 100644
>> --- a/recipes-kernel/linux/linux-xenomai_4.14.bb
>> +++ b/recipes-kernel/linux/linux-xenomai_4.14.bb
>> @@ -15,8 +15,7 @@ SRC_URI_append_amd64 = "
>> git://gitlab.denx.de/Xenomai/ipipe-x86.git;protocol=htt
>>   SRCREV_amd64 = "fdfa1aff4578edf6a03e2e77ea20bf7f97863954"
>>   PV_amd64 = "4.14.134+"
>>   -SRC_URI_append_arm64 = "
>> git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;branch=stable/4.14.78-arm64"
>>
>> -SRCREV_arm64 = "dec5e42fd43de238df816b31cadfb83b268b7136"
>> +SRC_URI_append_arm64 = "
>> git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;nobranch=1;tag=ipipe-core-4.14.78-arm64-2"
>>
>>   PV_arm64 = "4.14.78+"
>>     SRC_URI_append_armhf = "
>> git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;branch=stable/4.14.96-arm"
>>
>>
> 
> OK, regression due to ipipe-arm64 repo refactoring. Merged.
> 
> Philippe, is it by intention that ipipe-core-4.14.78-arm64-2 is not
> branch-wise orphaned?
> 

Yes, I don't think there is going to be zillions of tags anyway, and
having to rely on an external patch file picked from the dl area for
testing some older release is not that handy. So let's rely on git for
that too.

-- 
Philippe.

