Subject: Re: undefined reference to `rt_task_create
References: <d3c4d944-807a-a2d4-7ec1-2d1639f36f78@vbm-grp.com>
 <48de04a3-9f2c-d3e6-8a80-568a497015c1@vbm-grp.com>
 <5cf98ffb-d244-1030-552e-a1ebed830df0@siemens.com>
 <fbd7a196-5b56-c78b-2b5e-b1c57cb9bdc2@vbm-grp.com>
 <b7ff642f-85d5-a56f-de96-36f3897ddeaa@siemens.com>
From: steve freyder <steve@freyder.net>
Message-ID: <94d939cd-0274-84bd-62d0-3680f12aebe1@freyder.net>
Date: Thu, 5 Dec 2019 13:27:49 -0600
MIME-Version: 1.0
In-Reply-To: <b7ff642f-85d5-a56f-de96-36f3897ddeaa@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 12/5/2019 1:22 PM, Jan Kiszka via Xenomai wrote:
> On 05.12.19 08:50, Electronic Dept. - Vbm Group via Xenomai wrote:
>> Hello Jan,
>> thank you for your quick answer. Adding -lalchemy manually, I get the
>> following:
> There is more missing. What does "xeno-config --skin=3Dalchemy --ldflags"
> report for you?
>
> Jan
>
>> gcc -o cyclic_test cyclic_test.c -I/usr/xenomai/include/cobalt
>> -I/usr/xenomai/include -march=3Darmv7-a -mfpu=3Dvfp3 -D_GNU_SOURCE
>> -D_REENTRANT -fasynchronous-unwind-tables -D__COBALT__
>> -Wl,--no-as-needed -Wl,@/usr/xenomai/lib/modechk.wrappers
>> /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=3Dmain
>> -Wl,--dynamic-list=3D/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib
>> -lcobalt -lalchemy -lmodechk -lpthread -lrt -march=3Darmv7-a -mfpu=3Dvfp3
>> /tmp/cc8rjnqk.o: In function `rt_timer_read':
>> cyclic_test.c:(.text+0xe): undefined reference to `clockobj_get_time'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to
>> `threadobj_set_schedparam'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_wait_dra=
in'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `timerobj_destroy'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_uninit'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `pvcluster_init'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_stat'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_unbloc=
k'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `semobj_destroy'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to
>> `threadobj_wait_period'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_wait_gra=
nt'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to
>> `threadobj_notify_entry'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_cancel'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_unlock'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to
>> `pvsyncluster_addobj'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_lock'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_tskey'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `__threadobj_allo=
c'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to
>> `__syncobj_broadcast_drain'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `pvsyncluster_ini=
t'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_init'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `clockobj_init'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `timerobj_init'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `timerobj_start'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `eventobj_inquire'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_suspen=
d'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to
>> `pvsyncluster_delobj'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `semobj_getvalue'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `semobj_broadcast'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `eventobj_uninit'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `pvcluster_addobj'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_spin'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `eventobj_init'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_init'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_grant_on=
e'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `semobj_post'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `semobj_init'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `timerobj_stop'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to
>> `clockobj_convert_clocks'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `eventobj_wait'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to
>> `copperplate_create_thread'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_uninit'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `semobj_wait'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `eventobj_destroy'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_set_mo=
de'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_destroy'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_prolog=
ue'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to
>> `__syncobj_broadcast_grant'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_peek_dra=
in'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to
>> `threadobj_set_periodic'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_sleep'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_resume'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_peek_gra=
nt'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `pvcluster_delobj'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to
>> `pvsyncluster_findobj'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `eventobj_clear'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to
>> `__heapobj_init_private'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `syncobj_grant_to'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_start'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `eventobj_post'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to
>> `heapobj_init_array_private'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `threadobj_shadow'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to
>> `threadobj_wait_start'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to
>> `copperplate_renice_local_thread'
>> /usr/xenomai/lib/libalchemy.so: undefined reference to `semobj_uninit'
>> collect2: error: ld returned 1 exit status
>>
>> Thanks alot.
>>
>> Best Regards
>> Davide Brunelli
>>
>> *Electronic Vbm Group*
>> e-mail: electronic2@vbm-grp.com <mailto:electronic2@vbm-grp.com>
>>
>> Vbm Group <http://service.vbm-grp.com/signature/logogrp.png>
>>
>>
>> Vbm Group Vbm Group Vbm Group
>>
>>
>> *Vbm Group is a trademark of VI.BE.MAC S.p.a.*
>>
>> *Declaration according to Law No. 196 of 30 June 2003*
>> We hereby inform you that your data will be treated automatically,
>> according to the current security regulations for written
>> correspondence; your data will not be spread by Vi.Be.Mac. Spa. In any
>> way, as far as your data are concerned, you have the rights indicated in
>> art. No. 13 L. 675/1996 (such as access, cancellation, modification,
>> objection, etc.). Vi.Be.Mac. Spa. Is the holder of treatment of your
>> data. Vi.Be.Mac. is located in via Monte Pastello, 7/i (Vr) Italy. For
>> further information, please write to: privacy@vibemac.com According to
>> Art. No. 13 of law 196/2003, in any moment and free of any charge you
>> have the right to deny the use of your personal data to send you written
>> correspondence. You just have to advise about this by writing to:
>> privacy@vibemac.com
>>
>>
>> *Informativa ai sensi del d.lgs n. 196, 30.6.2003*
>> I suoi dati saranno trattati in forma automatizzata, nel rispetto delle
>> idonee misure di sicurezza, per l'invio di comunicazioni e non saranno
>> soggetti a diffusione all'esterno di Vi.Be.Mac. Spa. In relazione al
>> trattamento dei dati, potr=E0 esercitare i diritti (accesso,cancellazion=
e,
>> rettifica, opposizione, etc.) specificamente previsti dall'art. 13 L.
>> 675/1996 e nelle modalit=E0 ivi contemplate. Titolare del trattamento dei
>> dati =E8 Vi.Be.Mac. Spa, con sede legale in San Giovanni Lupatoto (Vr) v=
ia
>> Monte Pastello 7/i. Per informazioni scrivere a privacy@vibemac.com Ai
>> sensi dell'art. 13 del d.lgs. 196/2003, potr=E0 opporsi in ogni momento,
>> in via gratuita, al trattamento dei suoi dati al fine dell'invio di
>> analoghe comunicazioni a mezzo di posta elettronica, semplicemente
>> comunicandocelo all'indirizzo e-mail privacy@vibemac.com Qualsiasi
>> utilizzo non autorizzato del presente messaggio nonch=E8 dei suoi allega=
ti
>> =E8 vietato e potrebbe costituire reato. Se lei ha ricevuto erroneamente
>> il presente messaggio, Le saremmo grati se via e-mail ce ne comunicasse
>> la ricezione e provvedesse alla distruzione del messaggio stesso e dei
>> suoi eventuali allegati.
>>
>> VI.BE.MAC s.p.a. - 37057 S. GIOVANNI LUPATOTO (VR) ITALY - Via Monte
>> Pastello, 7/i - Tel. +39 045 8778151/52 - Fax +39 045 8779024 - Cod.
>> Fisc./Partita IVA 01264050236- Cap. Soc. Euro 2.000.000,00 int. Vers. -
>> Reg. Imprese di VERONA N. 01264050236 - REA N. 170441
>> Societ=E0 soggetta a direzione e coordinamento di Jack Europe S.=E0.r.l.
>> Il 05/12/2019 08:44, Jan Kiszka ha scritto:
>>> On 05.12.19 08:35, Electronic Dept. - Vbm Group via Xenomai wrote:
>>>> Hello Jan,
>>>>
>>>> thank you for your answer.
>>>>
>>>> My Xenomai version is:
>>>>
>>>> Xenomai/cobalt v3.0.9 -- #5b99a61 (2019-11-04 19:44:03 +0100)
>>> OK, but when I call "xeno-config --skin=3Dalchemy --ldflags" for that
>>> version, I do have "-lalchemy" in the output. That would fix your
>>> linking issue. Can you check the output you get?
>>>
>>> Jan
>>>
Pls forgive the interruption on your thread, I noticed the makefile=20
quoted as:


MAIN_SRC=3D cyclic_test
TARGET=A0=A0=A0 =3D cyclic_test

SKIN =A0=A0=A0 :=3D alchemy
CFLAGS =A0=A0=A0 :=3D $(shell /usr/xenomai/bin/xeno-config --skin=3D$(skin)=
 --cflags)
LDFLAGS :=3D $(shell /usr/xenomai/bin/xeno-config --skin=3D$(skin) --ldflag=
s)
CC =A0=A0=A0 :=3D $(shell /usr/xenomai/bin/xeno-config --cc)

$(TARGET): $(MAIN_SRC).c
 =A0=A0=A0 $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)

clean:
 =A0=A0=A0 @rm $(MAIN_SRC)


The documentation I have on 'make' says that variable names are case=20
sensitive, and so the substitution of the --skin=3D$(skin) is going to=20
substitute an empty string instead of 'alchemy'.=A0 I tried using just=20
--skin=3D on my copy of xeno-config and there was no error or warning=20
about an invalid skin name, and as expected it didn't emit the=20
alchemy-specific option strings.=A0 So probably when it is changed to=20
--skin=3D$(SKIN) things will improve.


Best Regards,

Steve


