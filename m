Subject: Re: Which way could guarantee more precise delay?'rt_task_sleep' or
 'rt_task_wait_period'?
References: <CAAvDm6YKsKHNZ8+wTmYNTE6_67MQ8MhxvM9Z-_ockETQb5GHeA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8c5646e8-8dd1-13a3-85a6-29595857b7cd@siemens.com>
Date: Mon, 18 May 2020 11:02:57 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6YKsKHNZ8+wTmYNTE6_67MQ8MhxvM9Z-_ockETQb5GHeA@mail.gmail.com>
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

On 17.05.20 07:51, 孙世龙 via Xenomai wrote:
> Hi,
>         I need to run a simpe routline periodically.For example,
> the routline needs to run every 1ms.
> 
>         Which way could guarantee more precise delay?'rt_task_sleep'  or
> 'rt_task_wait_period'?
> 
>         If there is a better solution,please let me know.
> 
>         Thank you for attention to this matter.
>         Look forward to hearing from you.
> 

Both will give you same accuracy as both are built on the same 
mechanisms in the core - provided you use rt_task_sleep with absolute 
timeouts.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

