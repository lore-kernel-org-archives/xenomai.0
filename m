Subject: Re: Question about round-robin scheduling.
References: <CAAvDm6YF-PcERwDrV2C6NVHqKLE9+_z6R6tQq29uyHff=Oyj3A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <846f8be9-c102-ef57-36f9-1c9b769805ab@siemens.com>
Date: Wed, 12 Aug 2020 18:00:54 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6YF-PcERwDrV2C6NVHqKLE9+_z6R6tQq29uyHff=Oyj3A@mail.gmail.com>
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
To: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 06.08.20 14:27, 孙世龙 sunshilong via Xenomai wrote:
> Hi, list
> 
> As per the Kconfig(
> https://gitlab.denx.de/Xenomai/xenomai/-/blob/5714ceede70ccd39b1bf6c41a72cfa94f98e169a/kernel/cobalt/Kconfig
> ),
> which says [emphasise mine]:
> Cobalt has a built-in real-time class, which supports both
> preemptive fixed-priority FIFO, and **round-robin scheduling**.
> Cobalt supports  round-robin scheduling whereas
> rt_task_create function only supports SCHED_FIFO and SCHED
> (
> https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__task.html#ga03387550693c21d0223f739570ccd992
> ).
> 
> So, I wonder how to set a real-time task to use round-robin scheduling.
> Or, am I missing something?
> 

Look how SCHED_RR is commonly configured, nothing special in Xenomai. 
The only specialty is CONFIG_XENO_OPT_RR_QUANTUM.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

