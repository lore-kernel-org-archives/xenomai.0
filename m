Subject: =?UTF-8?B?UmU6IEkgd29uZGVyIHdoYXQg4oCcYXBj4oCdIHN0YW5kcyBmb3I/?=
References: <CAAvDm6bPuRWZUvdazP=_at0WpLYWp3A8fXXwNU8EWJdguGzabw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f0e93159-7e03-9927-6945-cea08c821d10@siemens.com>
Date: Mon, 20 Apr 2020 07:56:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6bPuRWZUvdazP=_at0WpLYWp3A8fXXwNU8EWJdguGzabw@mail.gmail.com>
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

On 20.04.20 06:49, 孙世龙 via Xenomai wrote:
> Hi,
>         I wonder what “apc” stands for?
>         There are some fileds  named start with "apc"  in struct
> cobalt_pipeline.
>         For instance, "apc_virq"、" apc_map"、" apc_table".
> 
>         For your convenience, I listed the struct mentioned in this email.
> 
>        struct cobalt_pipeline {
> 
>     struct ipipe_domain domain;
>     unsigned long timer_freq;
>     unsigned long clock_freq;
>     unsigned int apc_virq;
>     unsigned long apc_map;
>     unsigned int escalate_virq;
>     struct {
>        void (*handler)(void *cookie);
>        void *cookie;
>        const char *name;
>     } apc_table[BITS_PER_LONG];
> #ifdef CONFIG_SMP
>     cpumask_t supported_cpus;
> #endif
> };
> 

"Asynchronous Procedure Call" - This is to invoke a function 
(accompanied by some data pointer) in Linux context, asynchronously to 
the triggering real-time context.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

