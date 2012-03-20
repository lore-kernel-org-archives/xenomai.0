Date: Tue, 20 Mar 2012 11:17:18 -0400
From: Glen Wernersbach <glen@domain.hid>
Message-ID: <CB8E17BE.1EE36%glen@domain.hid>
In-Reply-To: <4F689CE5.2090703@domain.hid>
Mime-version: 1.0
Content-type: multipart/related;
	boundary="B_3415087045_28985757"
Subject: Re: [Xenomai-help] Linux Serial Does not work with
 CONFIG_XENO_OPT_PERVASIVE enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

> This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--B_3415087045_28985757
Content-type: multipart/alternative;
	boundary="B_3415087045_28997675"


--B_3415087045_28997675
Content-type: text/plain;
	charset="ISO-8859-1"
Content-transfer-encoding: quoted-printable

Don't have a full dev enviroment on my embedded arm. Here is the program.
Very very basic:
-------
#include <stdio.h>
#include <termios.h>
#include <errno.h>
#include <fcntl.h>


/*Artila*/
#define MATRIX500_GET_UART_TYPE        0xe001
#define MATRIX500_SET_UART_TYPE        0xe002
#define MATRIX500_GET_UART_MODE9    0xe003
#define MATRIX500_SET_UART_MODE9    0xe004
#define MATRIX500_UART_SET_BAUD        0xe006

#define MATRIX500_UART_TYPE_232        232
#define MATRIX500_UART_TYPE_422        422
#define MATRIX500_UART_TYPE_485        485
int
main(argc, argv)
    int    argc;
    char    *argv[];
{

    int    fd, ret;
  struct termios term;
    char    buf[]=3D"XBCDEFHIJKM\0";
    char  buf2[1024]    ;

    struct termios T_new;

    /*open tty port*/
    fd =3D open("/dev/ttyS4", O_RDWR | O_NOCTTY | O_NDELAY);
    if (fd =3D=3D -1) {
        printf("open /dev/ttyS0 Failed, errno: %d\r\n", errno);
        return 0;
    }

  unsigned long interface2=3D0;
  ioctl(fd, MATRIX500_GET_UART_TYPE, &interface2) ;
  printf("set UART type: %d...Failed, errno: %d\r\n", interface2, errno);
 =20
    /*set serial interface: RS-422*/
    interface2 =3D MATRIX500_UART_TYPE_422;
    if(ioctl(fd, MATRIX500_SET_UART_TYPE, &interface2) !=3D 0) {
        printf("set UART type: %d...Failed, errno: %d\r\n", interface2,
errno);
        close(fd);
        return 0;
    }
   =20
    unsigned long mode9 =3D 0;
    ioctl(fd, MATRIX500_GET_UART_MODE9, &mode9);
    printf("mode: %d...Failed, errno: %d\r\n", mode9, errno);
   =20
    mode9=3D0;
   =20
    if (ioctl(fd, MATRIX500_SET_UART_MODE9, &mode9)!=3D 0) {
        printf("mode: %d...Failed, errno: %d\r\n", mode9, errno);
        close(fd);
        return 0;
    }
//it appears this is not getting set but no error.
   =20
    if(tcgetattr(fd,&term) !=3D 0) {
                    printf("tcgetattr failed\n");
               =20
            }=20
            term.c_cflag =3D (B921600 | CS8 | CREAD | CLOCAL | HUPCL);
            term.c_oflag =3D 0;
            term.c_iflag =3D 0;
            term.c_lflag =3D 0;
            if(tcsetattr(fd,TCSANOW,&term) !=3D 0) {
                    printf("tcsetattr failed\n");
               =20
            }=20
    //set baud rate at 4 times 921.6m
   =20
    unsigned long baud =3D 921600UL*4;
    if (ioctl(fd , MATRIX500_UART_SET_BAUD , &baud ) !=3D 0) {
        printf("set baud: %d...Failed, errno: %d\r\n", baud, errno);
        close(fd);
        return 0;
    }

   =20
     close(fd);





    =20
     fd =3D open("/dev/ttyS4", O_RDWR | O_NOCTTY | O_NDELAY);
    if (fd =3D=3D -1) {
        printf("open /dev/ttyS0 Failed, errno: %d\r\n", errno);
        return 0;
    }
   =20
         =20
  //write the data to my device which echos them back
  write(fd, buf, sizeof(buf)-1);
 =20
 //will wait forever here.
    while(1) {
        //wait for all 12 characters to received in fifo and then print the=
m
to the console
       =20
       =20
        ret =3D read(fd, buf2, sizeof(buf)-1);
        if (ret =3D=3Dsizeof(buf)-1) {
          buf2[ret]  =3D'\0' ;
          printf("got data %s\n",  buf2) ;
             break;
     =20
        }=20
       =20
         =20
    }
   =20
=20
        close(fd) ;
    return 0;
}

