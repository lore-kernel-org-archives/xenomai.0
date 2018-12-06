Subject: Re: [I-PIPE] ipipe-core-4.9.135-x86-7 released
References: <E1gHtmu-0002xR-FI@xenomai.org>
 <653100543.20966555.1541129646273@mail.yahoo.com>
 <009db19b-cb18-095c-2fda-eb9beaa7767c@siemens.com>
 <1378793b-2c18-1e51-937c-3ce14a7bb9e9@xenomai.org>
 <af13cc5e-a076-5618-e8f2-a62284a8493c@xenomai.org>
 <1782609254.2693150.1544069354612@mail.yahoo.com>
 <648d4857-fd53-7cbf-974f-e18ce5759f71@linx-info.com>
 <1139e58e-ca54-29cf-119a-3be099b9ff38@siemens.com>
 <ca1cbe13-9c2d-8b0d-933f-f5a5da27b70d@linx-info.com>
 <15d77171-f5c9-e69b-3e10-dec6ada23e39@siemens.com>
From: duanwujie <wjduan@linx-info.com>
Message-ID: <719a212a-ce87-49af-23f1-41f4bd02c4e4@linx-info.com>
Date: Thu, 6 Dec 2018 15:18:26 +0800
MIME-Version: 1.0
In-Reply-To: <15d77171-f5c9-e69b-3e10-dec6ada23e39@siemens.com>
Content-Language: en-US
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>, =?UTF-8?B?5b2t5b+X6Iiq?= <zhpeng@linx-info.com>, yuening <ynliu@linx-info.com>

I am not so sure, bellow code exist in ipipe-core-4.9.51-x86-2.patch but 
ipipe-core-4.9.135-x86-7.patch didn't。

arch/x86/include/asm/fpu/internal.h:

#ifdef CONFIG_IPIPE
static inline union fpregs_state *active_fpstate(struct fpu *fpu)
{
return fpu->active_state;
}
#else
static inline union fpregs_state *active_fpstate(struct fpu *fpu)
{
return &fpu->state;
}
#endif

在 2018/12/6 下午3:06, Jan Kiszka 写道:
> On 06.12.18 08:04, duanwujie wrote:
>> It seem to forget port the arch/x86/include/asm/fpu/internal.h in the 
>> ipipe-core-4.9.135-x86-7.patch
>>
>
> You mean that file is missing in the generated patch?
>
> Jan
>
>>
>> 在 2018/12/6 下午3:00, Jan Kiszka via Xenomai 写道:
>>> On 06.12.18 06:45, limingyu via Xenomai wrote:
>>>> I have used this patch(ipipe-core-4.9.135-x86-7.patch) for a test 
>>>> usage and I got a machine halt after I run the latency test program 
>>>> of Xenomai.The problem seems caused by  the fpu_restore function. 
>>>> Could you please fix it in the next patch release?
>>>
>>> Did you also update Xenomai to the latest stable or master branch 
>>> state? That is required on x86.
>>>
>>> Jan
>>>
>> -- 
>> *Linx Software Corportaion Sichuan Branch
>> Name：wujie duan
>> Tel：028-65182023-6202
>> E-mail: wjduan@linx-info.com
>> *
>
-- 
*Linx Software Corportaion Sichuan Branch
Name：wujie duan
Tel：028-65182023-6202
E-mail: wjduan@linx-info.com
*
