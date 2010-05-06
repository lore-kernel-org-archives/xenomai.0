MIME-Version: 1.0
Date: Thu, 6 May 2010 09:52:20 +0200
Message-ID: <o2hcfed72901005060052o40bcc542gf42d45e3488c43f1@domain.hid>
From: Divi Oillo <divi.oillo@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d7e84ceff4fe0485e83899
Subject: [Xenomai-help] Problem getting the time with a kernel patched with
	xenomai
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

--0016e6d7e84ceff4fe0485e83899
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, I post this message because I need a little help.

I've recently patched with success my 2.6.32.12 kernel with xenomai
adeos-ipipe-2.6.32.7-x86-2.6-01.patch and I've installed xenomai-2.5.2.
When I run this code on my linux-2.6.32.12 patched with xenomai, I'm gettin=
g
some trouble. The following code give the current time each second using
nanosleep and gettimeofday. The program wait 1 second and print the time in
the terminal.

************************************************************
#include <iostream>
#include <string>
#include <time.h>
#include <sys/time.h>
#include <unistd.h>

using namespace std;

int main (void)
{
        timeval timestamp;
        timeval timestamp_sav;
        struct timespec req;
        req.tv_sec=3D1; //1 second
        req.tv_nsec=3D0;
        double diff;

        while(1)
        {
                gettimeofday(&timestamp_sav,NULL);
                nanosleep(&req,&req);
                gettimeofday(&timestamp,NULL);

                diff =3D timestamp.tv_usec - timestamp_sav.tv_usec;
                cout << "timestamp_sav=3D" << timestamp_sav.tv_sec << "
timestamp=3D" << timestamp.tv_sec <<  "   Diff : " << diff << endl;
        }

        return 0;
}
************************************************************

uname -r
2.6.32-12-xenomai
../bin/timer
timestamp_sav=3D1273069305 timestamp=3D1273069306   Diff : 10010
timestamp_sav=3D1273069306 timestamp=3D1273069307   Diff : 10011
timestamp_sav=3D1273069307 timestamp=3D1273069308   Diff : 10011
timestamp_sav=3D1273069308 timestamp=3D1273069309   Diff : 10011
timestamp_sav=3D1273069309 timestamp=3D1273069310   Diff : 10011
timestamp_sav=3D1273069310 timestamp=3D1273069311   Diff : 10011
timestamp_sav=3D1273069311 timestamp=3D1273069312   Diff : 10010
timestamp_sav=3D1273069312 timestamp=3D1273069313   Diff : 10011
timestamp_sav=3D1273069313 timestamp=3D1273069314   Diff : 10011
timestamp_sav=3D1273069314 timestamp=3D1273069315   Diff : 10011

uname -r
2.6.32-12
../bin/timer
timestamp_sav=3D1273069885 timestamp=3D1273069886   Diff : 305
timestamp_sav=3D1273069886 timestamp=3D1273069887   Diff : 306
timestamp_sav=3D1273069887 timestamp=3D1273069888   Diff : 379
timestamp_sav=3D1273069888 timestamp=3D1273069889   Diff : 311
timestamp_sav=3D1273069889 timestamp=3D1273069890   Diff : 302
timestamp_sav=3D1273069890 timestamp=3D1273069891   Diff : 292
timestamp_sav=3D1273069891 timestamp=3D1273069892   Diff : 309
timestamp_sav=3D1273069892 timestamp=3D1273069893   Diff : 313
timestamp_sav=3D1273069893 timestamp=3D1273069894   Diff : 309
timestamp_sav=3D1273069894 timestamp=3D1273069895   Diff : 311


Why do I have +10010 =B5s or +10011 =B5s between each dating with my xenoma=
i
kernel and approximately +300 =B5s with my non-patched kernel?
Thanks.

