Message-ID: <602976.88951.qm@domain.hid>
Date: Mon, 21 Feb 2011 15:52:09 +0800 (SGT)
From: Ramon Rusli <mon_nie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1631266042-1298274729=:88951"
Subject: [Xenomai-help] [ask] how to send and receive packet in real time
	network with xenomai n rtnet
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org
Cc: Ramon Rusli <mon_nie@domain.hid>

--0-1631266042-1298274729=:88951
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Dear,

How can I use rtnet to =0Asend or receive packet in c? i am a bit confused =
because no examples or =0Atutorial to build the program using rtnet while I=
 search it in internet.=0A i want to make a real time packet sending progra=
m and a real time =0Apacket receiver program using rtnet 0.9.12 and xenomai=
 2.5.4. the =0Aoperating system that I use is linux fedora 13 kernel 2.6.32=
.11.=20

Is=0A it just add some include and some lines from standard udp packet serv=
er=0A and client program?=20

thanks a lot
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
//the=0A standard udp packet server that I build (server.c)
#include =0A<stdio.h>
#include <stdlib.h>
#include =0A<unistd.h>
#include <string.h>
#include =0A<netinet/in.h>
#include <arpa/inet.h>
#include =0A<sys/types.h>
#include <sys/socket.h>
#include=0A <mqueue.h>
#include <fcntl.h>
#include =0A<sys/stat.h>
#include <pthread.h>
#include =0A<sys/mman.h>
#include <signal.h>
#include =0A<limits.h>
#define PORT 7788
#define BUFLEN 65000
#define=0A NPACK 10000000

void diep (char *s)
{
=A0=A0=A0 perror (s);
=A0=A0=A0=0A exit (1);
}

int main (void)
{
=A0=A0=A0 struct sockaddr_in =0Asi_me, si_other;
=A0=A0=A0 int s, i, slen=3Dsizeof(si_other);
=A0=A0=A0 char =0Abuf[BUFLEN];

=A0=A0=A0 if ((s=3Dsocket(AF_INET, SOCK_DGRAM, =0AIPPROTO_UDP))=3D=3D -1)
=A0=A0=A0 {
=A0=A0=A0 =A0=A0=A0 diep("socket");=A0=A0=A0=20
=A0=A0=A0 }

=A0=A0=A0=0A memset ((char *) &si_me, 0, sizeof(si_me));
=A0=A0=A0 si_me.sin_family=0A =3D AF_INET;
=A0=A0=A0 si_me.sin_port =3D htons(PORT);
=A0=A0=A0=0A si_me.sin_addr.s_addr =3D htonl(INADDR_ANY);
=A0=A0=A0 if (bind(s, =0A&si_me, sizeof(si_me)) =3D=3D -1)
=A0=A0=A0 {
=A0=A0=A0 =A0=A0=A0 diep("bind");
=A0=A0=A0=0A }

=A0=A0=A0 for(i =3D 0; i < NPACK; i++)
=A0=A0=A0 {
=A0=A0=A0 =A0=A0=A0 =0Aif(recvfrom(s, buf, BUFLEN, 0, &si_other, &slen) =3D=
=3D -1)
=A0=A0=A0 =0A=A0=A0=A0 {
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 diep("recvfrom()");
=A0=A0=A0 =A0=A0=A0 }
=A0=A0=A0 =A0=A0=A0 =0Aprintf("received packet from %s:%d\n Data: %s\n\n", =
=0Ainet_ntoa(si_other.sin_addr), ntohs(si_other.sin_port), buf);
=A0=A0=A0 }
=A0=A0=A0=0A close(s);
=A0=A0=A0 return 0;
}


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
//the=0A standard udp packet client (client.c)
#include <stdlib.h>
#include=0A=0A <unistd.h>
#include <string.h>
#include =0A<netinet/in.h>
#include <arpa/inet.h>
#include =0A<sys/types.h>
#include <sys/socket.h>
#include =0A<mqueue.h>
#include <fcntl.h>
#include =0A<sys/stat.h>
#include <pthread.h>
#include =0A<sys/mman.h>
#include <signal.h>
#include =0A<limits.h>

#define PORT 7788
#define BUFLEN 65000
#define=0A NPACK 10000000
#define SRV_IP "167.205.34.150"

void diep =0A(char *s)
{
=A0=A0=A0 perror (s);
=A0=A0=A0 exit (1);
}

