References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53676902.5050405@xenomai.org>
Message-ID: <1400437808.41304.YahooMailNeo@web171606.mail.ir2.yahoo.com>
Date: Sun, 18 May 2014 19:30:08 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53676902.5050405@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] FreeRTOS skin
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
enomai@xenomai.org>=0A> Cc: =0A> Sent: Monday, May 5, 2014 12:33 PM=0A> Sub=
ject: Re: [Xenomai] FreeRTOS skin=0A> =0A> On 05/04/2014 06:59 PM, Matthias=
 Schneider wrote:=0A> =0A>>  Hi all,=0A>> =0A>>  please find enclosed a pat=
ch with a FreeRTOS skin for xenomai-forge I have=0A>>  been=A0 working on f=
or some time. I would like to get some feedback and advice=0A>>  what still=
 needs to be done to get it accepted in Xenomai. There is a set of=0A>>  un=
it tests included and the possibility to download the original FreeRTOS pac=
kage=0A>>  in order to run most of its (platform independent) test suite. U=
ntil now I=A0have=0A>>  been working under mercury only. Documentation is a=
vailable in form of a README=0A>>  file in lib/freertos/README, which shoul=
d also be a good starting point.=0A> =0A> Ok, thanks for this. Let's addres=
s issues gradually, starting with the =0A> task module.=0A> =0A[...]=0A> =
=0A> - the read/write_lock_nocancel() form is reserved for protecting =0A> =
sections which are known not to traverse cancellation points, as defined =
=0A> by POSIX =0A> (http://pubs.opengroup.org/onlinepubs/009695399/function=
s/xsh_chap02_09.html). =0A> This is about self-documentation of the code, a=
nd optimizing execution =0A> by omitting costly management of cleanup block=
s when it is deemed safe =0A> to do so.=0A> =0A> - CANCEL_DEFER() / CANCEL_=
RESTORE() should protect sections against =0A> asynchronous cancellation, w=
e typically do this before invoking the =0A> copperplate layer, so that we =
may assume that pthread_cancel() won't be =0A> a problem when running inner=
 code, provided we have been careful about =0A> handling read/write lock cl=
eanups. These macros work by disabling =0A> asynchronous cancellation for t=
he current thread when =0A> --enable-async-cancel was given at build time. =
Otherwise, this part is a =0A> nop.=0A=0AObviously the *nocancel locks in m=
y previous patch (task.c) were incorrect.=A0=0AHowever I am not sure which =
way to replace them - I see several possibilities:=0A=0Aa)=A0=0Apush_cleanu=
p_lock(&freertos_scheduler.lock);=A0=0Awrite_lock(&freertos_scheduler.lock)=
;=A0=0A//will correctly clean up when thread is=A0cancelled=0A=0Ab)=0Awrite=
_lock_safe(&freertos_scheduler.lock);=A0=0A// will disable cancellation unt=
il=A0lock is released=0A=0Ac)=0Ado no care about locks in cancelled threads=
 and just use=A0=0Awrite_lock(&freertos_scheduler.lock)=0A=0ASince freertos=
_scheduler.lock is essential for the correct functioning of the=A0=0AFreeRT=
OS skin, c) is probably out.=0A=0AAny hint?=0A=0AThanks,=0AMatthias