------



On 3/20/12 11:06 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:

> On 03/20/2012 03:53 PM, Glen Wernersbach wrote:
>> Ipipe version:
>> 1.13-05
>>=20
>>=20
>> Yes, I do have the co kernel and interrupt pipeline enabled
>=20
> ldd <your-serial-app> ?
>=20
>>=20
>>=20
>> On 3/20/12 10:47 AM, "Philippe Gerum"<rpm@xenomai.org>  wrote:
>>=20
>>> On 03/20/2012 03:34 PM, Glen Wernersbach wrote:
>>>> Working on the Strace.
>>>>=20
>>>> I don't have the /proc/xenomai/hal file??
>>>=20
>>> /proc/ipipe/version then.
>>>=20
>>>>=20
>>>> Again. Nothing I am running is xeno. Its just a xeno patched kernel.
>>>>=20
>>>=20
>>> Ok, but you do have the Xenomai co-kernel enabled in your kernel build,
>>> and the interrupt pipeline is enabled as well, right?
>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>> On 3/20/12 10:31 AM, "Philippe Gerum"<rpm@xenomai.org>   wrote:
>>>>=20
>>>>> On 03/20/2012 03:17 PM, Philippe Gerum wrote:
>>>>>> On 03/20/2012 03:07 PM, Glen Wernersbach wrote:
>>>>>>> I went through and disabled everything in xeno except
>>>>>>> CONFIG_XENO_OPT_PERVASIVE, did not work. Take that option out and i=
t
>>>>>>> works.
>>>>>>>=20
>>>>>>> Take that option out at anytime it works.
>>>>>>>=20
>>>>>>> My program basic writes a few characters a serial port and then rea=
ds
>>>>>>> them
>>>>>>> back in from the same port. I have a loop back cable connected to t=
he
>>>>>>> port.
>>>>>>>=20
>>>>>>> It writes the data but waits forever to read them back in
>>>>>>>=20
>>>>>>>>    From my tests, it appears that the termois tcsetaddr settings i=
s not
>>>>>>>> getting
>>>>>>> set when I call it when this option is on.
>>>>>>=20
>>>>>> Can you strace your app when it runs, please?
>>>>>=20
>>>>> The interrupt pipeline release number would help as well
>>>>> (/proc/xenomai/hal).
>>>>>=20
>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> On 3/20/12 9:57 AM, "Philippe Gerum"<rpm@xenomai.org>   wrote:
>>>>>>>=20
>>>>>>>> On 03/20/2012 02:48 PM, Glen Wernersbach wrote:
>>>>>>>>> I don't think this is it directly.
>>>>>>>>>=20
>>>>>>>>> This program was made on the same kernel prior to patching it wit=
h
>>>>>>>>> Xeno.
>>>>>>>>>=20
>>>>>>>>> It should still run like any other linux program.
>>>>>>>>=20
>>>>>>>> - what does "program not working" mean in your case? Any errno ret=
urn
>>>>>>>> we
>>>>>>>> could interpret? Any strace output?
>>>>>>>>=20
>>>>>>>> - what if you disable CONFIG_XENO_OPT_SKIN_RTDM, leaving PERVASIVE=
 on?
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> On 3/20/12 9:44 AM, "Philippe Gerum"<rpm@xenomai.org>   wrote:
>>>>>>>>>=20
>>>>>>>>>> On 03/20/2012 02:28 PM, Glen Wernersbach wrote:
>>>>>>>>>>> Hi All,
>>>>>>>>>>>=20
>>>>>>>>>>> I install Xenomai 2.6.0 on AT91SAM9G20 system and have found th=
at
>>>>>>>>>>> when
>>>>>>>>>>> CONFIG_XENO_OPT_PERVASIVE is enabled my standard non real time =
linux
>>>>>>>>>>> serial write then read serial program does not work.
>>>>>>>>>>>=20
>>>>>>>>>>> If I turn off CONFIG_XENO_OPT_PERVASIVE, my serial program does
>>>>>>>>>>> work.
>>>>>>>>>>>=20
>>>>>>>>>>> Any ideas why?????
>>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> A possible explanation would be that your application links with=
 the
