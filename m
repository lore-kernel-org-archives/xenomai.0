Message-ID: <4B4F4F65.9090006@domain.hid>
Date: Thu, 14 Jan 2010 18:07:49 +0100
From: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
MIME-Version: 1.0
References: <4B4E00B3.5090607@domain.hid> <4B4F2DA5.4000606@domain.hid>
In-Reply-To: <4B4F2DA5.4000606@domain.hid>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] problem with libanalogy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Simon Boulay wrote:
> Hi,
>
> On 01/13/2010 06:19 PM, Alessio Margan @ IIT wrote:
>  =20
>> Hi,
>>
>> I've got "Segmentation fault" from libanalogy.so.1
>> Here is part of code ...
>>
>> int s526Analogy::Open()
>> {
>> int ret =3D 0;
>> boardIsOpen =3D false;
>>
>> ret =3D a4l_open(&dsc, dev_name);
>> if (ret<  0) {
>> fprintf(stderr, "s526Analogy::Open : a4l_open %s failed (ret=3D%d)\n",
>> dev_name, ret);
>> return boardIsOpen;
>> }
>>
>> fprintf(stderr, "s526Analogy::Open : name : %s\nsubd %d\nrd subd %d\nwr
>> subd %d\nfd %d\nmagic %x\nsize %d\n",
>> dsc.board_name,
>> dsc.nb_subd,
>> dsc.idx_read_subd,
>> dsc.idx_write_subd,
>> dsc.fd,
>> dsc.magic,
>> dsc.sbsize);
>>
>> dsc.sbdata =3D malloc(dsc.sbsize);
>> if (dsc.sbdata =3D=3D NULL) {
>> ret =3D -ENOMEM;
>> fprintf(stderr, "s526Analogy::Open : info buffer allocation failed\n");
>> return boardIsOpen;
>> }
>> ret =3D a4l_fill_desc(&dsc);
>> if (ret<  0) {
>> fprintf(stderr, "s526Analogy::Open : a4l_fill_desc failed (ret=3D%d)\n",=
 ret);
>> return boardIsOpen;
>> }
>>
>> boardIsOpen =3D true;
>> printf("Open %s\n", dev_name);
>>
>> return boardIsOpen;
>> }
>>
>> and here is the back trace from gdb ....
>>
>> s526Analogy::Open : name : analogy_s526
>> subd 4
>> rd subd 1
>> wr subd 2
>> fd 0
>> magic 1234abcd
>> size 1560
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> [Switching to Thread 0xb7151990 (LWP 6138)]
>> 0xb773a64a in a4l_sys_desc () from /usr/xenomai/lib/libanalogy.so.1
>> Current language: auto; currently asm
>> (gdb) bt
>> #0 0xb773a64a in a4l_sys_desc () from /usr/xenomai/lib/libanalogy.so.1
>> #1 0xb773a748 in a4l_fill_desc () from /usr/xenomai/lib/libanalogy.so.1
>> #2 0x0804ebb2 in s526Analogy::Open (this=3D0x805e560) at s526Analogy.cpp=
:55
>> #3 0x0804f8c6 in configure_board () at s526Main.cpp:95
>> #4 0x0804f96a in main () at s526Main.cpp:115
>> (gdb)
>>
>> dmesg give me ...
>>
>> app[6454]: segfault at 40 ip b772964a sp bfd372d0 error 4 in
>> libanalogy.so.1.0.0[b7728000+3000]
>>
>>
>> Yesterday I pull xenomai-head to get last commits, before I've run the
>> application without this segfault.
>>    =20
> I can't reproduce your problem.
> Does the same thing happen with the following command:
> insn_read -v -d analogy0?
>
> Simon.
>
>  >
>  =20
>> TIA
>>
>> Alessio
>>
>>
>>    =20
Thanks,

insn_read and insn_write works fine, seems that reset the buffer wiht=20
zeroes works ...

dsc.sbdata =3D malloc(dsc.sbsize);
bzero(dsc.sbdata, dsc.sbsize);
or
dsc.sbdata =3D calloc(dsc.sbsize,1);

without I got segfaults.

Any idea ?

Alessio
--=20

ISTITUTO ITALIANO
DI TECNOLOGIA

Alessio Margan
/Senior Technician/
mail me <mailto:alessio.margan@domain.hid>

Via Morego, 30 16163 Genova=20
<http://maps.google.com/maps?f=3Dq&hl=3Den&geocode=3D&q=3Dvia+morego,+30+ge=
nova&sll=3D37.0625,-95.677068&sspn=3D85.420533,191.601563&ie=3DUTF8&ll=3D44=
.474913,8.907037&spn=3D0.004685,0.011652&t=3Dh&z=3D17&iwloc=3Daddr>

www.iit.it <http://www.iit.it>

*Legal Disclaimer*
This electronic message contains information that is confidential. The=20
information is intended for the use of the addressee only. If you are=20
not the addressee we would appreciate your notification in this respect.=20
Please note that any disclosure, copy, distribution or use of the=20
contents of this message is prohibited and may be unlawful. We have=20
taken every reasonable precaution to ensure that any kind of attachment=20
to this e-mail has been swept for viruses. However, we cannot accept=20
liability for any damage sustained as a result of software viruses and=20
would advise you to carry out your own virus checks before opening any=20
attachment.
*Avvertenza legale*
Questo messaggio Email contiene informazioni confidenziali riservate ai=20
soli destinatari. Qualora veniate in possesso di tali informazioni senza=20
essere definito come destinatario vi reghiamo di leggere le seguenti=20
note. Ogni apertura, copia, distribuzione del contenuto del messaggio e=20
dei suoi allegati =E8 proibito e potrebbe violare le presenti leggi.=20
Abbiamo attivato ogni possibile e ragionevole precauzione per assicurare=20
che gli allegati non contengano virus. Comunque non assumeremo alcuna=20
responsabilit=E0 per ogni eventuale danno causato da virus software e=20
simili in quanto =E8 onere del destinatario verificarne l=92assenza in ogni=
=20
allegato attuando propri indipendenti controlli.


