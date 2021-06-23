From: MONTET Julien <julien.montet@reseau.eseo.fr>
Subject: RE: Docker - Xenomai hangs on rt_task_wait_period()
Date: Wed, 23 Jun 2021 07:55:14 +0000
Message-ID: <PR3PR02MB6202344CA134AA59D0BE84A2D1089@PR3PR02MB6202.eurprd02.prod.outlook.com>
References: <AM7PR02MB61947BF8EFF0C1BCEE882A1AD1099@AM7PR02MB6194.eurprd02.prod.outlook.com>
 <80bc7b48-87b3-c739-d11d-140eab432990@siemens.com>,
 <9ce86b28d28ecbfa8af84c457254d2ee179ca601.camel@siemens.com>
In-Reply-To: <9ce86b28d28ecbfa8af84c457254d2ee179ca601.camel@siemens.com>
Content-Language: fr-FR
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I tried again this morning, and run the latency bin of Xenomai on the Docke=
r, it doesn't hang :

root@f2f41a83e749:/usr/xenomai/bin# ./latency
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|      1.666|      2.070|      7.187|       0|     0|      1.666|      7=
.187
RTD|      1.666|      2.074|     17.447|       0|     0|      1.666|     17=
.447
RTD|      1.613|      2.003|     14.113|       0|     0|      1.613|     17=
.447
RTD|      1.561|      2.045|     12.967|       0|     0|      1.561|     17=
.447
RTD|      1.716|      2.061|     19.217|       0|     0|      1.561|     19=
.217
RTD|      1.664|      2.062|     15.675|       0|     0|      1.561|     19=
.217
^C---|-----------|-----------|-----------|--------|------|-----------------=
--------
RTS|      1.561|      2.052|     19.217|       0|     0|    00:00:07/00:00:=
07


I can't test my Docker on x86 now, I will do it as soon as I can, most prob=
ably this evening.
Regarding the link Florian sent, I didn't use this to run my docker : -devi=
ce=3D/dev/rtdm:/dev/rtdm
I have almost the same "docker run" call as Marco Barletta, I just added : =
--privileged --cap-add SYS_NICE.
This PID issue might be related, I don't kow how to check this.

Regards,

On Wed, 2021-06-23 at 07:37 +0200, Jan Kiszka wrote:
> On 22.06.21 18:38, MONTET Julien via Xenomai wrote:
> > Hello the developers,
> >
> > I have been using Xenomai for the past two months on different targets =
/ skins / architectures, and it is a great real time solution !
> > For the past few days, I have been trying to use my code on a docker :
> >
> >   *   Compiled on a debian 10.9 with Xenomai libraries (3.1) for an ARM=
 target
> >   *   This code runs on a raspberry pi 3B with an IPIPE patch (Cobalt)
> >   *   The kernel version is 4.19+
> >
> > My code is running fine with different methods, there is no crash.
> > However, the execution hangs when  I use the couple rt_task_set_periodi=
c/rt_task_wait_period.
> > Methods such as "RTIME", rt_printf(), rt_task_set_periodic() do not han=
gs, but my code seems to keep waiting on rt_task_wait_period().
> >
> > I am aware someone had this issue four years ago :
> > https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fxen=
omai.org%2Fpipermail%2Fxenomai%2F2017-November%2F037890.html&amp;data=3D04%=
7C01%7Cjulien.montet%40reseau.eseo.fr%7C00a8a1217b1347e085d708d936177e97%7C=
4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C637600296802295046%7CUnknown%7CT=
WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%=
3D%7C1000&amp;sdata=3DIdqQYU1WPAP4XP8yb6HWRn%2B10BsbRJRtrm3iEPDsqQQ%3D&amp;=
reserved=3D0
> > According to the link above, Cobalt does not support PID namespaces.
> > I also understood it is needed to convert vpid <-> pid by using the fin=
d_task_vpid().
> >
> > I am not an expert on the interaction between Docker and Linux - specif=
ically on PID.
> > Is it a normal behaviour in my case ? Where would it be interesting to =
make these changes ?
> > What is the link between RT_TASK and PID / vPID ?
> >
> > Regards,
> >
> > Julien
> >
>
> Do you see this issue only on ARM, or is the pattern also reproducible
> on x86 (qemu/kvm)? Are only native/alchemy apps affected, or does the
> latency test hang as well?
>
> Maybe you can describe what would be needed to reproduce inside a
> xenomai-images qemu target so that we look at the same thing.
>
> Florian, we only have some x86 hosts enabled to run docker aside
> Xenomai, right?

Yes, we have a x86 setup running containers, but AFAIK there is no
Xenomai workload inside the container.

We know about [1] (bug /wrt PID namespace). Might that be related?

[1] https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
lab.com%2FXenomai%2Fxenomai-hacker-space%2F-%2Fissues%2F19&amp;data=3D04%7C=
01%7Cjulien.montet%40reseau.eseo.fr%7C00a8a1217b1347e085d708d936177e97%7C4d=
7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C637600296802295046%7CUnknown%7CTWF=
pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D=
%7C1000&amp;sdata=3DqI0zj%2F4PgzYoXyZBUE%2F9xYSbRI7vAp%2FPegw2JuCNcqM%3D&am=
p;reserved=3D0

>
> Jan
>