>>>>>>>>>> Xenomai POSIX lib (libpthread_rt), albeit it should not.
>>>>>>>>>>=20
>>>>>>>>>> With pervasive support disabled, any routing from the overloaded
>>>>>>>>>> POSIX
>>>>>>>>>> I/O calls to the Xenomai kernel would then fail.
>>>>>>>>>>=20
>>>>>>>>>> If so, you should not link against the Xenomai libs if you need =
no
>>>>>>>>>> -rt
>>>>>>>>>> service, or prevent symbol wrapping only for the POSIX I/O calls=
 by
>>>>>>>>>> prefixing them by __real_* if you want Xenomai-enabled POSIX ser=
vices
>>>>>>>>>> except the I/O support.
>>>>>>>>>>=20
>>>>>>>>>> See=20
>>>>>>>>>> http://xenomai.org/index.php/Porting_POSIX_applications_to_Xenom=
ai
>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> Also, when you turn CONFIG_XENO_OPT_PERVASIVE you get this erro=
r:
>>>>>>>>>>> CC kernel/xenomai/nucleus/synch.o
>>>>>>>>>>> kernel/xenomai/nucleus/synch.c: In function
>>>>>>>>>>> 'xnsynch_release_thread':
>>>>>>>>>>> kernel/xenomai/nucleus/synch.c:688:3: error: implicit declarati=
on of
>>>>>>>>>>> function 'xnthread_get_rescnt'
>>>>>>>>>>> kernel/xenomai/nucleus/synch.c:689:4: error: implicit declarati=
on of
>>>>>>>>>>> function 'xnshadow_send_sig'
>>>>>>>>>>>=20
>>>>>>>>>>> I had to go in and make the code for that option befor it alway=
s
>>>>>>>>>>> false.
>>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> http://git.xenomai.org/?p=3Dxenomai-2.6.git;a=3Dcommit;h=3D41b4f9c0f4b=
df061
>>>>>>>>>> 07
>>>>>>>>>> a7
>>>>>>>>>> 88b
>>>>>>>>>>=20
>>>>>>>>>> 76
>>>>>>>>>> 2b5cf662b1d4108
>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>>> Glen
>>>>>>>>>>> --
>>>>>>>>>>> Glen Wernersbach
>>>>>>>>>>> President&   CTO
>>>>>>>>>>>=20
>>>>>>>>>>> Jetsoft Development Co.
>>>>>>>>>>> 629 Old St Rt. 74 =AD Suite 210
>>>>>>>>>>> Cincinnati, Oh 45244
>>>>>>>>>>> Custom Programming Web Site: www.jetsoftdev.com
>>>>>>>>>>> Retail Products Web Site: www.scanhelp.com
>>>>>>>>>>> Phone: 513-528-6660
>>>>>>>>>>> Fax: 513-528-3470
>>>>>>>>>>> Cell 513-240-9929
>>>>>>>>>>> ----
>>>>>>>>>>> Partner for Software Technology
>>>>>>>>>>> Jacobs Automation
>>>>>>>>>>> 2365 Progress Drive
>>>>>>>>>>> Hebron, KY 41048
>>>>>>>>>>> (513) 297-7550
>>>>>>>>>>> ----
>>>>>>>>>>> "Support Dyslexia Research"
>>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> _______________________________________________
>>>>>>>>>>> Xenomai-help mailing list
>>>>>>>>>>> Xenomai-help@domain.hid
>>>>>>>>>>> https://mail.gna.org/listinfo/xenomai-help
>>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>=20
>>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>=20
>>>>=20
>>>=20
>>=20
>=20

