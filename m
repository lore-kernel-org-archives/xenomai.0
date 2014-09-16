Message-ID: <541878D4.4070809@siemens.com>
Date: Tue, 16 Sep 2014 19:52:20 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <B89CCBE86D4F62448EE4F6367C6D3C891DACCB0F@USMLVA0EM24MSX.ww017.siemens.net>
 <53E14B37.2040202@xenomai.org>
 <1410537098.19920.YahooMailNeo@web142606.mail.bf1.yahoo.com>
 <B89CCBE86D4F62448EE4F6367C6D3C891DAD9615@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C891DAD962F@USMLVA0EM24MSX.ww017.siemens.net>
 <54135D7D.30104@xenomai.org> <20140914024450.GK17690@csclub.uwaterloo.ca>
 <54150B08.5070603@xenomai.org> <20140916155650.GL17690@csclub.uwaterloo.ca>
In-Reply-To: <20140916155650.GL17690@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Question regarding rt_sem_p
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2014-09-16 17:56, Lennart Sorensen wrote:
> On Sun, Sep 14, 2014 at 05:27:04AM +0200, Gilles Chanteperdrix wrote:
>> I am almost sure I fixed an issue with user-space getting -EINTR with
>> gdb. I simply did not want to look for the commit if you still have the
>> issue with 3.14. If 3.14 does not boot, it looks like I will have to
>> search the commit anyway.
> 
> I am trying to bacport the 3.14 git tree to 3.12 (so far looking not
> too hard).  Just trying to get any of the fixes 3.14 has to see if it
> helps (the commit mentioned did help with some things, so gdb works now).
> 
> I spotted this though that looks like a mistake (although clearly harmless
> is CONFIG_IPIPE is enabled)
> 
> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index b30a292..27376a0 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -242,6 +242,10 @@ u64 sched_clock_cpu(int cpu)
>         struct sched_clock_data *scd;
>         u64 clock;
>         
> +#ifndef CONFIG_IPIPE
> +       WARN_ON_ONCE(!irqs_disabled());
> +#endif 
> +
>         if (sched_clock_stable())
>                 return sched_clock();
>                 
> 
> The kernel purposely removed that warning, so why should the ipipe patch
> put it back, and only when ipipe is disabled?
> 

Usually such things come in when merge conflicts are resolved.

Upstream replaced local_irq_disable with preempt_enable/disable for the
sched clock. That's fine for our usage, tracing, as we have that under
control when I-pipe is enabled. Without I-pipe, this piece will cause a
false-positive. So a patch to remove this also in 3.14 is definitely
welcome.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

