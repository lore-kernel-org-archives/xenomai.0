Subject: Re: linux4.14+xenomai3.1 real-time
References: <002c01d6149b$b2460cf0$16d226d0$@lynuc.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d23bccc4-479b-b64e-b1fd-550cf2ab609a@siemens.com>
Date: Fri, 17 Apr 2020 11:50:14 +0200
MIME-Version: 1.0
In-Reply-To: <002c01d6149b$b2460cf0$16d226d0$@lynuc.cn>
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
To: =?UTF-8?B?5aSP5L6v6YeP?= <xia.h.l@lynuc.cn>, xenomai@xenomai.org
Cc: huang.c.h@lynuc.cn

Hi Xiahou Liang,

On 17.04.20 11:36, 夏侯量 via Xenomai wrote:
> dear Xenomai Team:
> 
> When we tested on the Intel(r) Celeron(r) processor 1047ue (third
> generation) motherboard (using kernel version: 4.1.18, xenomai version: 2.6.
> 5, patch: ipipe-core-4.1.18-x86-3. ), The real-time test results meet the
> requirements.But the 4.1.18 version of the kernel (xenomai version 2.6.5)
> running on the Intel(r) Celeron(r) processor 3955U (sixth generation)
> motherboard can not guarantee real-time performance
> 
> And on Intel(r) Celeron(r) processor 3955U (sixth generation) motherboard
> (kernel version: 4.14.134, xenomai version: 3.1, patch:
> ipipe-core-4.14.134-x86-2. Patch ), We have done many configuration
> modification tests. However, the maximum jitter is 25u under 1ms, the

IOW, the maximum jitter was 975 µs? That would be indeed completely off.

> real-time test results cannot meet our requirements. Our goal is a maximum
> jitter of around 10u.

How did  you measure the latency? Via the Xenomai testsuite (latency) or 
via your own application? If the latter, can you reproduce such 
excessive latencies also with Xenomai tests?

> 
> We would like to ask what relevant content needs to be modified.
> 

First of all, don't use 4.14 anymore when starting a new project. It's 
unmaintained Xenomai-wise. Please try with latest 4.19 patch 
(ipipe-core-4.19.114-cip24-x86-12).

Then we would need your kernel .config for that setup if you can still 
reproduce that high latency.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