--=20
Glen Wernersbach
President & CTO

Jetsoft Development Co.
629 Old St Rt. 74 =AD Suite 210
Cincinnati, Oh 45244
Custom Programming Web Site: www.jetsoftdev.com
Retail Products Web Site: www.scanhelp.com
Phone:   513-528-6660
Fax: 513-528-3470
Cell 513-240-9929
----
Partner for Software Technology
Jacobs Automation
2365 Progress Drive
Hebron, KY 41048=20
(513) 297-7550
----
"Support Dyslexia Research"


--B_3415087045_28997675
Content-type: text/html;
	charset="ISO-8859-1"
Content-transfer-encoding: quoted-printable

<HTML>
<HEAD>
<TITLE>Re: [Xenomai-help] Linux Serial Does not work with CONFIG_XENO_OPT_P=
ERVASIVE enabled</TITLE>
</HEAD>
<BODY>
<FONT FACE=3D"Calibri, Verdana, Helvetica, Arial"><SPAN STYLE=3D'font-size:11pt=
'>Don't have a full dev enviroment on my embedded arm. Here is the program. =
Very very basic:<BR>
-------<BR>
#include &lt;stdio.h&gt;<BR>
#include &lt;termios.h&gt;<BR>
#include &lt;errno.h&gt;<BR>
#include &lt;fcntl.h&gt;<BR>
<BR>
<BR>
/*Artila*/<BR>
#define MATRIX500_GET_UART_TYPE &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0=
xe001 &nbsp;<BR>
#define MATRIX500_SET_UART_TYPE &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0=
xe002 &nbsp;&nbsp;&nbsp;<BR>
#define MATRIX500_GET_UART_MODE9 &nbsp;&nbsp;&nbsp;0xe003 &nbsp;<BR>
#define MATRIX500_SET_UART_MODE9 &nbsp;&nbsp;&nbsp;0xe004 <BR>
#define MATRIX500_UART_SET_BAUD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0=
xe006<BR>
<BR>
#define MATRIX500_UART_TYPE_232 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2=
32<BR>
#define MATRIX500_UART_TYPE_422 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4=
22<BR>
#define MATRIX500_UART_TYPE_485 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4=
85<BR>
int<BR>
main(argc, argv)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;int &nbsp;&nbsp;&nbsp;argc;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;char &nbsp;&nbsp;&nbsp;*argv[];<BR>
{<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;int &nbsp;&nbsp;&nbsp;fd, ret;<BR>
&nbsp;&nbsp;struct termios term;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;char &nbsp;&nbsp;&nbsp;buf[]=3D&quot;XBCDEFHIJKM\0&qu=
ot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;char &nbsp;buf2[1024] &nbsp;&nbsp;&nbsp;;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;struct termios T_new;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;/*open tty port*/<BR>
&nbsp;&nbsp;&nbsp;&nbsp;fd =3D open(&quot;/dev/ttyS4&quot;, O_RDWR | O_NOCTTY=
 | O_NDELAY);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;if (fd =3D=3D -1) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;open /dev/ttyS=
0 Failed, errno: %d\r\n&quot;, errno);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;}<BR>
<BR>
&nbsp;&nbsp;unsigned long interface2=3D0;<BR>
&nbsp;&nbsp;ioctl(fd, MATRIX500_GET_UART_TYPE, &amp;interface2) ;<BR>
&nbsp;&nbsp;printf(&quot;set UART type: %d...Failed, errno: %d\r\n&quot;, i=
nterface2, errno);<BR>
&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;/*set serial interface: RS-422*/<BR>
&nbsp;&nbsp;&nbsp;&nbsp;interface2 =3D MATRIX500_UART_TYPE_422;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;if(ioctl(fd, MATRIX500_SET_UART_TYPE, &amp;interfac=
e2) !=3D 0) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;set UART type:=
 %d...Failed, errno: %d\r\n&quot;, interface2, errno);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;close(fd);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;}<BR>
