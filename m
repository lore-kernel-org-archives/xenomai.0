Subject: Re: How to use the rtdm udd?
References: <CAAvDm6bGS6agUeAEUMVR5cu=wAYJJkQ7_ZPQPBoKGzZPj3Ts4A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <24efb99e-bf45-8265-3ad5-d6ad4d90a4a1@siemens.com>
Date: Mon, 6 Apr 2020 09:47:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6bGS6agUeAEUMVR5cu=wAYJJkQ7_ZPQPBoKGzZPj3Ts4A@mail.gmail.com>
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
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>, xenomai@xenomai.org

On 06.04.20 09:31, 孙世龙 via Xenomai wrote:
> How to use the rtdm udd?
> Is there some examples to show how to use it?Is there some material on how
> to use it?
> Thanks.Looking forward to your replay.
> 

In fact, we lack an example driver. However, the usage is analoguous to 
the kernel's UIO framework, and details a documented in 
https://gitlab.denx.de/Xenomai/xenomai/-/blob/master/include/cobalt/kernel/rtdm/udd.h

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

