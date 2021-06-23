Subject: Re: Docker - Xenomai hangs on rt_task_wait_period()
References: <AM7PR02MB61947BF8EFF0C1BCEE882A1AD1099@AM7PR02MB6194.eurprd02.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <80bc7b48-87b3-c739-d11d-140eab432990@siemens.com>
Date: Wed, 23 Jun 2021 07:37:06 +0200
MIME-Version: 1.0
In-Reply-To: <AM7PR02MB61947BF8EFF0C1BCEE882A1AD1099@AM7PR02MB6194.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
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
To: MONTET Julien <julien.montet@reseau.eseo.fr>, Xenomai <xenomai@xenomai.org>, "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>

On 22.06.21 18:38, MONTET Julien via Xenomai wrote:
> Hello the developers,
> 
> I have been using Xenomai for the past two months on different targets / skins / architectures, and it is a great real time solution !
> For the past few days, I have been trying to use my code on a docker :
> 
>   *   Compiled on a debian 10.9 with Xenomai libraries (3.1) for an ARM target
>   *   This code runs on a raspberry pi 3B with an IPIPE patch (Cobalt)
>   *   The kernel version is 4.19+
> 
> My code is running fine with different methods, there is no crash.
> However, the execution hangs when  I use the couple rt_task_set_periodic/rt_task_wait_period.
> Methods such as "RTIME", rt_printf(), rt_task_set_periodic() do not hangs, but my code seems to keep waiting on rt_task_wait_period().
> 
> I am aware someone had this issue four years ago :
> https://xenomai.org/pipermail/xenomai/2017-November/037890.html
> According to the link above, Cobalt does not support PID namespaces.
> I also understood it is needed to convert vpid <-> pid by using the find_task_vpid().
> 
> I am not an expert on the interaction between Docker and Linux - specifically on PID.
> Is it a normal behaviour in my case ? Where would it be interesting to make these changes ?
> What is the link between RT_TASK and PID / vPID ?
> 
> Regards,
> 
> Julien
> 

Do you see this issue only on ARM, or is the pattern also reproducible
on x86 (qemu/kvm)? Are only native/alchemy apps affected, or does the
latency test hang as well?

Maybe you can describe what would be needed to reproduce inside a
xenomai-images qemu target so that we look at the same thing.

Florian, we only have some x86 hosts enabled to run docker aside
Xenomai, right?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

