Date: Mon, 15 Feb 2016 13:15:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160215121518.GC9903@hermes.click-hack.org>
References: <56C1B8F1.5070506@ixion.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <56C1B8F1.5070506@ixion.es>
Subject: Re: [Xenomai] Unexpected CPU assignment on iMX6Q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Javier =?iso-8859-1?Q?Mart=EDnez?= Cantos <jmartinez@ixion.es>
Cc: xenomai@xenomai.org

On Mon, Feb 15, 2016 at 12:39:29PM +0100, Javier Mart=EDnez Cantos wrote:
> Hi everybody,
>=20
> I'm currently working on Toradex Apalis iMX6Q (4 cores) with Xenomai=20
> 2.6.4. The system runs fine.
>=20
> However, I'm playing around with rt_task_create and T_CPU obtaining the=20
> following results:
>=20
> - T_CPU(0-3) leads to task creation on expected core, i.e. 1 to 4,
>=20
> - while T_CPU(>3) leads to task creation always on first core.
>=20
> Affinity is configured as follows:
>=20
> cat /proc/xenomai/affinity
> 0000000f
>=20
> I expect rt_task_create to return an EINVAL error or something like that =

> when T_CPU is higher than RTHAL_NR_CPUS - 1.

The affinity is used when starting the task with rt_task_start, not
when creating it. And indeed, rt_task_start should return -EINVAL if
no cpu is found for running the task.

>=20
> Could RTHAL_NR_CPUS has a value higher than 4? How can I check this? I=20
> have already checked that CONFIG_NR_CPUS is 4.

NR_CPUS does not matter, xnpod_start_thread does a "bitwise and" with
cpu_online_mask.

>=20
> On runtime, how can I query the "task to core assignment" through=20
> Xenomai API?

I am not sure there is a way. You can check /proc/xenomai/sched or
/proc/xenomai/stat though.

--=20
					    Gilles.
https://click-hack.org

