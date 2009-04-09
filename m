MIME-Version: 1.0
Date: Thu, 9 Apr 2009 10:53:38 +0100
Message-ID: <abaf774b0904090253t229e5fd1w6ed30a1e1199a02f@domain.hid>
From: Steve <sbxenomai@domain.hid>
Content-Type: multipart/alternative; boundary=00504502cf7bf1a50604671c3849
Subject: [Xenomai-help] SIGSEGV Segmentation fault during malloc within
	Xenomai POSIX thread
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

--00504502cf7bf1a50604671c3849
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I am new to Xenomai (and mailling lists), and have been porting a working
c++ RTAI program so that it runs on Xenomai using POSIX threads, sempahores,
etc.  I have succeeded in getting the new version of the application running
and starting to initialise its various components, part of which involves
creating threads through a common function.  However it seg faults part way
through the main thread when instantiating an object with the 'new' keyword,
and the stack trace shows that malloc is the last identifiable call before
the fault:

Call Stack:
0xb7ac6f3c ??() /lib/tls/i686/cmov/libc.so.6
0xb7ac8cad malloc() /lib/tls/i686/cmov/libc.so.6
0xb7da3097 ObjectName::CurrentFunction(this=0x0b70a531c)
/path-to-file/file.cpp
...

I can't post the entire code here, but have not been able to replicate this
with a simpler example.  However, I can reproduce it exactly using malloc in
the lines before the call.  I have put an example that creates threads and
schedules them in a way similar to the full program at the end of this email
for reference.  The actual call that faults is:
Object *Instance = new Object(StringVar.c_str(), Pointer);

The same fault was replicated on the line before by inserting:
char *testWord;
testWord = (char *) malloc(1000 * sizeof(char));

Or by inserting:
char *testWord;
testWord = (char *) malloc(500 * sizeof(char));
testWord = (char *) malloc(500 * sizeof(char));

Or by inserting:
char *testWord;
testWord = (char *) malloc(500 * sizeof(char));
free(testWord);
testWord = (char *) malloc(500 * sizeof(char));

The last of these confuses me the most, because in theory the memory has
been freed and so the second call is no worse off than the first, but it seg
faults.  This is made worse by the fact that I can call malloc and free as
many times as I like (i.e. more than 10) on memory blocks of size
100*(sizeof(char)), and can call malloc on 11 blocks of size
100*(sizeof(char)) without freeing it before the 12th call seg faults.

I am out of ideas - I cannot use Valgrind because Xenomai and Valgrind don't
play well yet - and am positing this issue here because the faulty piece of
code worked fine before the Xenomai port.  My only thought is that it might
be caused by some sort of paging error as a result of using MLockAll(), but
if so I do not know what to do about it.

I am using Xenomai 2.4.6.1 on a vanilla 2.6.24.6 Linux kernel, and am
running Ubuntu 8.04  on 512MB RAM, 2.8 GHz Pentium 4.  I am compiling with
gcc, and debugging with gdb, both through the Code::Blocks IDE.  My glibc
version is 2.7.

Any insight would be very much appreciated, and if you need more information
then let me know.

Steve

******
The example thread creation functions:

void createThread()
{
    pthread_t thread;
    pthread_create(&thread, NULL, function, (void *)"Anonymous Thread");
    pthread_detach(thread);
}

void *function(void *ptr)
{
    pthread_t self;
    sched_param *schedParams = new sched_param;

    self = pthread_self();
    schedParams->sched_priority = 5;

    // Make the thread real time by settings its priority (and any other
scheduling parameters)
    pthread_setschedparam(self, SCHED_FIFO, schedParams);

    while(1) // Loops forever, but only if there is a requested period
    {
        perform((char *)ptr);
        delay(300000000L);
    }

}

--00504502cf7bf1a50604671c3849
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am new to Xenomai (and mailling lists), and have been porting =
a working c++ RTAI program so that it runs on Xenomai using POSIX threads, =
sempahores, etc.=A0 I have succeeded in getting the new version of the appl=
ication running and starting to initialise its various components, part of =
which involves creating threads through a common function.=A0 However it se=
g faults part way through the main thread when instantiating an object with=
 the &#39;new&#39; keyword, and the stack trace shows that malloc is the la=
