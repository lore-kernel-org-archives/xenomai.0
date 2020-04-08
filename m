Subject: =?UTF-8?Q?Re=3a_Why_X11_influences_the_latency_of_xenomai=ef=bc=9f?=
References: <CAAvDm6aDLFL1OzT8A2ufYrCrxwR4ROgS+v6ZUqSkq_K2tb3m_A@mail.gmail.com>
 <093ba9fd-6327-00d7-7b1e-da71dfc1cb4e@siemens.com>
 <CAAvDm6bP_zCABHDKwUXY6DW7q3=qhh=Fe2MiUfJbsvkyCaaJ7Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <80c4b4df-216d-8ba4-e787-de62b92de608@siemens.com>
Date: Wed, 8 Apr 2020 18:41:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6bP_zCABHDKwUXY6DW7q3=qhh=Fe2MiUfJbsvkyCaaJ7Q@mail.gmail.com>
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
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 08.04.20 15:13, 孙世龙 wrote:
> Hi,
>        I could not catch your idea about the GPU usage patterns. How 
> could I acquire this information?
>        My laptop model is Dell Latitude 5501 runing over ubuntu 14.04 
> system.
>        GPU model information： NVIDIA GeForce MX150.
> 

NVIDIA... using their close-source driver or nouveau?

It's been a long time I ran that on a Xenomai box, I only vaguely 
remember that there used to be issues with lengthy cache flushes when 
data is pushed to RAM in order to make it visible to the GPU.

Jan

>       Best regards.
> 
> Jan Kiszka <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>> 于 
> 2020年4月8日周三 下午5:05写道：
> 
>     On 08.04.20 10:39, 孙世龙 via Xenomai wrote:
>      > Hi,
>      >      Why X11 influences the latency of xenomai？I guess it has
>     some relation
>      > to GPU.Could you make me more clearly?
>      >      I have solved the latency . I am using QT runing on linux
>     framebuffer
>      > ,disabled X11 at all.I really hope to why  X11 influences the
>     latency of
>      > xenomai
> 
>     It's not X11, it's the side effects of certain GPU usage patterns on
>     your particular platform. Can you specify more details about both?
> 
>     Jan
> 
>     -- 
>     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>     Corporate Competence Center Embedded Linux
> 


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

