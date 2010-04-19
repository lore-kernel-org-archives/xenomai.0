Message-ID: <4BCC8A7A.1040604@domain.hid>
Date: Mon, 19 Apr 2010 18:53:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <cover.1271672940.git.jan.kiszka@domain.hid>
	<4BCC8296.8000901@domain.hid> <4BCC88E8.5050304@domain.hid>
In-Reply-To: <4BCC88E8.5050304@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v4 00/25] [git pull v4] RTDM fixes and
	reworks
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> The following changes since commit 2bed24477882dd7937d59f4e33a0811981c7362c:
>>>   Gilles Chanteperdrix (1):
>>>         arm: declare the VFP inline asm snippets as volatile.
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.xenomai.org/xenomai-jki.git for-upstream
>> Ok, seems this merge broke the build test:
>> http://sisyphus.hd.free.fr/~gilles/bx/
>>
>> Could you please have a look?
> 
> The section mismatch should be resolved in my queue.
> 
> Regarding the other bug:
> 
> In file included from ./2.4.25-DENX-ppc_6xx-gcc-3.3.3/include/linux/workqueue.h:14,
>                  from core.c:29:
> ./2.4.25-DENX-ppc_6xx-gcc-3.3.3/include/linux/tqueue.h: In function `queue_task':
> ./2.4.25-DENX-ppc_6xx-gcc-3.3.3/include/linux/tqueue.h:105: warning: implicit declaration of function `barrier'
> core.c: In function `close_callback':
> core.c:257: warning: implicit declaration of function `schedule_delayed_work'
> 
> Does that kernel come with a linux/workqueue.h? What does it include?

I guess either this kernel containes a workqueue.h or it gets it via the
compat directory.

> That's a custom patch, isn't it?

This kernel is generated as explained in the README:
git clone git://www.denx.de/git/linuxppc_2_4_devel
git checkout 5bab6d641ff5ba139f9f41869502cb7c96d785bc
patch -p1 < adeos-ipipe-2.4.25-ppc-DENX-2.2-01.patch

Nothing custom about it,

-- 
					    Gilles.