--0016e6d7e84ceff4fe0485e83899
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, I post this message because I need a little help.<br>
<br>
I&#39;ve recently patched with success my 2.6.32.12 kernel with xenomai=20
adeos-ipipe-2.6.32.7-x86-2.6-01.patch and I&#39;ve installed xenomai-2.5.2.=
<br>
When I run this code on my linux-2.6.32.12 patched with xenomai, I&#39;m=20
getting some trouble. The following code give the current time each=20
second using nanosleep and gettimeofday. The program wait 1 second and=20
print the time in the terminal.<br>
<br>
************************************************************<br>
#include &lt;iostream&gt;<br>
#include &lt;string&gt;<br>
#include &lt;time.h&gt;<br>
#include &lt;sys/time.h&gt;<br>
#include &lt;unistd.h&gt;<br>
<br>
using namespace std;<br>
<br>
int main (void)<br>
{<br>
=A0 =A0 =A0 =A0 timeval timestamp;<br>
=A0 =A0 =A0 =A0 timeval timestamp_sav;<br>
=A0 =A0 =A0 =A0 struct timespec req;<br>
=A0 =A0 =A0 =A0 req.tv_sec=3D1; //1 second<br>
=A0 =A0 =A0 =A0 req.tv_nsec=3D0;<br>
=A0 =A0 =A0 =A0 double diff;<br>
<br>
=A0 =A0 =A0 =A0 while(1)<br>
=A0 =A0 =A0 =A0 {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gettimeofday(&amp;timestamp_sav,NULL);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nanosleep(&amp;req,&amp;req);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gettimeofday(&amp;timestamp,NULL);<br>
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 diff =3D timestamp.tv_usec - timestamp_sav.=
tv_usec;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cout &lt;&lt; &quot;timestamp_sav=3D&quot; =
&lt;&lt;=20
timestamp_sav.tv_sec &lt;&lt; &quot; timestamp=3D&quot; &lt;&lt; timestamp.=
tv_sec=20
&lt;&lt;=A0 &quot;=A0 =A0Diff : &quot; &lt;&lt; diff &lt;&lt; endl;<br>
=A0 =A0 =A0 =A0 }<br>
<br>
=A0 =A0 =A0 =A0 return 0;<br>
}<br>
************************************************************<br>
<br>
uname -r<br>
2.6.32-12-xenomai<br>
../bin/timer<br>
timestamp_sav=3D1273069305 timestamp=3D1273069306=A0 =A0Diff : 10010<br>
timestamp_sav=3D1273069306 timestamp=3D1273069307=A0 =A0Diff : 10011<br>
timestamp_sav=3D1273069307 timestamp=3D1273069308=A0 =A0Diff : 10011<br>
timestamp_sav=3D1273069308 timestamp=3D1273069309=A0 =A0Diff : 10011<br>
timestamp_sav=3D1273069309 timestamp=3D1273069310=A0 =A0Diff : 10011<br>
timestamp_sav=3D1273069310 timestamp=3D1273069311=A0 =A0Diff : 10011<br>
timestamp_sav=3D1273069311 timestamp=3D1273069312=A0 =A0Diff : 10010<br>
timestamp_sav=3D1273069312 timestamp=3D1273069313=A0 =A0Diff : 10011<br>
timestamp_sav=3D1273069313 timestamp=3D1273069314=A0 =A0Diff : 10011<br>
timestamp_sav=3D1273069314 timestamp=3D1273069315=A0 =A0Diff : 10011<br>
<br>
uname -r<br>
2.6.32-12<br>
../bin/timer<br>
timestamp_sav=3D1273069885 timestamp=3D1273069886=A0 =A0Diff : 305<br>
timestamp_sav=3D1273069886 timestamp=3D1273069887=A0 =A0Diff : 306<br>
timestamp_sav=3D1273069887 timestamp=3D1273069888=A0 =A0Diff : 379<br>
timestamp_sav=3D1273069888 timestamp=3D1273069889=A0 =A0Diff : 311<br>
timestamp_sav=3D1273069889 timestamp=3D1273069890=A0 =A0Diff : 302<br>
timestamp_sav=3D1273069890 timestamp=3D1273069891=A0 =A0Diff : 292<br>
timestamp_sav=3D1273069891 timestamp=3D1273069892=A0 =A0Diff : 309<br>
timestamp_sav=3D1273069892 timestamp=3D1273069893=A0 =A0Diff : 313<br>
timestamp_sav=3D1273069893 timestamp=3D1273069894=A0 =A0Diff : 309<br>
timestamp_sav=3D1273069894 timestamp=3D1273069895=A0 =A0Diff : 311<br>
<br>
<br>
Why do I have +10010 =B5s or +10011 =B5s between each dating with my xenoma=
i
 kernel and approximately +300 =B5s with my non-patched kernel?<br>
Thanks.

--0016e6d7e84ceff4fe0485e83899--

