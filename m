Subject: Re: undefined reference to `rt_task_create
References: <d3c4d944-807a-a2d4-7ec1-2d1639f36f78@vbm-grp.com>
 <48de04a3-9f2c-d3e6-8a80-568a497015c1@vbm-grp.com>
 <5cf98ffb-d244-1030-552e-a1ebed830df0@siemens.com>
From: "Electronic Dept. - Vbm Group" <electronic@vbm-grp.com>
Message-ID: <fbd7a196-5b56-c78b-2b5e-b1c57cb9bdc2@vbm-grp.com>
Date: Thu, 5 Dec 2019 08:50:37 +0100
MIME-Version: 1.0
In-Reply-To: <5cf98ffb-d244-1030-552e-a1ebed830df0@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Jan,
thank you for your quick answer. Adding -lalchemy manually, I get the=20
following:

gcc -o cyclic_test cyclic_test.c -I/usr/xenomai/include/cobalt=20
-I/usr/xenomai/include -march=3Darmv7-a -mfpu=3Dvfp3 -D_GNU_SOURCE=20
-D_REENTRANT -fasynchronous-unwind-tables -D__COBALT__=20
-Wl,--no-as-needed -Wl,@/usr/xenomai/lib/modechk.wrappers=20
/usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=3Dmain=20
-Wl,--dynamic-list=3D/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib=20
-lcobalt -lalchemy -lmodechk -lpthread -lrt -march=3Darmv7-a -mfpu=3Dvfp3
/tmp/cc8rjnqk.o: In function `rt_timer_read':
cyclic_test.c:(.text+0xe): undefined reference to `clockobj_get_time'
/usr/xenomai/lib/libalchemy.so: undefined reference to=20
`threadobj_set_schedparam'
/usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_wait_drain'
/usr/xenomai/lib/libalchemy.so: undefined reference to `timerobj_destroy'
/usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_uninit'
/usr/xenomai/lib/libalchemy.so: undefined reference to `pvcluster_init'
/usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_stat'
/usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_unblock'
/usr/xenomai/lib/libalchemy.so: undefined reference to `semobj_destroy'
/usr/xenomai/lib/libalchemy.so: undefined reference to=20
`threadobj_wait_period'
/usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_wait_grant'
/usr/xenomai/lib/libalchemy.so: undefined reference to=20
`threadobj_notify_entry'
/usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_cancel'
/usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_unlock'
/usr/xenomai/lib/libalchemy.so: undefined reference to `pvsyncluster_addobj'
/usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_lock'
/usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_tskey'
/usr/xenomai/lib/libalchemy.so: undefined reference to `__threadobj_alloc'
/usr/xenomai/lib/libalchemy.so: undefined reference to=20
`__syncobj_broadcast_drain'
/usr/xenomai/lib/libalchemy.so: undefined reference to `pvsyncluster_init'
/usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_init'
/usr/xenomai/lib/libalchemy.so: undefined reference to `clockobj_init'
/usr/xenomai/lib/libalchemy.so: undefined reference to `timerobj_init'
/usr/xenomai/lib/libalchemy.so: undefined reference to `timerobj_start'
/usr/xenomai/lib/libalchemy.so: undefined reference to `eventobj_inquire'
/usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_suspend'
/usr/xenomai/lib/libalchemy.so: undefined reference to `pvsyncluster_delobj'
/usr/xenomai/lib/libalchemy.so: undefined reference to `semobj_getvalue'
/usr/xenomai/lib/libalchemy.so: undefined reference to `semobj_broadcast'
/usr/xenomai/lib/libalchemy.so: undefined reference to `eventobj_uninit'
/usr/xenomai/lib/libalchemy.so: undefined reference to `pvcluster_addobj'
/usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_spin'
/usr/xenomai/lib/libalchemy.so: undefined reference to `eventobj_init'
/usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_init'
/usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_grant_one'
/usr/xenomai/lib/libalchemy.so: undefined reference to `semobj_post'
/usr/xenomai/lib/libalchemy.so: undefined reference to `semobj_init'
/usr/xenomai/lib/libalchemy.so: undefined reference to `timerobj_stop'
/usr/xenomai/lib/libalchemy.so: undefined reference to=20
`clockobj_convert_clocks'
/usr/xenomai/lib/libalchemy.so: undefined reference to `eventobj_wait'
/usr/xenomai/lib/libalchemy.so: undefined reference to=20
`copperplate_create_thread'
/usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_uninit'
/usr/xenomai/lib/libalchemy.so: undefined reference to `semobj_wait'
/usr/xenomai/lib/libalchemy.so: undefined reference to `eventobj_destroy'
/usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_set_mode'
/usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_destroy'
/usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_prologue'
/usr/xenomai/lib/libalchemy.so: undefined reference to=20
`__syncobj_broadcast_grant'
/usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_peek_drain'
/usr/xenomai/lib/libalchemy.so: undefined reference to=20
`threadobj_set_periodic'
/usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_sleep'
/usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_resume'
/usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_peek_grant'
/usr/xenomai/lib/libalchemy.so: undefined reference to `pvcluster_delobj'
/usr/xenomai/lib/libalchemy.so: undefined reference to=20
`pvsyncluster_findobj'
/usr/xenomai/lib/libalchemy.so: undefined reference to `eventobj_clear'
/usr/xenomai/lib/libalchemy.so: undefined reference to=20
`__heapobj_init_private'
/usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_grant_to'
/usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_start'
/usr/xenomai/lib/libalchemy.so: undefined reference to `eventobj_post'
/usr/xenomai/lib/libalchemy.so: undefined reference to=20
`heapobj_init_array_private'
/usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_shadow'
/usr/xenomai/lib/libalchemy.so: undefined reference to=20
`threadobj_wait_start'
/usr/xenomai/lib/libalchemy.so: undefined reference to=20
`copperplate_renice_local_thread'
/usr/xenomai/lib/libalchemy.so: undefined reference to `semobj_uninit'
collect2: error: ld returned 1 exit status

