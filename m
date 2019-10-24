Subject: Re: Process load balancing among CPU
References: <32d2a7d6-c915-2cd1-3c74-c005a53fc708@numalliance.com>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <e3947682-2dbe-fad1-0a73-6e3ebcbedcb2@numalliance.com>
Date: Thu, 24 Oct 2019 11:59:29 +0200
MIME-Version: 1.0
In-Reply-To: <32d2a7d6-c915-2cd1-3c74-c005a53fc708@numalliance.com>
Content-Language: fr
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I noticed that when I launch processes linked with xenomai, these=20
programs are automatically linked to a single process

using cat /proc/<pid>/status

the cpus_allowed value is linked to a single cpu .

Doing the same on a singular linux process (eg xterm) , the cpus_allowed=20
value is f , permitted to switch along all my cpus .

So, I suppose if I want a process using only xenomai shm=C2=A0 must have=20
cpuset affinity defined in order being able to switch to other cpu ????


Le 24/10/2019 =C3=A0 10:00, St=C3=A9phane Ancelot via Xenomai a =C3=A9cri=
t=C2=A0:
> Hi,
>
> In our system, I noticed maybe a setup problem, or a xenomai related=20
> setup problem regarding user processes.
>
> I have 2 user tasks that does not use RT (but xenomai shared memory=20
> access), I noticed that if these both tasks were consuming 50% of the=20
> CPU they were not migrated on other cpus.
>
> There is no CPU affinity setup in these programs , so I kept the=20
> kernel scheduler doing its job.
>
> Is this a bad kernel setting or xenomai setting=C2=A0 to allow process =
cpu=20
> migration for user processes ?
>
> Regards,
>
> S.Ancelot
