Subject: Re: Task Priority & Domain switch
References: <VI1PR08MB337564202AA59428E7A0C1A5F5BB0@VI1PR08MB3375.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <821933fe-e138-4435-ae99-d20b496e1459@siemens.com>
Date: Thu, 5 Sep 2019 19:02:31 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR08MB337564202AA59428E7A0C1A5F5BB0@VI1PR08MB3375.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johann Obermayr <johann.obermayr@sigmatek.at>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05.09.19 15:26, Johann Obermayr via Xenomai wrote:
> Hello,
> 
> i need some explain about task priority & domain switch.
> 
> 
>    1.  Xenomai 2.6.x ( CONFIG_XENO_OPT_PERVASIVE=y    CONFIG_XENO_OPT_PRIOCPL=y )

Don't enable XENO_OPT_PRIOCPL. It was never working as expected (best case) or 
was even causing more major issues (source of many crashes).

> 
> rt_task_shadow( &handle, 0 );
> 
> task running default in releaxed ( secondary domain). After take a xenomai mutex lock, it switch to the primary domain.
> 
> After mutex unlock the task switch back to secondary domain or after next xenomai-function call ?
> 

Immediately for SCHED_OTHER threads (prio 0). RT threads are switched back to RT 
lazily, i.e. when the next RT syscall is issued.

> 
> 
> rt_task_shadow( &handle, 10 );
> 
> task run default in primary domain. After do  a linux-syscall  , the task switch to secondary domain.
> 
> With XENO_OPT_PRIOCPL it take the xenomai priority 10 to Linux rt_priority 10.
> 
> After call a xenomai function, it switch back to primary domain.
> 
> 
> 
> 
> 
>    1.  Xenomai 3.0.x
> 
> Is there a different work to xenomai 2.6.x ?
> 
> 
> 
> 
> Or where can I found more information about this theme ?

See the section on SCHED_WEAK in 
https://gitlab.denx.de/Xenomai/xenomai/wikis/Migrating_From_Xenomai_2_To_3.

> 
> Thanks & regards
>                  Johann
> 
> PS: I known that xenomai 2.6.x is out of date. But we must support some old versions.
> 

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