Thanks alot.

Best Regards
Davide Brunelli

*Electronic Vbm Group*
e-mail: electronic2@vbm-grp.com <mailto:electronic2@vbm-grp.com>

Vbm Group <http://service.vbm-grp.com/signature/logogrp.png>


Vbm Group Vbm Group Vbm Group


*Vbm Group is a trademark of VI.BE.MAC S.p.a.*

*Declaration according to Law No. 196 of 30 June 2003*
We hereby inform you that your data will be treated automatically,=20
according to the current security regulations for written=20
correspondence; your data will not be spread by Vi.Be.Mac. Spa. In any=20
way, as far as your data are concerned, you have the rights indicated in=20
art. No. 13 L. 675/1996 (such as access, cancellation, modification,=20
objection, etc.). Vi.Be.Mac. Spa. Is the holder of treatment of your=20
data. Vi.Be.Mac. is located in via Monte Pastello, 7/i (Vr) Italy. For=20
further information, please write to: privacy@vibemac.com According to=20
Art. No. 13 of law 196/2003, in any moment and free of any charge you=20
have the right to deny the use of your personal data to send you written=20
correspondence. You just have to advise about this by writing to:=20
privacy@vibemac.com


*Informativa ai sensi del d.lgs n. 196, 30.6.2003*
I suoi dati saranno trattati in forma automatizzata, nel rispetto delle=20
idonee misure di sicurezza, per l'invio di comunicazioni e non saranno=20
soggetti a diffusione all'esterno di Vi.Be.Mac. Spa. In relazione al=20
trattamento dei dati, potr=E0 esercitare i diritti (accesso,cancellazione, =

rettifica, opposizione, etc.) specificamente previsti dall'art. 13 L.=20
675/1996 e nelle modalit=E0 ivi contemplate. Titolare del trattamento dei=20
dati =E8 Vi.Be.Mac. Spa, con sede legale in San Giovanni Lupatoto (Vr) via =

Monte Pastello 7/i. Per informazioni scrivere a privacy@vibemac.com Ai=20
sensi dell'art. 13 del d.lgs. 196/2003, potr=E0 opporsi in ogni momento,=20
in via gratuita, al trattamento dei suoi dati al fine dell'invio di=20
analoghe comunicazioni a mezzo di posta elettronica, semplicemente=20
comunicandocelo all'indirizzo e-mail privacy@vibemac.com Qualsiasi=20
utilizzo non autorizzato del presente messaggio nonch=E8 dei suoi allegati =

=E8 vietato e potrebbe costituire reato. Se lei ha ricevuto erroneamente=20
il presente messaggio, Le saremmo grati se via e-mail ce ne comunicasse=20
la ricezione e provvedesse alla distruzione del messaggio stesso e dei=20
suoi eventuali allegati.

VI.BE.MAC s.p.a. - 37057 S. GIOVANNI LUPATOTO (VR) ITALY - Via Monte=20
Pastello, 7/i - Tel. +39 045 8778151/52 - Fax +39 045 8779024 - Cod.=20
Fisc./Partita IVA 01264050236- Cap. Soc. Euro 2.000.000,00 int. Vers. -=20
Reg. Imprese di VERONA N. 01264050236 - REA N. 170441
Societ=E0 soggetta a direzione e coordinamento di Jack Europe S.=E0.r.l.
Il 05/12/2019 08:44, Jan Kiszka ha scritto:
> On 05.12.19 08:35, Electronic Dept. - Vbm Group via Xenomai wrote:
>> Hello Jan,
>>
>> thank you for your answer.
>>
>> My Xenomai version is:
>>
>> Xenomai/cobalt v3.0.9 -- #5b99a61 (2019-11-04 19:44:03 +0100)
> OK, but when I call "xeno-config --skin=3Dalchemy --ldflags" for that
> version, I do have "-lalchemy" in the output. That would fix your
> linking issue. Can you check the output you get?
>
> Jan
>
