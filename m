References: <1400788012.41259.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <1401734780.6508.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <53A3E8FE.5020005@xenomai.org>
 <1403519510.94410.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <1403555262.58217.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <1404233289.69461.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53BCF270.3010303@xenomai.org> <53BCFC3D.30403@xenomai.org>
Message-ID: <1405365140.42152.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Mon, 14 Jul 2014 20:12:20 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53BCFC3D.30403@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] FreeRTOS skin #2
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

----- Original Message -----=0A=0A> From: Philippe Gerum <rpm@xenomai.org>=
=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <x=
enomai@xenomai.org>=0A> Cc: =0A> Sent: Wednesday, July 9, 2014 10:24 AM=0A>=
 Subject: Re: [Xenomai] FreeRTOS skin #2=0A> =0A> On 07/09/2014 09:42 AM, P=
hilippe Gerum wrote:=0A>>  On 07/01/2014 06:48 PM, Matthias Schneider wrote=
:=0A>>>  Please find enclosed another calling the check_processors() only w=
hen =0A>>>  starting=0A>>>  the scheduler and remembering its output. It is=
 also adapted to the =0A>>>  latest changes.=0A>>>  Any comments will be ap=
preciated.=0A>>> =0A>> =0A>>  - clusters allowing key dups are available us=
ing the *_dup() call form=0A> =0A> I just noticed that you would need uniqu=
ement labels for pushing your tasks to =0A> the registry anyway, so the fol=
lowing patch on top of the previous one would =0A> likely do:=0A> =0A> diff=
 --git a/lib/freertos/task.c b/lib/freertos/task.c=0A> index d201711..d0051=
63 100644=0A> --- a/lib/freertos/task.c=0A> +++ b/lib/freertos/task.c=0A> @=
@ -426,10 +426,17 @@ static signed portBASE_TYPE __xTaskGenericCreate(struc=
t =0A> freertos_task *task,=0A> =0A> =A0=A0=A0 generate_name(task->name, (c=
onst char *)name, &task_namegen);=0A> =0A> -=A0=A0=A0 ret =3D cluster_addob=
j_dup(&freertos_task_table, task->name, =0A> &task->cobj);=0A> -=A0=A0=A0 i=
f (__bt(ret)) {=0A> -=A0=A0=A0 =A0=A0=A0 threadobj_uninit(&task->thobj);=0A=
> -=A0=A0=A0 =A0=A0=A0 return pdFALSE;=0A> +=A0=A0=A0 for (;;) {=0A> +=A0=
=A0=A0 =A0=A0=A0 ret =3D cluster_addobj(&freertos_task_table, task->name, =
=0A> &task->cobj);=0A> +=A0=A0=A0 =A0=A0=A0 if (ret =3D=3D -EEXIST) {=0A> +=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 generate_name(task->name, NULL, &task_namegen=
);=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 continue;=0A> +=A0=A0=A0 =A0=A0=A0 }=
=0A> +=A0=A0=A0 =A0=A0=A0 if (__bt(ret)) {=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 threadobj_uninit(&task->thobj);=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 retu=
rn pdFALSE;=0A> +=A0=A0=A0 =A0=A0=A0 }=0A> +=A0=A0=A0 =A0=A0=A0 break;=0A> =
=A0=A0=A0 }=0A> =0A> =A0=A0=A0 registry_init_file_obstack(&task->fsobj, &re=
gistry_ops);=0A> =0A> =0A> -- =0A> Philippe.=0A> =0A=0AThis changes the eff=
ective names of the duplicated tasks. However,=0AI do not see a big deal ab=
out it, so I have added this change to my patch.=0A=0AMatthias

