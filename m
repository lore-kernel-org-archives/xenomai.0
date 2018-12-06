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
 <719a212a-ce87-49af-23f1-41f4bd02c4e4@linx-info.com>
 <12f81dbf-16d9-dc28-5fff-6d91d58ce2c1@siemens.com>
 <6bed742a-92a3-1ec1-1be2-09ce407ac2ec@linx-info.com>
 <9e97f42e-00f9-d709-2105-526d4325e40f@siemens.com>
From: duanwujie <wjduan@linx-info.com>
Message-ID: <a427034a-6d5d-ac38-99ec-ed7f02992bf7@linx-info.com>
Date: Thu, 6 Dec 2018 16:58:18 +0800
MIME-Version: 1.0
In-Reply-To: <9e97f42e-00f9-d709-2105-526d4325e40f@siemens.com>
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

We test the  ipipe-core-4.9.135-x86-7  with the latest branch 
stable/v3.0.x but the same error occur !


在 2018/12/6 下午3:26, Jan Kiszka 写道:
> On 06.12.18 08:24, duanwujie wrote:
>> We use the xenomai 3.0.7 stable version. Is okay for this ?
>>
>
> No, as I said. You need the latest stable/3.0.x branch because you 
> need adjustments to the FPU changes.
>
> Jan
>
>> 在 2018/12/6 下午3:21, Jan Kiszka 写道:
>>> On 06.12.18 08:18, duanwujie wrote:
>>>> I am not so sure, bellow code exist in 
>>>> ipipe-core-4.9.51-x86-2.patch but ipipe-core-4.9.135-x86-7.patch 
>>>> didn't。
>>>>
>>>> arch/x86/include/asm/fpu/internal.h:
>>>>
>>>> #ifdef CONFIG_IPIPE
>>>> static inline union fpregs_state *active_fpstate(struct fpu *fpu)
>>>> {
>>>> return fpu->active_state;
>>>> }
>>>> #else
>>>> static inline union fpregs_state *active_fpstate(struct fpu *fpu)
>>>> {
>>>> return &fpu->state;
>>>> }
>>>> #endif
>>>
>>> That's because of 
>>> https://gitlab.denx.de/Xenomai/ipipe/commit/6152df8928a5a8c3cbba81490109e041a2ca95fd 
>>> and is correct.
>>>
>>> Again: Did you update Xenomai?
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
>
-- 
*Linx Software Corportaion Sichuan Branch
Name：wujie duan
Tel：028-65182023-6202
E-mail: wjduan@linx-info.com
*