&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;unsigned long mode9 =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;ioctl(fd, MATRIX500_GET_UART_MODE9, &amp;mode9);<BR=
>
&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;mode: %d...Failed, errno: %d\r\n&quot;=
, mode9, errno);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;mode9=3D0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;if (ioctl(fd, MATRIX500_SET_UART_MODE9, &amp;mode9)=
!=3D 0) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;mode: %d...Fai=
led, errno: %d\r\n&quot;, mode9, errno);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;close(fd);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;}<BR>
<FONT COLOR=3D"#FF0000">//it appears this is not getting set but no error. <B=
R>
</FONT> &nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;if(tcgetattr(fd,&amp;term) !=3D 0) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;tcgetattr failed\n=
&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} <=
BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ter=
m.c_cflag =3D (B921600 | CS8 | CREAD | CLOCAL | HUPCL);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ter=
m.c_oflag =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ter=
m.c_iflag =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ter=
m.c_lflag =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if(=
tcsetattr(fd,TCSANOW,&amp;term) !=3D 0) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;tcsetattr failed\n=
&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} <=
BR>
&nbsp;&nbsp;&nbsp;&nbsp;//set baud rate at 4 times 921.6m<BR>
&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;unsigned long baud =3D 921600UL*4;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;if (ioctl(fd , MATRIX500_UART_SET_BAUD , &amp;baud =
) !=3D 0) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;set baud: %d..=
.Failed, errno: %d\r\n&quot;, baud, errno);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;close(fd);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;}<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;close(fd);<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fd =3D open(&quot;/dev/ttyS4&quot;, O_RDWR | O_=
NOCTTY | O_NDELAY);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;if (fd =3D=3D -1) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;open /dev/ttyS=
0 Failed, errno: %d\r\n&quot;, errno);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;}<BR>
&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;//write the data to my device which echos them back &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;write(fd, buf, sizeof(buf)-1);<BR>
&nbsp;&nbsp;<BR>
&nbsp;<FONT COLOR=3D"#FF0000">//will wait forever here. <BR>
</FONT> &nbsp;&nbsp;&nbsp;while(1) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//wait for all 12 character=
s to received in fifo and then print them to the console<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D read(fd, buf2, sizeof=
(buf)-1);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ret =3D=3Dsizeof(buf)-1) {<=
BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;buf2[ret] &nbsp=
;=3D'\0' ;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;go=
t data %s\n&quot;, &nbsp;buf2) ;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;break; <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;}<BR>
&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;close(fd) ;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;return 0;<BR>
}<BR>
<BR>
------<BR>
<BR>
<BR>
<BR>
On 3/20/12 11:06 AM, &quot;Philippe Gerum&quot; &lt;<a href=3D"rpm@xenomai.org=
g">rpm@xenomai.org</a>&gt; wrote:<BR>
<BR>
<FONT COLOR=3D"#0000FF">&gt; On 03/20/2012 03:53 PM, Glen Wernersbach wrote:<=
BR>
</FONT><FONT COLOR=3D"#008000">&gt;&gt; Ipipe version:<BR>
&gt;&gt; 1.13-05<BR>
&gt;&gt; <BR>
&gt;&gt; <BR>
&gt;&gt; Yes, I do have the co kernel and interrupt pipeline enabled<BR>
</FONT><FONT COLOR=3D"#0000FF">&gt; <BR>
&gt; ldd &lt;your-serial-app&gt; ?<BR>
&gt; <BR>
</FONT><FONT COLOR=3D"#008000">&gt;&gt; <BR>
&gt;&gt; <BR>
&gt;&gt; On 3/20/12 10:47 AM, &quot;Philippe Gerum&quot;&lt;<a href=3D"rpm@xenomai.org=
nomai.org">rpm@xenomai.org</a>&gt; &nbsp;wrote:<BR>
&gt;&gt; <BR>
</FONT><FONT COLOR=3D"#FF0000">&gt;&gt;&gt; On 03/20/2012 03:34 PM, Glen Wern=
ersbach wrote:<BR>
</FONT><FONT COLOR=3D"#800080">&gt;&gt;&gt;&gt; Working on the Strace.<BR>
&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt; I don't have the /proc/xenomai/hal file??<BR>
</FONT><FONT COLOR=3D"#FF0000">&gt;&gt;&gt; <BR>
&gt;&gt;&gt; /proc/ipipe/version then.<BR>
&gt;&gt;&gt; <BR>
</FONT><FONT COLOR=3D"#800080">&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt; Again. Nothing I am running is xeno. Its just a xeno patch=
ed kernel.<BR>
&gt;&gt;&gt;&gt; <BR>
</FONT><FONT COLOR=3D"#FF0000">&gt;&gt;&gt; <BR>
&gt;&gt;&gt; Ok, but you do have the Xenomai co-kernel enabled in your kern=
el build,<BR>
&gt;&gt;&gt; and the interrupt pipeline is enabled as well, right?<BR>
&gt;&gt;&gt; <BR>
</FONT><FONT COLOR=3D"#800080">&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt; On 3/20/12 10:31 AM, &quot;Philippe Gerum&quot;&lt;<a href=
=3D"rpm@xenomai.org">rpm@xenomai.org</a>&gt; &nbsp;&nbsp;wrote:<BR>
&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt; On 03/20/2012 03:17 PM, Philippe Gerum wrote:<BR>
&gt;&gt;&gt;&gt;&gt;&gt; On 03/20/2012 03:07 PM, Glen Wernersbach wrote:<BR=
>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; I went through and disabled everything in xeno=
 except<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; CONFIG_XENO_OPT_PERVASIVE, did not work. Take =
