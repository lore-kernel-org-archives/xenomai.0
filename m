Subject: =?UTF-8?Q?Re=3a_Why_X11_influences_the_latency_of_xenomai=ef=bc=9f?=
References: <CAAvDm6aDLFL1OzT8A2ufYrCrxwR4ROgS+v6ZUqSkq_K2tb3m_A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <093ba9fd-6327-00d7-7b1e-da71dfc1cb4e@siemens.com>
Date: Wed, 8 Apr 2020 11:05:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6aDLFL1OzT8A2ufYrCrxwR4ROgS+v6ZUqSkq_K2tb3m_A@mail.gmail.com>
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
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 08.04.20 10:39, 孙世龙 via Xenomai wrote:
> Hi,
>      Why X11 influences the latency of xenomai？I guess it has some relation
> to GPU.Could you make me more clearly?
>      I have solved the latency . I am using QT runing on linux framebuffer
> ,disabled X11 at all.I really hope to why  X11 influences the latency of
> xenomai

It's not X11, it's the side effects of certain GPU usage patterns on 
your particular platform. Can you specify more details about both?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

