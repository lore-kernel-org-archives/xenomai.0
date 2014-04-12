References: <1396783490.22359.YahooMailNeo@web171604.mail.ir2.yahoo.com>
 <5347F5AD.1030201@xenomai.org>
Message-ID: <1397310776.26093.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Date: Sat, 12 Apr 2014 14:52:56 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <5347F5AD.1030201@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Race condition between threadobj_unlock and
	threadobj_free in t_resume
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

=0A=0A=0A=0A----- Original Message -----=0A> From: Philippe Gerum <rpm@xeno=
mai.org>=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai=
.org" <xenomai@xenomai.org>=0A> Cc: =0A> Sent: Friday, April 11, 2014 4:01 =
PM=0A> Subject: Re: [Xenomai] Race condition between threadobj_unlock and t=
hreadobj_free in t_resume=0A> =0A> On 04/06/2014 01:24 PM, Matthias Schneid=
er wrote:=0A> =0A>>  The following minimal program=0A>> =0A>>  http://paste=
bin.com/JdnnXwsF=0A>> =0A>>  seems to lead to a race condition between thre=
adobj_unlock=0A>>  and threadobj_free as indicated by valgrind (xenomai-for=
ge=0A>>  and mercury):=0A>> =0A>>  =3D=3D9573=3D=3D Invalid read of size 4=
=0A>>  =3D=3D9573=3D=3D=A0 =A0 at 0x403F214: threadobj_unlock (threadobj.h:=
407)=0A>>  =3D=3D9573=3D=3D=A0 =A0 by 0x403FAD2: put_psos_task (task.c:151)=
=0A>>  =3D=3D9573=3D=3D=A0 =A0 by 0x4040E9F: t_resume (task.c:419)=0A>>  =
=3D=3D9573=3D=3D=A0 =A0 by 0x80486F9: main (task-2.c:20)=0A>>  =3D=3D9573=
=3D=3D=A0 Address 0x42a20c4 is 172 bytes inside a block of size 664 =0A> fr=
ee'd=0A>>  =3D=3D9573=3D=3D=A0 =A0 at 0x4029C88: free (vg_replace_malloc.c:=
446)=0A>>  =3D=3D9573=3D=3D=A0 =A0 by 0x40641B6: pvfree (heapobj.h:156)=0A>=
>  =3D=3D9573=3D=3D=A0 =A0 by 0x406425A: xnfree (heapobj.h:421)=0A>>  =3D=
=3D9573=3D=3D=A0 =A0 by 0x406460C: threadobj_free (threadobj.h:285)=0A>>  =
=3D=3D9573=3D=3D=A0 =A0 by 0x4068C6B: finalize_thread (threadobj.c:1239)=0A=
>>  =3D=3D9573=3D=3D=A0 =A0 by 0x40B5AE5: __nptl_deallocate_tsd (pthread_cr=
eate.c:157)=0A>>  =3D=3D9573=3D=3D=A0 =A0 by 0x40B5CFE: start_thread (pthre=
ad_create.c:318)=0A>>  =3D=3D9573=3D=3D=A0 =A0 by 0x41C2C3D: clone (clone.S=
:131)=0A>>  =3D=3D9573=3D=3D=0A>> =0A>>  I am not sure on how to fix this, =
any ideas? I do admit=0A>>  that the use case is neither typical nor very u=
seful on its own,=0A>>  but it is used in my test environment.=0A>> =0A>>  =
It seems that when resuming a thread that already is in=0A>>  its finalizer=
 may lead to that thread's heap already being freed=0A>>  when it is about =
to being unlocked by the resume function.=0A> =0A> I could not reproduce th=
is issue with your test code (it's likely too =0A> timing-dependent), but l=
ooking at the backtrace above a bit closer, this =0A> patch should help:=0A=
> =0A> diff --git a/include/boilerplate/lock.h b/include/boilerplate/lock.h=
=0A> index dce1ff0..4819b34 100644=0A> --- a/include/boilerplate/lock.h=0A>=
 +++ b/include/boilerplate/lock.h=0A> @@ -177,9 +177,9 @@ int __check_cance=
l_type(const char *locktype);=0A> =0A> =A0 #define __do_unlock_safe(__lock,=
 __state)=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 \=0A> =A0 =A0=A0=A0 ({=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 \=0A> -=A0=A0=A0 =A0=A0=A0 int __ret;=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 \=0A> +=A0=A0=A0 =A0=A0=A0 int __ret, __restored=
_state =3D __state;=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 \=0A> =A0 =A0=A0=A0 =A0=A0=
=A0 __ret =3D -__RT(pthread_mutex_unlock(__lock));=A0=A0=A0 =A0=A0=A0 \=0A>=
 -=A0=A0=A0 =A0=A0=A0 pthread_setcancelstate(__state, NULL);=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 \=0A> +=A0=A0=A0 =A0=A0=A0 pthread_setcancelstate(__restor=
ed_state, NULL);=A0=A0=A0 =A0=A0=A0 \=0A> =A0 =A0=A0=A0 =A0=A0=A0 __ret;=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 \=0A> =
=A0 =A0=A0=A0 })=0A> =0A> -- =0A> Philippe.=0A> =0A=0AWith the patch I was =
no longer able to detect the issue (it occured=0Apretty reliably after 5-10=
 minutes and with the patch I had a successful=0Arun over night.=0A=0AThank=
s a lot for the quick fix,=0A=0AMatthias

