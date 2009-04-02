From: "Charlton, John" <john.charlton@domain.hid>
Date: Thu, 2 Apr 2009 08:01:43 -0400
Message-ID: <CF7FB0793253794F9F45991443E5FE200513F8F2AB@us194mx002.tycoelectronics.net>
References: <CF7FB0793253794F9F45991443E5FE200513A0636F@us194mx002.tycoelectronics.net>
	<49BFC742.8010409@domain.hid>
	<54F3C3916FD0724091580775FA3604FB752B0BE8@domain.hid>
In-Reply-To: <54F3C3916FD0724091580775FA3604FB752B0BE8@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Port rtai rt_request_srq to xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "rpm@xenomai.org" <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

The problem with the undefined symbols was due to compiling two external mo=
dules outside of the kernel tree and then trying to access exported symbols=
 from one module in the other external module.  The solution is all well do=
cumented in the linux 2.6 kernel document at: Documentation/kbuild/modules.=
txt in the kernel source.  The solution I used is to put the Module.symvers=
 file from the external module exporting the symbols into the build directo=
ry of the module using the exported symbols.  This worked well keeping both=
 modules outside of the kernel tree.  There are two other methods to accomp=
lish this documented in the above mentioned modules.txt file.

This was not an issue in the 2.4 kernel since external symbols are all reso=
lved at module load time by insmod but in the 2.6 kernel the external symbo=
ls are resolved at build/link time.

--John

-----Original Message-----
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] On=
 Behalf Of Charlton, John
Sent: Friday, March 27, 2009 11:02 AM
To: rpm@xenomai.org
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Port rtai rt_request_srq to xenomai

Thank you.  I was able to port the rtai kernel module driver to xenomai rtd=
m and it loads using insmod.  I see it in the /proc/modules list and it is =
properly displaying the /proc/<driver name> entries.  This kernel module ex=
ports functions using EXPORT_SYMBOL().  I compile and load another kernel m=
odules that uses the first modules functions but it fails to load: The seco=
nd kernel module has unknown symbol warnings for the first modules exported=
 symbols when I build the module and also when I load it and it fails to lo=
ad.  When I look in the /proc/kallsyms list the symbols exported by the fir=
st module are all there.

It seems to be a module version problem since the error output is: no symbo=
l version for <symbol name>

How do I specify to the second module that the undefined symbols (external =
functions) are in the first module at runtime?  This was not necessary in t=
he rtai linux 2.4 kernel since the modules were just object files that reso=
lved symbols at load time. I would rather not include these drivers in the =
kernel config/build if I can avoid it.

--John


-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]
Sent: Tuesday, March 17, 2009 11:53 AM
To: Charlton, John
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Port rtai rt_request_srq to xenomai

Charlton, John wrote:
> I am porting an rtai linux 2.4 kernel driver to xenomai-2.4.6.1 patched l=
inux 2.26.27.7 kernel.  I have done a fair amount of searching for the rtai=
 functions: rt_request_srq()/rt_free_srq() and have not found an equivalent=
 in xenomai. Would appreciate advice on how this can be done in xenomai or =
if the equivalent of this is not available in xenomai. It looks like rthal_=
apc_alloc() may be what I am looking for.
>

It is indeed what you are looking for, if you want a 1:1 replacement. Howev=
er, you may also want to consider porting your driver code over the RTDM fr=
amework, and use the rtdm_nrtsig support:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__rtdmir=
q.html

> --John
>=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--
Philippe.

_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help

