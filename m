Subject: Re: Does the xenomai regular thread whose schedule policy is
 SCHED_OTHER has more opportunities to occupy the cpu resources then the
 normal linux thread which managed by linux?
References: <CAAvDm6YUcSxoXVKiTcdQMw33TF48SbDkB3bsppwjqSpebOq0-g@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d55d2c7f-1e1f-9c8c-4141-97d390cbc9e0@siemens.com>
Date: Wed, 13 May 2020 07:54:31 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6YUcSxoXVKiTcdQMw33TF48SbDkB3bsppwjqSpebOq0-g@mail.gmail.com>
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

On 13.05.20 07:31, 孙世龙 via Xenomai wrote:
> Hi,
>      I wonder that whether the xenomai regular thread whose schedule policy
> is *SCHED_OTHER* *has more opportunities to occupy the cpu resources*
> then the normal linux thread which managed by linux?
>      Even if the linux thread with *SCHED_FIFO * schedule policy?

Yes, that happens for Xenomai-attached thread when they enter the 
real-time domain, e.g. while holding a Xenomai lock. At that point, they 
are above any regular Linux thread by nature - because they have to in 
order to not break the scheduling requirements of the RT domain.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

