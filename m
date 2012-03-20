Date: Tue, 20 Mar 2012 12:09:15 -0400
From: Glen Wernersbach <glen@domain.hid>
Message-ID: <CB8E23EB.1EE42%glen@domain.hid>
In-Reply-To: <4F68A1C8.20009@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="ISO-8859-1"
Content-transfer-encoding: quoted-printable
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

Not much to that as well.

CC =3D arm-linux-gnueabi-gcc
#CC =3D gcc

all:    serial
serial:     serial.c
    $(CC) -o serial.o serial.c
    arm-linux-gnueabi-strip serial.o

clean:
    rm -f serial.o



On 3/20/12 11:27 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:

> On 03/20/2012 04:17 PM, Glen Wernersbach wrote:
>> Don't have a full dev enviroment on my embedded arm. Here is the
>> program. Very very basic:
>=20
> Ok, actually I was after the link flags used for building this app.
>=20
>> -------
>> #include <stdio.h>
>> #include <termios.h>
>> #include <errno.h>
>> #include <fcntl.h>
>>=20
>>=20
>> /*Artila*/
>> #define MATRIX500_GET_UART_TYPE 0xe001
>> #define MATRIX500_SET_UART_TYPE 0xe002
>> #define MATRIX500_GET_UART_MODE9 0xe003
>> #define MATRIX500_SET_UART_MODE9 0xe004
>> #define MATRIX500_UART_SET_BAUD 0xe006
>>=20
>> #define MATRIX500_UART_TYPE_232 232
>> #define MATRIX500_UART_TYPE_422 422
>> #define MATRIX500_UART_TYPE_485 485
>> int
>> main(argc, argv)
>> int argc;
>> char *argv[];
>> {
>>=20
>> int fd, ret;
>> struct termios term;
>> char buf[]=3D"XBCDEFHIJKM\0";
>> char buf2[1024] ;
>>=20
>> struct termios T_new;
>>=20
>> /*open tty port*/
>> fd =3D open("/dev/ttyS4", O_RDWR | O_NOCTTY | O_NDELAY);
>> if (fd =3D=3D -1) {
>> printf("open /dev/ttyS0 Failed, errno: %d\r\n", errno);
>> return 0;
>> }
>>=20
>> unsigned long interface2=3D0;
>> ioctl(fd, MATRIX500_GET_UART_TYPE, &interface2) ;
>> printf("set UART type: %d...Failed, errno: %d\r\n", interface2, errno);
>>=20
>> /*set serial interface: RS-422*/
>> interface2 =3D MATRIX500_UART_TYPE_422;
>> if(ioctl(fd, MATRIX500_SET_UART_TYPE, &interface2) !=3D 0) {
>> printf("set UART type: %d...Failed, errno: %d\r\n", interface2, errno);
>> close(fd);
>> return 0;
>> }
>>=20
>> unsigned long mode9 =3D 0;
>> ioctl(fd, MATRIX500_GET_UART_MODE9, &mode9);
>> printf("mode: %d...Failed, errno: %d\r\n", mode9, errno);
>>=20
>> mode9=3D0;
>>=20
>> if (ioctl(fd, MATRIX500_SET_UART_MODE9, &mode9)!=3D 0) {
>> printf("mode: %d...Failed, errno: %d\r\n", mode9, errno);
>> close(fd);
>> return 0;
>> }
>> //it appears this is not getting set but no error.
>>=20
>> if(tcgetattr(fd,&term) !=3D 0) {
>> printf("tcgetattr failed\n");
>>=20
>> }
>> term.c_cflag =3D (B921600 | CS8 | CREAD | CLOCAL | HUPCL);
>> term.c_oflag =3D 0;
>> term.c_iflag =3D 0;
>> term.c_lflag =3D 0;
>> if(tcsetattr(fd,TCSANOW,&term) !=3D 0) {
>> printf("tcsetattr failed\n");
>>=20
>> }
>> //set baud rate at 4 times 921.6m
>>=20
>> unsigned long baud =3D 921600UL*4;
>> if (ioctl(fd , MATRIX500_UART_SET_BAUD , &baud ) !=3D 0) {
>> printf("set baud: %d...Failed, errno: %d\r\n", baud, errno);
>> close(fd);
>> return 0;
>> }
>>=20
>>=20
>> close(fd);
>>=20
>>=20
>>=20
>>=20
>>=20
>>=20
>> fd =3D open("/dev/ttyS4", O_RDWR | O_NOCTTY | O_NDELAY);
>> if (fd =3D=3D -1) {
>> printf("open /dev/ttyS0 Failed, errno: %d\r\n", errno);
>> return 0;
>> }
>>=20
>>=20
>> //write the data to my device which echos them back
>> write(fd, buf, sizeof(buf)-1);
>>=20
>> //will wait forever here.
>> while(1) {
>> //wait for all 12 characters to received in fifo and then print them to
>> the console
>>=20
>>=20
>> ret =3D read(fd, buf2, sizeof(buf)-1);
>> if (ret =3D=3Dsizeof(buf)-1) {
>> buf2[ret] =3D'\0' ;
>> printf("got data %s\n", buf2) ;
>> break;
>>=20
>> }
>>=20
>>=20
>> }
>>=20
>>=20
>> close(fd) ;
>> return 0;
>> }
>>=20
>> ------
>>=20
>>=20
>>=20
>> On 3/20/12 11:06 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:
>>=20
>>>  On 03/20/2012 03:53 PM, Glen Wernersbach wrote:
>>>> Ipipe version:
>>>> 1.13-05
>>>>=20
>>>>=20
>>>> Yes, I do have the co kernel and interrupt pipeline enabled
>>>=20
>>>  ldd <your-serial-app> ?
>>>=20
>>>>=20
>>>>=20
>>>> On 3/20/12 10:47 AM, "Philippe Gerum"<rpm@xenomai.org> wrote:
>>>>=20
>>>>> On 03/20/2012 03:34 PM, Glen Wernersbach wrote:
>>>>>> Working on the Strace.
>>>>>>=20
>>>>>> I don't have the /proc/xenomai/hal file??
>>>>>=20
>>>>> /proc/ipipe/version then.
>>>>>=20
>>>>>>=20
>>>>>> Again. Nothing I am running is xeno. Its just a xeno patched kernel.
>>>>>>=20
>>>>>=20
>>>>> Ok, but you do have the Xenomai co-kernel enabled in your kernel buil=
d,
>>>>> and the interrupt pipeline is enabled as well, right?
>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>> On 3/20/12 10:31 AM, "Philippe Gerum"<rpm@xenomai.org> wrote:
>>>>>>=20
>>>>>>> On 03/20/2012 03:17 PM, Philippe Gerum wrote:
>>>>>>>> On 03/20/2012 03:07 PM, Glen Wernersbach wrote:
>>>>>>>>> I went through and disabled everything in xeno except
>>>>>>>>> CONFIG_XENO_OPT_PERVASIVE, did not work. Take that option out and=
 it
