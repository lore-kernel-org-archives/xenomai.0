From: Lange Norbert <norbert.lange@andritz.com>
Subject: RE: libcopperplate.so depends on modecheck?
Date: Fri, 31 May 2019 12:12:35 +0000
Message-ID: <VI1PR05MB59179589CFDB55840B07A386F6190@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

I still believe this to be a bug, adding a patch to correct this.

Regards, Norbert

> -----Original Message-----
> From: Lange Norbert
> Sent: Mittwoch, 20. M=E4rz 2019 11:49
> To: Xenomai (xenomai@xenomai.org) <xenomai@xenomai.org>
> Subject: libcopperplate.so depends on modecheck?
>
> Hello,
>
> Seems like libcopperplate.so always depends on libmodechk.so, as the
> following symbols would imply:
>
> nm -D /home/lano/buildroot/host/x86_64-buildroot-linux-
> gnu/sysroot/usr/xenomai/lib/libcopperplate.so | grep __real
>                  U __real_free
>                  U __real_malloc
>
> xeno-config deals with this by always linking modeck, even if you add --n=
o-
> mode-check-
>
> I am not completely confident with the wrapper-magic, but shouldn't
> libcopperplate use either cobalt_malloc or the libc malloc?
> __real_malloc is just a stub for libc malloc, so I really don't get the p=
oint
> (assuming this is intentional).
>
> Modeswitches could also be detected by interposing libraries, so removing
> libmodechk Is a viable thing to do.
> (shameless plug: https://github.com/nolange/preload_checkers )
>
>
> Regards, Norbert
________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr=E4nkter Haftung / Corporati=
on

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-remove-__STD-for-heap-function.patch
Type: application/octet-stream
Size: 5265 bytes
Desc: 0001-remove-__STD-for-heap-function.patch
URL: <http://xenomai.org/pipermail/xenomai/attachments/20190531/6c808169/at=
tachment.obj>
