Subject: Re: Porting questiong about mips
From: duanwujie <wjduan@linx-info.com>
References: <bb0b247d-c21c-8416-b2ef-d341a1130d2f@linx-info.com>
Message-ID: <e5b7c308-395c-50be-84ce-a95a9241c699@linx-info.com>
Date: Thu, 20 Dec 2018 16:59:03 +0800
MIME-Version: 1.0
In-Reply-To: <bb0b247d-c21c-8416-b2ef-d341a1130d2f@linx-info.com>
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
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?B?5b2t5b+X6Iiq?= <zhpeng@linx-info.com>
Cc: Xenomai <xenomai@xenomai.org>

Hi, Phi and Jan:

         The correct handler is handle_percpu_irq !


> Hi, Phi and Jan:
>
>         I try to port the ipipe to mips arch  according the 
> https://gitlab.denx.de/Xenomai/xenomai/wikis/Porting_Xenomai_To_A_New_Arm_SOC#terminology 
>
>
>         Now it worked on the single cpu,but SMP failed. I consider the 
> interrupt controller's problem. The flow handler is 
> handle_irq_event_percpu. But the article haven't port information 
> about this handler.
>
>         Is there any clue for it.
>
> duan.
>
>
> -- 
> *Linx Software Corportaion Sichuan Branch
> Name：wujie duan
> Tel：028-65182023-6202
> E-mail: wjduan@linx-info.com
> *
-- 
*Linx Software Corportaion Sichuan Branch
Name：wujie duan
Tel：028-65182023-6202
E-mail: wjduan@linx-info.com
*