>>>>>>>>> works.
>>>>>>>>>=20
>>>>>>>>> Take that option out at anytime it works.
>>>>>>>>>=20
>>>>>>>>> My program basic writes a few characters a serial port and then
>> reads
>>>>>>>>> them
>>>>>>>>> back in from the same port. I have a loop back cable connected
>> to the
>>>>>>>>> port.
>>>>>>>>>=20
>>>>>>>>> It writes the data but waits forever to read them back in
>>>>>>>>>=20
>>>>>>>>>> From my tests, it appears that the termois tcsetaddr settings
>> is not
>>>>>>>>>> getting
>>>>>>>>> set when I call it when this option is on.
>>>>>>>>=20
>>>>>>>> Can you strace your app when it runs, please?
>>>>>>>=20
>>>>>>> The interrupt pipeline release number would help as well
>>>>>>> (/proc/xenomai/hal).
>>>>>>>=20
>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> On 3/20/12 9:57 AM, "Philippe Gerum"<rpm@xenomai.org> wrote:
>>>>>>>>>=20
>>>>>>>>>> On 03/20/2012 02:48 PM, Glen Wernersbach wrote:
>>>>>>>>>>> I don't think this is it directly.
>>>>>>>>>>>=20
>>>>>>>>>>> This program was made on the same kernel prior to patching it w=
ith
>>>>>>>>>>> Xeno.
>>>>>>>>>>>=20
>>>>>>>>>>> It should still run like any other linux program.
>>>>>>>>>>=20
>>>>>>>>>> - what does "program not working" mean in your case? Any errno
>> return
>>>>>>>>>> we
>>>>>>>>>> could interpret? Any strace output?
>>>>>>>>>>=20
>>>>>>>>>> - what if you disable CONFIG_XENO_OPT_SKIN_RTDM, leaving
>> PERVASIVE on?
>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> On 3/20/12 9:44 AM, "Philippe Gerum"<rpm@xenomai.org> wrote:
>>>>>>>>>>>=20
>>>>>>>>>>>> On 03/20/2012 02:28 PM, Glen Wernersbach wrote:
>>>>>>>>>>>> Hi All,
>>>>>>>>>>>>=20
>>>>>>>>>>>> I install Xenomai 2.6.0 on AT91SAM9G20 system and have found
>> that
>>>>>>>>>>>> when
>>>>>>>>>>>> CONFIG_XENO_OPT_PERVASIVE is enabled my standard non real
>> time linux
>>>>>>>>>>>> serial write then read serial program does not work.
>>>>>>>>>>>>=20
>>>>>>>>>>>> If I turn off CONFIG_XENO_OPT_PERVASIVE, my serial program doe=
s
>>>>>>>>>>>> work.
>>>>>>>>>>>>=20
>>>>>>>>>>>> Any ideas why?????
>>>>>>>>>>>>=20
>>>>>>>>>>>>=20
>>>>>>>>>>>> A possible explanation would be that your application links
>> with the
>>>>>>>>>>>> Xenomai POSIX lib (libpthread_rt), albeit it should not.
>>>>>>>>>>>>=20
>>>>>>>>>>>> With pervasive support disabled, any routing from the overload=
ed
>>>>>>>>>>>> POSIX
>>>>>>>>>>>> I/O calls to the Xenomai kernel would then fail.
>>>>>>>>>>>>=20
>>>>>>>>>>>> If so, you should not link against the Xenomai libs if you
>> need no
>>>>>>>>>>>> -rt
>>>>>>>>>>>> service, or prevent symbol wrapping only for the POSIX I/O
>> calls by
>>>>>>>>>>>> prefixing them by __real_* if you want Xenomai-enabled POSIX
>> services
>>>>>>>>>>>> except the I/O support.
>>>>>>>>>>>>=20
>>>>>>>>>>>> See
>>>>>>>>>>>>=20
>> http://xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai
>>>>>>>>>>>>=20
>>>>>>>>>>>>=20
>>>>>>>>>>>> Also, when you turn CONFIG_XENO_OPT_PERVASIVE you get this
>> error:
>>>>>>>>>>>> CC kernel/xenomai/nucleus/synch.o
>>>>>>>>>>>> kernel/xenomai/nucleus/synch.c: In function
>>>>>>>>>>>> 'xnsynch_release_thread':
>>>>>>>>>>>> kernel/xenomai/nucleus/synch.c:688:3: error: implicit
>> declaration of
>>>>>>>>>>>> function 'xnthread_get_rescnt'
>>>>>>>>>>>> kernel/xenomai/nucleus/synch.c:689:4: error: implicit
>> declaration of
>>>>>>>>>>>> function 'xnshadow_send_sig'
>>>>>>>>>>>>=20
>>>>>>>>>>>> I had to go in and make the code for that option befor it alwa=
ys
>>>>>>>>>>>> false.
>>>>>>>>>>>>=20
>>>>>>>>>>>>=20
>>>>>>>>>>>>=20
>> http://git.xenomai.org/?p=3Dxenomai-2.6.git;a=3Dcommit;h=3D41b4f9c0f4bdf061
>>>>>>>>>>>> 07
>>>>>>>>>>>> a7
>>>>>>>>>>>> 88b
>>>>>>>>>>>>=20
>>>>>>>>>>>> 76
>>>>>>>>>>>> 2b5cf662b1d4108
>>>>>>>>>>>>=20
>>>>>>>>>>>>=20
>>>>>>>>>>>> Glen
>>>>>>>>>>>> --
>>>>>>>>>>>> Glen Wernersbach
>>>>>>>>>>>> President& CTO
>>>>>>>>>>>>=20
>>>>>>>>>>>> Jetsoft Development Co.
>>>>>>>>>>>> 629 Old St Rt. 74 =AD Suite 210
>>>>>>>>>>>> Cincinnati, Oh 45244
>>>>>>>>>>>> Custom Programming Web Site: www.jetsoftdev.com
>>>>>>>>>>>> Retail Products Web Site: www.scanhelp.com
>>>>>>>>>>>> Phone: 513-528-6660
>>>>>>>>>>>> Fax: 513-528-3470
>>>>>>>>>>>> Cell 513-240-9929
>>>>>>>>>>>> ----
>>>>>>>>>>>> Partner for Software Technology
>>>>>>>>>>>> Jacobs Automation
>>>>>>>>>>>> 2365 Progress Drive
>>>>>>>>>>>> Hebron, KY 41048
>>>>>>>>>>>> (513) 297-7550
>>>>>>>>>>>> ----
>>>>>>>>>>>> "Support Dyslexia Research"
>>>>>>>>>>>>=20
>>>>>>>>>>>>=20
>>>>>>>>>>>> _______________________________________________
>>>>>>>>>>>> Xenomai-help mailing list
>>>>>>>>>>>> Xenomai-help@domain.hid
>>>>>>>>>>>> https://mail.gna.org/listinfo/xenomai-help
>>>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>=20
>>>>>>=20
>>>>>=20
>>>>=20
>>>=20
>>=20
>> --
>> Glen Wernersbach
>> President & CTO
>>=20
>> Jetsoft Development Co.
>> 629 Old St Rt. 74 =AD Suite 210
>> Cincinnati, Oh 45244
>> Custom Programming Web Site: www.jetsoftdev.com
>> Retail Products Web Site: www.scanhelp.com
>> Phone: 513-528-6660
>> Fax: 513-528-3470
>> Cell 513-240-9929
>> ----
>> Partner for Software Technology
>> Jacobs Automation
>> 2365 Progress Drive
>> Hebron, KY 41048
>> (513) 297-7550
>> ----
>> "Support Dyslexia Research"
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