that option out and it<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; works.<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Take that option out at anytime it works.<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; My program basic writes a few characters a ser=
ial port and then reads<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; them<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; back in from the same port. I have a loop back=
 cable connected to the<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; port.<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; It writes the data but waits forever to read t=
hem back in<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;From my tests, it appear=
s that the termois tcsetaddr settings is not<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; getting<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; set when I call it when this option is on.<BR>
&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt; Can you strace your app when it runs, please?<BR>
&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt; The interrupt pipeline release number would help as we=
ll<BR>
&gt;&gt;&gt;&gt;&gt; (/proc/xenomai/hal).<BR>
&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 3/20/12 9:57 AM, &quot;Philippe Gerum&quot;=
&lt;<a href=3D"rpm@xenomai.org">rpm@xenomai.org</a>&gt; &nbsp;&nbsp;wrote:<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 03/20/2012 02:48 PM, Glen Wernersbach w=
rote:<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I don't think this is it directly.<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This program was made on the same kern=
el prior to patching it with<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Xeno.<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; It should still run like any other lin=
ux program.<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; - what does &quot;program not working&quot=
; mean in your case? Any errno return <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; we<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; could interpret? Any strace output?<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; - what if you disable CONFIG_XENO_OPT_SKIN=
_RTDM, leaving PERVASIVE on?<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 3/20/12 9:44 AM, &quot;Philippe Ger=
um&quot;&lt;<a href=3D"rpm@xenomai.org">rpm@xenomai.org</a>&gt; &nbsp;&nbsp;wr=
ote:<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 03/20/2012 02:28 PM, Glen Werne=
rsbach wrote:<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi All,<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I install Xenomai 2.6.0 on AT9=
1SAM9G20 system and have found that<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; when<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; CONFIG_XENO_OPT_PERVASIVE is e=
nabled my standard non real time linux<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; serial write then read serial =
program does not work.<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; If I turn off CONFIG_XENO_OPT_=
PERVASIVE, my serial program does <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; work.<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Any ideas why?????<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; A possible explanation would be th=
at your application links with the<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Xenomai POSIX lib (libpthread_rt),=
 albeit it should not.<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; With pervasive support disabled, a=
ny routing from the overloaded <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; POSIX<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I/O calls to the Xenomai kernel wo=
uld then fail.<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; If so, you should not link against=
 the Xenomai libs if you need no <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -rt<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; service, or prevent symbol wrappin=
