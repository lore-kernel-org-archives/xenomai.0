Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8A558.B671B2D3"
Date: Wed, 23 Apr 2008 11:43:01 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>
	<18446.32522.986935.299094@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F15@domain.hid>
	<2ff1a98a0804230658w57d54addu438948a91faed1d6@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F17@domain.hid>
	<2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: Re: [Xenomai-help] Xenomai serial port c++ code and / or
	xeno--(xenomm-0.0.1) install problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8A558.B671B2D3
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Gilles,

I've attached my old serial port code that uses the /dev/ttyS0 port.  =
What I have here is a "read byte on demand" function that uses the =
select statement to block until data is ready.  My initial goal was to =
replicate this functionality using the Xenomai Serial Driver.  It seems, =
however, that the following is not possible under Xenomai.  What I'm =
starting to conclude is that I can only receive data from a serial port =
within the context of a task, and that printing error codes from strerr =
produce "Operation not permitted" If I directly call read in a manner =
similar to the linux serial port code (posted below) by requesting a =
read from my sensor packet processing thread without using an RT_TASK.  =
Here is what my sensor thread used to do to get data from /dev/ttyS0


in the Pthread sensor processing thread...

void sensorthreadmainloop()
{
    while(1)
    {

	if(serialport->readbyte())
			{
				SENSORID=3Dsensorpacket->processChar(ser->getreadbyte());
			}
			else
			{
				printf("One Second timeout detected on serial port, sensor data not =
received\n");
			}
		=09
                        // measure timestamp, process byte, checksum, =
etc, if timestamp is too
                        //great an error has occurred, etc.  If valid =
packet is received, send a
                        //condition variable signal to the main loop =
that data is available
                        //break out of loop if the application requests =
thread termination
                        .
                        .
                        .
                        //
    }
}

It appears that I have to do something else with Xenomai-- set up a real =
time task which reads bytes from the rtser0 device.=20
When data is received, trigger a semaphore/condition variable to the =
above thread that one byte is ready for processing.

What this basically means is that I would have an rt task like the =
following in the serial port reader code where the task has been =
pre-initialized and started.=20
=20
void read_task_proc(void *arg)
{
	while (1)
        {
		int read =3D rt_dev_read(read_fd, inbyte, 2250);
		if (read <0) {
			printf("error on rt_dev_read, code %s\n",
			       strerror(-err));
			break;
		}
                else
                {
                          //data received, trigger  condition variable
			  pthread_mutex_lock(&run_mutex);
		          pthread_cond_signal(&run_cv);
			  pthread_mutex_unlock(&run_mutex);

		}

	}


}

In my sensor  thread I would have the following:

void sensorthreadmainloop()
{
    while(1)
    {

=09
		pthread_mutex_lock(&run_mutex);
		pthread_cond_wait(&run_cv, &run_mutex);
		pthread_mutex_unlock(&run_mutex);
                //if data received
		SENSORID=3Dsensorpacket->processChar(ser->getreadbyte());
		//and figure out a way to signal other important information such as =
timeouts=09
                        // measure timestamp, process byte, checksum, =
etc, if timestamp is too
                        //great an error has occurred, etc.  If valid =
packet is received, send a
                        //condition variable signal to the main loop =
that a completed sensor packet is available
                        //break out of loop if the application requests =
thread termination
                        .
                        .
                        .
                        //
    }
}
If I use a condition variable from a continuously running RT_TASK that =
reads from the serial port to trigger processing, is that the right way =
to make this work?=20
Can I mix pthreads, mutexes, and tasks together, or should every thread =
my program has (and it reads 3 sensors using the above methods) all use =
RT_TASKS and specially set up Mutexes/Condition variables.


Here is my old serial port code which I hoped I could replicate with the =
Xenomai driver--


Thank you,

Joshua Karch


#include "serial.h"  //class definitions

serialport::serialport()
{

}

serialport::~serialport()
{

}


int serialport::startup(char * dev, speed_t baudrate)
{
	outptr=3D0;
	inptr=3D0;
	fd =3D open (dev, O_RDWR | O_NOCTTY);
	if (fd =3D=3D -1)
	{
		printf ("invalid device or error\n");
		return(-1);
	}
	// set low latency mode, so we don't get 10msec scheduling granularity
	// this is the same as 'setserial /dev/ttyS0 low_latency',
	// but it won't complete if we aren't root
	if ( ioctl( fd, TIOCGSERIAL, &serinfo ) < 0 ) {
		printf( "Cannot get serial info.  It is probably a usb-serial =
converter\n " );
	}
	serinfo.flags |=3D ASYNC_LOW_LATENCY;
	if ( ioctl( fd, TIOCSSERIAL, &serinfo ) < 0 ) {
		printf( "Cannot get serial info.  It is probably a usb-serial =
converter Flags\n " );
	}

	tcgetattr (fd, &oldtio); ///< save current serial port settingsBRKINT | =
ICRNL | INPCK | ISTRIP | IXON | IXOFF);
	tcgetattr (fd, &newtio); ///< save current serial port settings to new =
struct
	cfsetispeed(&newtio, baudrate);//input speed
	cfsetospeed(&newtio, baudrate);//output speed
	newtio.c_cflag &=3D ~(CSIZE | PARENB |CRTSCTS | CSTOPB);
	newtio.c_cflag |=3D (CS8 | CLOCAL | CREAD);
	newtio.c_lflag &=3D ~(ECHO | ICANON | IEXTEN | ISIG | ECHOE);//  choose =
raw input
    newtio.c_iflag &=3D ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON | =
IXOFF);
    newtio.c_oflag &=3D ~OPOST;
	newtio.c_cc[VMIN]=3D1;
	newtio.c_cc[VTIME]=3D0;
	newtio.c_cc[NCCS]=3D0;
	newtio.c_ispeed=3Dbaudrate;
	newtio.c_ospeed=3Dbaudrate;
	newtio.c_cc[VMIN]=3D1;
	newtio.c_cc[VTIME]=3D0;
	tcflush(fd, TCIFLUSH);
	tcsetattr(fd, TCSANOW, &newtio);
	timeout.tv_sec=3D1;
	timeout.tv_usec=3D0;
	devicename=3Ddev;
	return(0);
}


void serialport::shutdown()
{
	tcflush(fd, TCIFLUSH);
	tcsetattr(fd, TCSANOW, &oldtio);
}

///send data over serialport. Lock mutexes when sending data
void serialport::SendSerial(char *val, int length)
{
    /// Send a serial byte down the line
    write(fd, val, length);
}

///wait for one character
int serialport::readbyte()
{
	FD_ZERO (&rfds);
	FD_SET (fd, &rfds);
	int retval =3D select (fd + 1, &rfds, NULL, NULL, &timeout);
	timeout.tv_sec=3D1;
	timeout.tv_usec=3D0;
	if (retval)
	{
		return 1;
	}
	else
	{
		printf("Timeout of 1 seconds waiting for serial input on %s with =
retval of %d\n",devicename,retval);
		return 0;
	}
}

///get the read byte from the serial port
char serialport::getreadbyte()
{
	read(fd,&line[0],1);
	return line[0];
}


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Wed 4/23/2008 10:30 AM
To: Karch, Joshua
Cc: xenomai-help
Subject: Re: [Xenomai-help] Xenomai serial port c++ code and / or =
xeno--(xenomm-0.0.1) install problem
=20
On Wed, Apr 23, 2008 at 4:25 PM, Karch, Joshua <jkarch@domain.hid> =
wrote:
>
>
>
>
> Hi Gilles,
>
>  From what you're saying it appears a task is necessary to read a byte =
in a
> loop.  That method works.  The issue is, I want to be able to issue a =
read
> command to get a byte on demand from the calling thread.
>
>  With the /dev/ttyS0 driver, I used to be able to read a byte after =
using
> select statement without polling: My old code did the following:

Using read (or rt_dev_read) does not do any more polling than using
select, it just suspends the calling thread until some bytes are ready
to be processed.

>
>  realserial *serial =3D new realserial();
>  serial->startup("serialportdevice",115200);
>
>  then in a pthreaded loop I request a read
>
>  int count=3D serial->readbyte();
>      then I access the buffer if count>0;
>  char inchar=3Dserial->getreadbyte();
>      process inchar
>      loop again.
>
>  I split read byte and get-read byte into two parts in order to check =
for 1
> second time-outs for data.
>
>  Is it possible to do this using the rtser0 driver?  If I have to use =
a
> task,
>  can I make the task run for only one iteration of the loop, then =
suspend it
> to process the byte,
>  and then reactivate it againwhen another byte is needed?

I am sorry but I really do not understand your problem. There is no
real difference between calling read in a pthread and calling
rt_dev_read in a real-time thread. The things that work with
/dev/ttyS0 should work automatically with rtser0.

If that does not work, please post a full example of code.

--=20
 Gilles








------_=_NextPart_001_01C8A558.B671B2D3
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>RE: [Xenomai-help] Xenomai serial port c++ code and / or =
xeno--(xenomm-0.0.1) install problem</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Gilles,<BR>
<BR>
I've attached my old serial port code that uses the /dev/ttyS0 =
port.&nbsp; What I have here is a &quot;read byte on demand&quot; =
function that uses the select statement to block until data is =
ready.&nbsp; My initial goal was to replicate this functionality using =
the Xenomai Serial Driver.&nbsp; It seems, however, that the following =
is not possible under Xenomai.&nbsp; What I'm starting to conclude is =
that I can only receive data from a serial port within the context of a =
task, and that printing error codes from strerr produce &quot;Operation =
not permitted&quot; If I directly call read in a manner similar to the =
linux serial port code (posted below) by requesting a read from my =
sensor packet processing thread without using an RT_TASK.&nbsp; Here is =
what my sensor thread used to do to get data from /dev/ttyS0<BR>
<BR>
<BR>
in the Pthread sensor processing thread...<BR>
<BR>
void sensorthreadmainloop()<BR>
{<BR>
&nbsp;&nbsp;&nbsp; while(1)<BR>
&nbsp;&nbsp;&nbsp; {<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if(serialport-&gt;readbyte())<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SENSORID=3Dsensorpacket-&gt;processChar(ser-&gt;getreadbyte());<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;One Second =
timeout detected on serial port, sensor data not received\n&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // =
measure timestamp, process byte, checksum, etc, if timestamp is too<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
//great an error has occurred, etc.&nbsp; If valid packet is received, =
send a<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
//condition variable signal to the main loop that data is available<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
//break out of loop if the application requests thread termination<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //<BR>
&nbsp;&nbsp;&nbsp; }<BR>
}<BR>
<BR>
It appears that I have to do something else with Xenomai-- set up a real =
time task which reads bytes from the rtser0 device.<BR>
When data is received, trigger a semaphore/condition variable to the =
above thread that one byte is ready for processing.<BR>
<BR>
What this basically means is that I would have an rt task like the =
following in the serial port reader code where the task has been =
pre-initialized and started.<BR>
<BR>
void read_task_proc(void *arg)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (1)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int read =3D =
rt_dev_read(read_fd, inbyte, 2250);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (read &lt;0) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;error on =
rt_dev_read, code %s\n&quot;,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strerror(-err));<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; else<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; //data received, trigger&nbsp; condition variable<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; =
pthread_mutex_lock(&amp;run_mutex);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pthread_cond_signal(&amp;run_cv);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; =
pthread_mutex_unlock(&amp;run_mutex);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
<BR>
}<BR>
<BR>
In my sensor&nbsp; thread I would have the following:<BR>
<BR>
void sensorthreadmainloop()<BR>
{<BR>
&nbsp;&nbsp;&nbsp; while(1)<BR>
&nbsp;&nbsp;&nbsp; {<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pthread_mutex_lock(&amp;run_mutex);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pthread_cond_wait(&amp;run_cv, &amp;run_mutex);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pthread_mutex_unlock(&amp;run_mutex);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; //if data received<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SENSORID=3Dsensorpacket-&gt;processChar(ser-&gt;getreadbyte());<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //and figure out a way to =
signal other important information such as timeouts&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // =
measure timestamp, process byte, checksum, etc, if timestamp is too<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
//great an error has occurred, etc.&nbsp; If valid packet is received, =
send a<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
//condition variable signal to the main loop that a completed sensor =
packet is available<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
//break out of loop if the application requests thread termination<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //<BR>
&nbsp;&nbsp;&nbsp; }<BR>
}<BR>
If I use a condition variable from a continuously running RT_TASK that =
reads from the serial port to trigger processing, is that the right way =
to make this work?<BR>
Can I mix pthreads, mutexes, and tasks together, or should every thread =
my program has (and it reads 3 sensors using the above methods) all use =
RT_TASKS and specially set up Mutexes/Condition variables.<BR>
<BR>
<BR>
Here is my old serial port code which I hoped I could replicate with the =
Xenomai driver--<BR>
<BR>
<BR>
Thank you,<BR>
<BR>
Joshua Karch<BR>
<BR>
<BR>
#include &quot;serial.h&quot;&nbsp; //class definitions<BR>
<BR>
serialport::serialport()<BR>
{<BR>
<BR>
}<BR>
<BR>
serialport::~serialport()<BR>
{<BR>
<BR>
}<BR>
<BR>
<BR>
int serialport::startup(char * dev, speed_t baudrate)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; outptr=3D0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inptr=3D0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fd =3D open (dev, O_RDWR | =
O_NOCTTY);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fd =3D=3D -1)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf (&quot;invalid device =
or error\n&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return(-1);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // set low latency mode, so =
we don't get 10msec scheduling granularity<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // this is the same as =
'setserial /dev/ttyS0 low_latency',<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // but it won't complete if =
we aren't root<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ( ioctl( fd, TIOCGSERIAL, =
&amp;serinfo ) &lt; 0 ) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf( &quot;Cannot get =
serial info.&nbsp; It is probably a usb-serial converter\n &quot; );<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; serinfo.flags |=3D =
ASYNC_LOW_LATENCY;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ( ioctl( fd, TIOCSSERIAL, =
&amp;serinfo ) &lt; 0 ) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf( &quot;Cannot get =
serial info.&nbsp; It is probably a usb-serial converter Flags\n &quot; =
);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tcgetattr (fd, &amp;oldtio); =
///&lt; save current serial port settingsBRKINT | ICRNL | INPCK | ISTRIP =
| IXON | IXOFF);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tcgetattr (fd, &amp;newtio); =
///&lt; save current serial port settings to new struct<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cfsetispeed(&amp;newtio, =
baudrate);//input speed<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cfsetospeed(&amp;newtio, =
baudrate);//output speed<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; newtio.c_cflag &amp;=3D =
~(CSIZE | PARENB |CRTSCTS | CSTOPB);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; newtio.c_cflag |=3D (CS8 | =
CLOCAL | CREAD);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; newtio.c_lflag &amp;=3D =
~(ECHO | ICANON | IEXTEN | ISIG | ECHOE);//&nbsp; choose raw input<BR>
&nbsp;&nbsp;&nbsp; newtio.c_iflag &amp;=3D ~(BRKINT | ICRNL | INPCK | =
ISTRIP | IXON | IXOFF);<BR>
&nbsp;&nbsp;&nbsp; newtio.c_oflag &amp;=3D ~OPOST;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; newtio.c_cc[VMIN]=3D1;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; newtio.c_cc[VTIME]=3D0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; newtio.c_cc[NCCS]=3D0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
newtio.c_ispeed=3Dbaudrate;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
newtio.c_ospeed=3Dbaudrate;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; newtio.c_cc[VMIN]=3D1;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; newtio.c_cc[VTIME]=3D0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tcflush(fd, TCIFLUSH);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tcsetattr(fd, TCSANOW, =
&amp;newtio);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout.tv_sec=3D1;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout.tv_usec=3D0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; devicename=3Ddev;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return(0);<BR>
}<BR>
<BR>
<BR>
void serialport::shutdown()<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tcflush(fd, TCIFLUSH);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tcsetattr(fd, TCSANOW, =
&amp;oldtio);<BR>
}<BR>
<BR>
///send data over serialport. Lock mutexes when sending data<BR>
void serialport::SendSerial(char *val, int length)<BR>
{<BR>
&nbsp;&nbsp;&nbsp; /// Send a serial byte down the line<BR>
&nbsp;&nbsp;&nbsp; write(fd, val, length);<BR>
}<BR>
<BR>
///wait for one character<BR>
int serialport::readbyte()<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FD_ZERO (&amp;rfds);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FD_SET (fd, &amp;rfds);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval =3D select (fd + =
1, &amp;rfds, NULL, NULL, &amp;timeout);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout.tv_sec=3D1;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout.tv_usec=3D0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Timeout of 1 =
seconds waiting for serial input on %s with retval of =
%d\n&quot;,devicename,retval);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
}<BR>
<BR>
///get the read byte from the serial port<BR>
char serialport::getreadbyte()<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read(fd,&amp;line[0],1);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return line[0];<BR>
}<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Gilles Chanteperdrix [<A =
HREF=3D"mailto:gilles.chanteperdrix@xenomai.org">mailto:gilles.chanteperdri=
x@domain.hid</A>]<BR>
Sent: Wed 4/23/2008 10:30 AM<BR>
To: Karch, Joshua<BR>
Cc: xenomai-help<BR>
Subject: Re: [Xenomai-help] Xenomai serial port c++ code and / or =
xeno--(xenomm-0.0.1) install problem<BR>
<BR>
On Wed, Apr 23, 2008 at 4:25 PM, Karch, Joshua =
&lt;jkarch@domain.hid&gt; wrote:<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; Hi Gilles,<BR>
&gt;<BR>
&gt;&nbsp; From what you're saying it appears a task is necessary to =
read a byte in a<BR>
&gt; loop.&nbsp; That method works.&nbsp; The issue is, I want to be =
able to issue a read<BR>
&gt; command to get a byte on demand from the calling thread.<BR>
&gt;<BR>
&gt;&nbsp; With the /dev/ttyS0 driver, I used to be able to read a byte =
after using<BR>
&gt; select statement without polling: My old code did the =
following:<BR>
<BR>
Using read (or rt_dev_read) does not do any more polling than using<BR>
select, it just suspends the calling thread until some bytes are =
ready<BR>
to be processed.<BR>
<BR>
&gt;<BR>
&gt;&nbsp; realserial *serial =3D new realserial();<BR>
&gt;&nbsp; serial-&gt;startup(&quot;serialportdevice&quot;,115200);<BR>
&gt;<BR>
&gt;&nbsp; then in a pthreaded loop I request a read<BR>
&gt;<BR>
&gt;&nbsp; int count=3D serial-&gt;readbyte();<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; then I access the buffer if =
count&gt;0;<BR>
&gt;&nbsp; char inchar=3Dserial-&gt;getreadbyte();<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process inchar<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loop again.<BR>
&gt;<BR>
&gt;&nbsp; I split read byte and get-read byte into two parts in order =
to check for 1<BR>
&gt; second time-outs for data.<BR>
&gt;<BR>
&gt;&nbsp; Is it possible to do this using the rtser0 driver?&nbsp; If I =
have to use a<BR>
&gt; task,<BR>
&gt;&nbsp; can I make the task run for only one iteration of the loop, =
then suspend it<BR>
&gt; to process the byte,<BR>
&gt;&nbsp; and then reactivate it againwhen another byte is needed?<BR>
<BR>
I am sorry but I really do not understand your problem. There is no<BR>
real difference between calling read in a pthread and calling<BR>
rt_dev_read in a real-time thread. The things that work with<BR>
/dev/ttyS0 should work automatically with rtser0.<BR>
<BR>
If that does not work, please post a full example of code.<BR>
<BR>
--<BR>
&nbsp;Gilles<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8A558.B671B2D3--

