References: <56C1B8F1.5070506@ixion.es>
 <20160215121518.GC9903@hermes.click-hack.org>
From: =?UTF-8?Q?Javier_Mart=c3=adnez_Cantos?= <jmartinez@ixion.es>
Message-ID: <56C1CC7D.6080006@ixion.es>
Date: Mon, 15 Feb 2016 14:02:53 +0100
MIME-Version: 1.0
In-Reply-To: <20160215121518.GC9903@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Unexpected CPU assignment on iMX6Q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 15/02/16 13:15, Gilles Chanteperdrix wrote:
> On Mon, Feb 15, 2016 at 12:39:29PM +0100, Javier Mart=EDnez Cantos wrot=
e:
>> Hi everybody,
>>
>> I'm currently working on Toradex Apalis iMX6Q (4 cores) with Xenomai
>> 2.6.4. The system runs fine.
>>
>> However, I'm playing around with rt_task_create and T_CPU obtaining th=
e
>> following results:
>>
>> - T_CPU(0-3) leads to task creation on expected core, i.e. 1 to 4,
>>
>> - while T_CPU(>3) leads to task creation always on first core.
>>
>> Affinity is configured as follows:
>>
>> cat /proc/xenomai/affinity
>> 0000000f
>>
>> I expect rt_task_create to return an EINVAL error or something like th=
at
>> when T_CPU is higher than RTHAL_NR_CPUS - 1.
> The affinity is used when starting the task with rt_task_start, not
> when creating it. And indeed, rt_task_start should return -EINVAL if
> no cpu is found for running the task.
Ok, I misunderstood. Anyway it is unexpected.

Once rt_task_create is called with -say- T_CPU(20), rt_task_start=20
returns 0 (success) and the target task is launched on first core (index =
0).

What's wrong?
>> Could RTHAL_NR_CPUS has a value higher than 4? How can I check this? I
>> have already checked that CONFIG_NR_CPUS is 4.
> NR_CPUS does not matter, xnpod_start_thread does a "bitwise and" with
> cpu_online_mask.
I'll explore this path.
>> On runtime, how can I query the "task to core assignment" through
>> Xenomai API?
> I am not sure there is a way. You can check /proc/xenomai/sched or
> /proc/xenomai/stat though.
>
Thank you Gilles.

--=20


Javier Mart=EDnez Cantos

Sistemas embarcados



=09

Juli=E1n Camarillo, 21 B, 3=AA Planta 28037 Madrid, Espa=F1a

=09

(+34) 91 440 18 33

=09

jmartinez@ixion.es=20
<.////172.20.31.5/datos/IXION/Info_public/Logos/Nueva%2520imagen%2520corp=
orativa/Plantillas/xxxx@ixion.es%2520>

=09

http://www.ixion.es <http://www.ixion.es/>

-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------

/This message is intended solely for its addressee. It may contain=20
privileged and/or confidential information, whose disclosure is=20
prohibited by law. If you have received this message in error, please do=20
not read, copy or distribute it and notify the dispatcher immediately./

/
Este correo electr=F3nico est=E1 dirigido exclusivamente a su destinatari=
o y=20
puede contener informaci=F3n sujeta a reserva y/o confidencial, cuya=20
revelaci=F3n est=E1 prohibida por ley. Si Ud. ha recibido este mensaje po=
r=20
error, le rogamos que no lo lea, copie o distribuya y que lo notifique=20
de inmediato a su remitente./