int main =0A()
{
=A0=A0=A0 struct sockaddr_in si_other;
=A0=A0=A0 int s, i, =0Aslen=3Dsizeof(si_other);
=A0=A0=A0 char buf[BUFLEN];

=A0=A0=A0 =0Aif((s=3Dsocket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)) =3D=3D -1)
=A0=A0=A0 {
=A0=A0=A0 =0A=A0=A0=A0 diep("socket");
=A0=A0=A0=0A }

=A0=A0=A0 memset((char *) &si_other, 0, sizeof(si_other));
=A0=A0=A0=0A si_other.sin_family=3DAF_INET;
=A0=A0=A0 si_other.sin_port =3D htons(PORT);
=A0=A0=A0=0A if(inet_aton(SRV_IP, &si_other.sin_addr)=3D=3D0)
=A0=A0=A0 {
=A0=A0=A0 =A0=A0=A0 =0Afprintf(stderr, "inet_aton () failed\n");
=A0=A0=A0 =A0=A0=A0 exit (1);
=A0=A0=A0 =0A}=A0=A0=A0=20

=A0=A0=A0 for(i=3D0; i< NPACK; i++)
=A0=A0=A0 {
=A0=A0=A0 =A0=A0=A0 =0Aprintf("sending packet %d\n", i);
=A0=A0=A0 =A0=A0=A0 sprintf(buf, "This is =0Apacket %d\n",i);
=A0=A0=A0 =A0=A0=A0 if (sendto(s, buf, BUFLEN, 0, &si_other,=0A slen) =3D=
=3D -1)
=A0=A0=A0 =A0=A0=A0 {
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 diep("sendto()");
=A0=A0=A0 =A0=A0=A0=0A }
=A0=A0=A0 }
=A0=A0=A0 close(s);
return 0;
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
=0A=0A=0A      
--0-1631266042-1298274729=:88951
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Dear,<br><br>How can I use rtnet to =0Asend o=
r receive packet in c? i am a bit confused because no examples or =0Atutori=
al to build the program using rtnet while I search it in internet.=0A i wan=
t to make a real time packet sending program and a real time =0Apacket rece=
iver program using rtnet 0.9.12 and xenomai 2.5.4. the =0Aoperating system =
that I use is linux fedora 13 kernel 2.6.32.11. <br><br>Is=0A it just add s=
ome include and some lines from standard udp packet server=0A and client pr=
ogram? <br><br>thanks a lot<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>//the=0A standard udp packet server=
 that I build (server.c)<br>#include =0A&lt;stdio.h&gt;<br>#include &lt;std=
lib.h&gt;<br>#include =0A&lt;unistd.h&gt;<br>#include &lt;string.h&gt;<br>#=
include =0A&lt;netinet/in.h&gt;<br>#include &lt;arpa/inet.h&gt;<br>#include=
 =0A&lt;sys/types.h&gt;<br>#include &lt;sys/socket.h&gt;<br>#include=0A &lt=
