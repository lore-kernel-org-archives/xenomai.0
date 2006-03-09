Message-ID: <44103CB9.2080905@domain.hid>
Date: Thu, 09 Mar 2006 11:33:29 -0300
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai as module changing bzImage
References: <200603081433.02339.lbocseg@domain.hid> <440F340A.9040109@domain.hid>
In-Reply-To: <440F340A.9040109@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Thank you Jan and Philippe for pointing me that the changes is due to=20
HAL portion. Now I know I don't need to worry about that and that I can=20
use the new modules in a safe way without the need of rebooting the system.

Jan, actually the binary output is different, at least for the HAL=20
portion... And thank you for the fast howto on svn. I appreciate it a=20
lot. I think it will be much simpler to be up to date with xenomai trunk. :)

Thank you guys! Answering part of the Xenomai x RTLinux Jeff's question,=20
one more reason to stay with Xenomai is the support we can get here from=20
you. That is the best list support I've ever seen.

Best Regards,

Rodrigo.



Jan Kiszka escreveu:
> Rodrigo Rosenfeld Rosas wrote:
>  =20
>> Hi Philippe,
>>
>> I disabled the kernel .config support, recompiled the kernel with latest=
 ipipe=20
>> patch and rebooted my system (Xenomai configured as a module).
>>
>> Then I downloaded last svn Xenomai. Compiled it (after correcting drvlib=
.c of=20
>> rtdm skin) and noted that it has changed the kernel bzImage too, besides=
=20
>> building the modules. Although I can use the new Xenomai modules without=
=20
>> rebooting my system, I can not understand why should bzImage change. Hav=
e you=20
>> any idea?
>>    =20
>
> Even if you turn on module support for all Xenomai components in the 2.1
> series, there are still some bits (the HAL) being compiled directly into
> kernel. So, any modification of headers etc. may trigger a recompilation
> although the binary output will be the same.
>
> Jan
>
>  =20


	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