st identifiable call before the fault:<br>
<br>Call Stack:<br>0xb7ac6f3c ??() /lib/tls/i686/cmov/libc.so.6<br>0xb7ac8c=
ad malloc() /lib/tls/i686/cmov/libc.so.6<br>0xb7da3097 ObjectName::CurrentF=
unction(this=3D0x0b70a531c) /path-to-file/file.cpp<br>...<br><br>I can&#39;=
t post the entire code here, but have not been able to replicate this with =
a simpler example.=A0 However, I can reproduce it exactly using malloc in t=
he lines before the call.=A0 I have put an example that creates threads and=
 schedules them in a way similar to the full program at the end of this ema=
il for reference.=A0 The actual call that faults is:<br>
Object *Instance =3D new Object(StringVar.c_str(), Pointer);<br><br>The sam=
e fault was replicated on the line before by inserting:<br>char *testWord;<=
br>testWord =3D (char *) malloc(1000 * sizeof(char));<br><br>Or by insertin=
g:<br>
char *testWord;<br>testWord =3D (char *) malloc(500 * sizeof(char));<br>tes=
tWord =3D (char *) malloc(500 * sizeof(char));<br><br>Or by inserting:<br>c=
har *testWord;<br>testWord =3D (char *) malloc(500 * sizeof(char));<br>free=
(testWord);<br>
testWord =3D (char *) malloc(500 * sizeof(char));<br><br>The last of these =
confuses me the most, because in theory the memory has been freed and so th=
e second call is no worse off than the first, but it seg faults.=A0 This is=
 made worse by the fact that I can call malloc and free as many times as I =
like (i.e. more than 10) on memory blocks of size 100*(sizeof(char)), and c=
an call malloc on 11 blocks of size 100*(sizeof(char)) without freeing it b=
efore the 12th call seg faults.<br>
<br>I am out of ideas - I cannot use Valgrind because Xenomai and Valgrind =
don&#39;t play well yet - and am positing this issue here because the fault=
y piece of code worked fine before the Xenomai port.=A0 My only thought is =
that it might be caused by some sort of paging error as a result of using M=
LockAll(), but if so I do not know what to do about it.<br>
<br>I am using Xenomai 2.4.6.1 on a vanilla 2.6.24.6 Linux kernel, and am r=
unning Ubuntu 8.04=A0 on 512MB RAM, 2.8 GHz Pentium 4.=A0 I am compiling wi=
th gcc, and debugging with gdb, both through the Code::Blocks IDE.=A0 My gl=
ibc version is 2.7.<br>
<br>Any insight would be very much appreciated, and if you need more inform=
ation then let me know.<br><br>Steve<br><br>******<br>The example thread cr=
eation functions:<br><br>void createThread()<br>{<br>=A0=A0=A0 pthread_t th=
read;<br>
=A0 =A0 pthread_create(&amp;thread, NULL, function, (void *)&quot;Anonymous=
 Thread&quot;);<br>=A0 =A0 pthread_detach(thread);<br>}<br><br>void *functi=
on(void *ptr)<br>{<br>=A0=A0=A0 pthread_t self;<br>=A0=A0=A0 sched_param *s=
chedParams =3D new sched_param;<br>
<br>=A0=A0=A0 self =3D pthread_self();<br>=A0=A0=A0 schedParams-&gt;sched_p=
riority =3D 5;<br><br>=A0=A0=A0 // Make the thread real time by settings it=
s priority (and any other scheduling parameters)<br>=A0=A0=A0 pthread_setsc=
hedparam(self, SCHED_FIFO, schedParams);<br>
<br>=A0=A0=A0 while(1) // Loops forever, but only if there is a requested p=
eriod<br>=A0=A0=A0 {<br>=A0=A0=A0 =A0 =A0 perform((char *)ptr);<br>=A0=A0=
=A0=A0 =A0=A0 delay(300000000L);<br>=A0=A0=A0 }<br><br>}<br>

--00504502cf7bf1a50604671c3849--