;mqueue.h&gt;<br>#include &lt;fcntl.h&gt;<br>#include =0A&lt;sys/stat.h&gt;=
<br>#include &lt;pthread.h&gt;<br>#include =0A&lt;sys/mman.h&gt;<br>#includ=
e &lt;signal.h&gt;<br>#include =0A&lt;limits.h&gt;<br>#define PORT 7788<br>=
#define BUFLEN 65000<br>#define=0A NPACK 10000000<br><br>void diep (char *s=
)<br>{<br>&nbsp;&nbsp;&nbsp; perror (s);<br>&nbsp;&nbsp;&nbsp;=0A exit (1);=
<br>}<br><br>int main (void)<br>{<br>&nbsp;&nbsp;&nbsp; struct sockaddr_in =
=0Asi_me, si_other;<br>&nbsp;&nbsp;&nbsp; int s, i, slen=3Dsizeof(si_other)=
;<br>&nbsp;&nbsp;&nbsp; char =0Abuf[BUFLEN];<br><br>&nbsp;&nbsp;&nbsp; if (=
(s=3Dsocket(AF_INET, SOCK_DGRAM, =0AIPPROTO_UDP))=3D=3D -1)<br>&nbsp;&nbsp;=
&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; diep("socket");&nbsp;&nbs=
p;&nbsp; <br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp;=0A memset ((cha=
r *) &amp;si_me, 0, sizeof(si_me));<br>&nbsp;&nbsp;&nbsp; si_me.sin_family=
=0A =3D AF_INET;<br>&nbsp;&nbsp;&nbsp; si_me.sin_port =3D htons(PORT);<br>&=
nbsp;&nbsp;&nbsp;=0A si_me.sin_addr.s_addr =3D htonl(INADDR_ANY);<br>&nbsp;=
&nbsp;&nbsp; if (bind(s, =0A&amp;si_me, sizeof(si_me)) =3D=3D -1)<br>&nbsp;=
&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; diep("bind");<br>&n=
bsp;&nbsp;&nbsp;=0A }<br><br>&nbsp;&nbsp;&nbsp; for(i =3D 0; i &lt; NPACK; =
i++)<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =0Aif=
(recvfrom(s, buf, BUFLEN, 0, &amp;si_other, &amp;slen) =3D=3D -1)<br>&nbsp;=
&nbsp;&nbsp; =0A&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; diep("recvfrom()");<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; }<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =0Aprintf("received pack=
et from %s:%d\n Data: %s\n\n", =0Ainet_ntoa(si_other.sin_addr), ntohs(si_ot=
her.sin_port), buf);<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;=0A close=
(s);<br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br><br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>//the=
=0A standard udp packet client (client.c)<br>#include &lt;stdlib.h&gt;<br>#=
include=0A=0A &lt;unistd.h&gt;<br>#include &lt;string.h&gt;<br>#include =0A=
&lt;netinet/in.h&gt;<br>#include &lt;arpa/inet.h&gt;<br>#include =0A&lt;sys=
/types.h&gt;<br>#include &lt;sys/socket.h&gt;<br>#include =0A&lt;mqueue.h&g=
t;<br>#include &lt;fcntl.h&gt;<br>#include =0A&lt;sys/stat.h&gt;<br>#includ=
e &lt;pthread.h&gt;<br>#include =0A&lt;sys/mman.h&gt;<br>#include &lt;signa=
l.h&gt;<br>#include =0A&lt;limits.h&gt;<br><br>#define PORT 7788<br>#define=
 BUFLEN 65000<br>#define=0A NPACK 10000000<br>#define SRV_IP "167.205.34.15=
0"<br><br>void diep =0A(char *s)<br>{<br>&nbsp;&nbsp;&nbsp; perror (s);<br>=
&nbsp;&nbsp;&nbsp; exit (1);<br>}<br><br>int main =0A()<br>{<br>&nbsp;&nbsp=
;&nbsp; struct sockaddr_in si_other;<br>&nbsp;&nbsp;&nbsp; int s, i, =0Asle=
n=3Dsizeof(si_other);<br>&nbsp;&nbsp;&nbsp; char buf[BUFLEN];<br><br>&nbsp;=
&nbsp;&nbsp; =0Aif((s=3Dsocket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)) =3D=3D -1=
)<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; =0A&nbsp;&nbsp;&nbsp; diep(=
"socket");<br>&nbsp;&nbsp;&nbsp;=0A }<br><br>&nbsp;&nbsp;&nbsp; memset((cha=
r *) &amp;si_other, 0, sizeof(si_other));<br>&nbsp;&nbsp;&nbsp;=0A si_other=
.sin_family=3DAF_INET;<br>&nbsp;&nbsp;&nbsp; si_other.sin_port =3D htons(PO=
RT);<br>&nbsp;&nbsp;&nbsp;=0A if(inet_aton(SRV_IP, &amp;si_other.sin_addr)=
=3D=3D0)<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
=0Afprintf(stderr, "inet_aton () failed\n");<br>&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; exit (1);<br>&nbsp;&nbsp;&nbsp; =0A}&nbsp;&nbsp;&nbsp; <br><br>&=
nbsp;&nbsp;&nbsp; for(i=3D0; i&lt; NPACK; i++)<br>&nbsp;&nbsp;&nbsp; {<br>&=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =0Aprintf("sending packet %d\n", i);<b=
r>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; sprintf(buf, "This is =0Apacket %d\=
n",i);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (sendto(s, buf, BUFLEN, =
0, &amp;si_other,=0A slen) =3D=3D -1)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; diep("sen=
dto()");<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=0A }<br>&nbsp;&nbsp;&nbsp=
; }<br>&nbsp;&nbsp;&nbsp; close(s);<br>return 0;<br>}<br>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br></td>=
</tr></table><br>=0A=0A=0A=0A=0A=0A=0A=0A      
--0-1631266042-1298274729=:88951--

