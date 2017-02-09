References: <0ce3f46c-39c7-2f7e-02e1-12004a80da5d@pixelsurmer.com>
From: thierry bultel <tbultel@pixelsurmer.com>
Message-ID: <20cadc6f-dd3f-fd0a-14f2-1190da9316c5@pixelsurmer.com>
Date: Thu, 9 Feb 2017 09:47:16 +0100
MIME-Version: 1.0
In-Reply-To: <0ce3f46c-39c7-2f7e-02e1-12004a80da5d@pixelsurmer.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] kernel hangs when accessing /proc/xenomai/sched/stat
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org



Le 08/02/2017 =E0 18:36, thierry bultel a =E9crit :
> Dear all,
>
> After some months away from the world of realtime applications, I am
> back on a project on which I want to use xenomai3 with cobalt.
>
> The CPU is a IMX6solo
>
> The linux kernel is the latest git://git.xenomai.org/ipipe.git, branch
> ipipe-4.4.y
>
> The issue I have is reproducible on both xenomai-3 branches master & next
>
> I simply do
>
> #cat /proc/xenomai/sched/stat
>
> and this hangs the system.

I had the opportunity to test on an IMX6Q
The kernel hang does not happen, regardless of CONFIG_SMP=3Dy or not

However, the IMX6solo does not boot if CONFIG_SMP is not set,
and this, even without CONFIG_IPIPE.
It does boot with the vanilla 4.4.43, though, meaning that the bug is=20
likely in the ipipe patch.

>
> Best regards
>
>
>
>
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>

