MIME-Version: 1.0
Sender: lcasassa@domain.hid
In-Reply-To: <47a3101a0910021624w3f0c5dcetd9bd7e23286acd28@domain.hid>
References: <47a3101a0910021152ud2cac28yb23708144418fe64@domain.hid> 
	<47a3101a0910021624w3f0c5dcetd9bd7e23286acd28@domain.hid>
From: Linus Casassa <linus@domain.hid>
Date: Fri, 2 Oct 2009 19:31:04 -0400
Message-ID: <47a3101a0910021631r16f439cbi15974c5c81324be8@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd29278860f5b0474fc29f9
Subject: Re: [Xenomai-help] Compiling xenomai task with bitbake
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--000e0cd29278860f5b0474fc29f9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry, I figured it out. I need -lnative option.

On Fri, Oct 2, 2009 at 7:24 PM, Linus Casassa <linus@domain.hid> wrote:

> I made some progress. I try to compile it manualy and found that the
> include path for xenomai headers is:
>
> ~/gumstix/gumstix-oe/tmp/work/armv5te-angstrom-linux-gnueabi/xenomai-2.4.=
6-r0/image/usr/include/xenomai
>
> But I get an error from linker:
>
> linus@domain.hid$ gcc
> -I/home/linus/gumstix/gumstix-oe/tmp/work/armv5te-angstrom-linux-gnueabi/=
xenomai-2.4.6-r0/image/usr/include/xenomai
> -L/home/linus/gumstix/gumstix-oe/tmp/work/armv5te-angstrom-linux-gnueabi/=
xenomai-2.4.6-r0/install/xenomai/usr/lib
> *.c -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -lpthread
> /tmp/ccxU3FTz.o: In function `alarm_server':
> main.c:(.text+0x24): undefined reference to `rt_alarm_wait'
> /tmp/ccxU3FTz.o: In function `cleanup':
> main.c:(.text+0x88): undefined reference to `rt_alarm_delete'
> main.c:(.text+0x90): undefined reference to `rt_task_delete'
> /tmp/ccxU3FTz.o: In function `main':
> main.c:(.text+0xf0): undefined reference to `rt_alarm_create'
> main.c:(.text+0x11c): undefined reference to `rt_alarm_start'
> main.c:(.text+0x140): undefined reference to `rt_task_create'
> main.c:(.text+0x164): undefined reference to `rt_task_start'
> collect2: ld returned 1 exit status
> linus@domain.hid=
t/files$
>
>
> On Fri, Oct 2, 2009 at 2:52 PM, Linus Casassa <linus@domain.hid> wrote:
>
>> Does anyone have a .bb example file?
>>
>> xeno-config does not exist in bitbake so I get:
>> native/task.h: No such file or directory
>>
>> Thanks for the help.
>>
>> --
>> Linus Casassa
>> Estudiante Ingenier=EDa Civil Electr=F3nica
>> Fono: 56-9-97776941
>>
>
>
>
> --
> Linus Casassa
> Estudiante Ingenier=EDa Civil Electr=F3nica
> Fono: 56-9-97776941
>



--=20
Linus Casassa
Estudiante Ingenier=EDa Civil Electr=F3nica
Fono: 56-9-97776941

--000e0cd29278860f5b0474fc29f9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry, I figured it out. I need -lnative option.<br><br><div class=3D"gmail=
_quote">On Fri, Oct 2, 2009 at 7:24 PM, Linus Casassa <span dir=3D"ltr">&lt=
;<a href=3D"mailto:linus@domain.hid">linus@domain.hid</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204,=
 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

I made some progress. I try to compile it manualy and found that the includ=
e path for xenomai headers is:<br>~/gumstix/gumstix-oe/tmp/work/armv5te-ang=
strom-linux-gnueabi/xenomai-2.4.6-r0/image/usr/include/xenomai<br><br>
But I get an error from linker:<br>

<br>linus@domain.hid$ gcc -I/home/linus/gumstix/gumstix-oe/tm=
p/work/armv5te-angstrom-linux-gnueabi/xenomai-2.4.6-r0/image/usr/include/xe=
nomai -L/home/linus/gumstix/gumstix-oe/tmp/work/armv5te-angstrom-linux-gnue=
abi/xenomai-2.4.6-r0/install/xenomai/usr/lib *.c -D_GNU_SOURCE -D_REENTRANT=
 -D__XENO__ -lpthread<br>


/tmp/ccxU3FTz.o: In function `alarm_server&#39;:<br>main.c:(.text+0x24): un=
defined reference to `rt_alarm_wait&#39;<br>/tmp/ccxU3FTz.o: In function `c=
leanup&#39;:<br>main.c:(.text+0x88): undefined reference to `rt_alarm_delet=
e&#39;<br>


main.c:(.text+0x90): undefined reference to `rt_task_delete&#39;<br>/tmp/cc=
xU3FTz.o: In function `main&#39;:<br>main.c:(.text+0xf0): undefined referen=
ce to `rt_alarm_create&#39;<br>main.c:(.text+0x11c): undefined reference to=
 `rt_alarm_start&#39;<br>


main.c:(.text+0x140): undefined reference to `rt_task_create&#39;<br>main.c=
:(.text+0x164): undefined reference to `rt_task_start&#39;<br>collect2: ld =
returned 1 exit status<br><font color=3D"#888888">linus@domain.hid=
stix/gumstix-oe/user.collection/packages/xenoTest/files$ <br>

</font><div><div></div><div class=3D"h5">
<br><div class=3D"gmail_quote">On Fri, Oct 2, 2009 at 2:52 PM, Linus Casass=
a <span dir=3D"ltr">&lt;<a href=3D"mailto:linus@domain.hid" target=3D"_blank">l=
inus@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; =
padding-left: 1ex;">


Does anyone have a .bb example file?<br><br>xeno-config does not exist in b=
itbake so I get:<br>native/task.h: No such file or directory<br clear=3D"al=
l"><br>Thanks for the help.<br><font color=3D"#888888"><br>-- <br>Linus Cas=
assa<br>


Estudiante Ingenier=EDa Civil Electr=F3nica<br>
Fono: 56-9-97776941<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Linus Casassa<br=
>Estudiante Ingenier=EDa Civil Electr=F3nica<br>Fono: 56-9-97776941<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Linus Casas=
sa<br>Estudiante Ingenier=EDa Civil Electr=F3nica<br>Fono: 56-9-97776941<br=
>

--000e0cd29278860f5b0474fc29f9--