g only for the POSIX I/O calls by<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; prefixing them by __real_* if you =
want Xenomai-enabled POSIX services<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; except the I/O support.<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; See <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://xenomai.org/index.=
php/Porting_POSIX_applications_to_Xenomai">http://xenomai.org/index.php/Port=
ing_POSIX_applications_to_Xenomai</a><BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Also, when you turn CONFIG_XEN=
O_OPT_PERVASIVE you get this error:<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; CC kernel/xenomai/nucleus/sync=
h.o<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; kernel/xenomai/nucleus/synch.c=
: In function <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 'xnsynch_release_thread':<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; kernel/xenomai/nucleus/synch.c=
:688:3: error: implicit declaration of<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; function 'xnthread_get_rescnt'=
<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; kernel/xenomai/nucleus/synch.c=
:689:4: error: implicit declaration of<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; function 'xnshadow_send_sig'<B=
R>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I had to go in and make the co=
de for that option befor it always<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; false.<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://git.xenomai.org/?p=
=3Dxenomai-2.6.git;a=3Dcommit;h=3D41b4f9c0f4bdf061">http://git.xenomai.org/?p=3Dxeno=
mai-2.6.git;a=3Dcommit;h=3D41b4f9c0f4bdf061</a><BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 07<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; a7<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 88b<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 76<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2b5cf662b1d4108<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Glen<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Glen Wernersbach<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; President&amp; &nbsp;&nbsp;CTO=
<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Jetsoft Development Co.<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 629 Old St Rt. 74 &#8211; Suit=
e 210<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Cincinnati, Oh 45244<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Custom Programming Web Site: w=
ww.jetsoftdev.com<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Retail Products Web Site: www.=
scanhelp.com<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Phone: 513-528-6660<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Fax: 513-528-3470<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Cell 513-240-9929<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ----<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Partner for Software Technolog=
y<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Jacobs Automation<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2365 Progress Drive<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hebron, KY 41048<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; (513) 297-7550<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ----<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &quot;Support Dyslexia Researc=
h&quot;<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ______________________________=
_________________<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Xenomai-help mailing list<BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"Xenomai-help@domain.hid"=
>Xenomai-help@domain.hid</a><BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://mail.gna.org/=
listinfo/xenomai-help">https://mail.gna.org/listinfo/xenomai-help</a><BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt;&gt; <BR>
&gt;&gt;&gt;&gt; <BR>
</FONT><FONT COLOR=3D"#FF0000">&gt;&gt;&gt; <BR>
</FONT><FONT COLOR=3D"#008000">&gt;&gt; <BR>
</FONT><FONT COLOR=3D"#0000FF">&gt; <BR>
</FONT><BR>
-- <BR>
Glen Wernersbach<BR>
President &amp; CTO<BR>
<IMG src=3D"cid:3415087038_28964442" ><BR>
Jetsoft Development Co.<BR>
629 Old St Rt. 74 &#8211; Suite 210<BR>
Cincinnati, Oh 45244<BR>
Custom Programming Web Site: www.jetsoftdev.com<BR>
Retail Products Web Site: www.scanhelp.com<BR>
Phone: &nbsp;&nbsp;513-528-6660<BR>
Fax: 513-528-3470<BR>
Cell 513-240-9929<BR>
----<BR>
Partner for Software Technology<BR>
Jacobs Automation<BR>
</SPAN></FONT><FONT COLOR=3D"#323232"><FONT SIZE=3D"2"><FONT FACE=3D"Arial"><SPAN=
 STYLE=3D'font-size:10pt'>2365 Progress Drive <BR>
Hebron, KY 41048 <BR>
(513) 297-7550<BR>
----<BR>
</SPAN></FONT></FONT></FONT><FONT FACE=3D"Calibri, Verdana, Helvetica, Arial"=
><SPAN STYLE=3D'font-size:11pt'>&quot;Support Dyslexia Research&quot;<BR>
</SPAN></FONT>
</BODY>
</HTML>


--B_3415087045_28997675--


--B_3415087045_28985757
Content-Type: image/png; name="image.png"
Content-ID: <3415087038_28964442>
Content-Transfer-Encoding: base64

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

--B_3415087045_28985757--




