Date: Tue, 1 Mar 2016 23:05:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160301220552.GF26312@hermes.click-hack.org>
References: <56d610a7afa878.50630396@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <56d610a7afa878.50630396@wp.pl>
Subject: Re: [Xenomai] Odp: Re: RTnet -- receive broadcast frame at the
 local machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mariusz Janiak <mariuszjaniak@wp.pl>
Cc: Xenomai <xenomai@xenomai.org>

On Tue, Mar 01, 2016 at 10:59:03PM +0100, Mariusz Janiak wrote:
> Dnia Wtorek, 1 Marca 2016 07:57 Gilles Chanteperdrix <gilles.chanteperdri=
x@xenomai.org> napisa=B3(a)=20
> > On Mon, Feb 29, 2016 at 10:57:53PM +0100, Mariusz Janiak wrote:
> > > Dnia Poniedzia=B3ek, 29 Lutego 2016 22:08 Gilles Chanteperdrix <gille=
s.chanteperdrix@xenomai.org> napisa=B3(a)=20
> > > > On Mon, Feb 29, 2016 at 09:58:25PM +0100, Mariusz Janiak wrote:
> > > > > Dnia Poniedzia=B3ek, 29 Lutego 2016 21:29 Gilles Chanteperdrix <g=
illes.chanteperdrix@xenomai.org> napisa=B3(a)=20
> > > > > > On Mon, Feb 29, 2016 at 09:24:11PM +0100, Mariusz Janiak wrote:
> > > > > > > Dear Xenomai users,
> > > > > > >=20
> > > > > > > Since RTnet has been integrated with Xenomai I address this q=
uestion to you. The question is, how to receive a broadcast frame at the lo=
cal machine without using the localhost? The issue is following, we have tw=
o process with separate rtsockets at the single machine (of course we have =
different machines in the network but this is not a case). One process send=
 a broadcast UDP frame to the specified UDP port -- we have one rteth devic=
e on the machine. The second process listen on=20
> that=20
> > > port=20
> > > > > > > (receivefrom) and does not receive the broadcast frame sent b=
y first process. I have found the following thread on the RTnet mailing lis=
t=20
> > > > > > >=20
> > > > > > > https://sourceforge.net/p/rtnet/mailman/message/6787561/
> > > > > > >=20
> > > > > > > Could you please point me the place which should be hacked to=
 duplicate outgoing packets if there are multiple
> > > > > > > matching routes?
> > > > > >=20
> > > > > > I ma not sure I understand what you are looking for, but to rec=
eive
> > > > > > on a host the frames sent by that host, you need to enable and =
load
> > > > > > the loopback module. When you do that, no hack should be needed.
> > > > > >=20
> > > > > > --=20
> > > > > > 					    Gilles.
> > > > > > https://click-hack.org
> > > > >=20
> > > > > Hi Gilles,
> > > > >=20
> > > > > I am pretty sure that loopback module has been loaded, this is st=
andard RTnet configuration that has not been changed by me. Beside that, th=
ere is rtlo (127.0.0.1) device which is created when RT_LOOPBACK=3D"yes" in=
 rtnet.conf.=20
> > > > >=20
> > > > > Below you will find simple testcase. Compile this using Xenomai p=
osix skin.=20
> > > > >=20
> > > > > 1) receiver.c
> > > > > #include <stdio.h>
> > > > > #include <unistd.h>
> > > > > #include <stdlib.h>
> > > > > #include <sys/mman.h>
> > > > > #include <sys/socket.h>
> > > > > #include <netinet/in.h>
> > > > > #include <arpa/inet.h>
> > > > > #include <rtnet.h>
> > > > > #define DEF_REC_PORT 1883
> > > > >=20
> > > > > int sock;
> > > > > struct sockaddr_in rec_addr;
> > > > >=20
> > > > > int main()
> > > > > {
> > > > >   int enable =3D 1;
> > > > >   int buffer[100];
> > > > >   socklen_t len =3D sizeof(rec_addr);
> > > > >=20
> > > > >   mlockall(MCL_CURRENT|MCL_FUTURE);
> > > >=20
> > > > 1->
> > > >=20
> > > > >=20
> > > > >   sock =3D socket(AF_INET, SOCK_DGRAM, 0);
> > > >=20
> > > > 2->
> > > >=20
> > > > >   setsockopt(sock, SOL_SOCKET, SO_BROADCAST, &enable, sizeof(enab=
le));
> > > >=20
> > > > 3->
> > > >=20
> > > > >=20
> > > > >   memset(&rec_addr, 0, sizeof(struct sockaddr_in));
> > > > >   rec_addr.sin_family      =3D AF_INET;
> > > > >   rec_addr.sin_port        =3D htons(DEF_REC_PORT);
> > > > >   rec_addr.sin_addr.s_addr =3D INADDR_ANY;
> > > > >   bind(sock, (struct sockaddr *) &rec_addr, sizeof(struct
> > > > >   sockaddr_in));
> > > >=20
> > > > 4->
> > > >=20
> > > > >=20
> > > > >   while (1) {
> > > > >     memset(buffer, 0, 100);
> > > > >     recvfrom(sock, buffer, 100, 0, &rec_addr, &len);
> > > >=20
> > > > 5->
> > > >=20
> > > > >     printf("%s\n", buffer);
> > > > >   }
> > > > >   close(sock);
> > > > >   return 0;
> > > > > }
> > > > >=20
> > > > >=20
> > > > > 2. sender.c
> > > > > #include <unistd.h>
> > > > > #include <stdlib.h>
> > > > > #include <sys/mman.h>
> > > > > #include <sys/socket.h>
> > > > > #include <netinet/in.h>
> > > > > #include <arpa/inet.h>
> > > > > #include <rtnet.h>
> > > > > #include <rtnet_config.h>
> > > > > #define DEF_SND_PORT 1883
> > > > > #define DEF_SND_IP   "10.0.0.255"
> > > > >=20
> > > > > int sock;
> > > > > struct sockaddr_in snd_addr;
> > > > > int ret, size;
> > > > >=20
> > > > > int main()
> > > > > {
> > > > >   int enable =3D 1;
> > > > >   struct in_addr  snd_ip;
> > > > >   char buffer[] =3D "Hello";
> > > > >   socklen_t len =3D sizeof(snd_addr);
> > > > >=20
> > > > >   mlockall(MCL_CURRENT|MCL_FUTURE);
> > > >=20
> > > > 6->
> > > >=20
> > > > >=20
> > > > >   inet_aton(DEF_SND_IP, &snd_ip);
> > > >=20
> > > > 7->
> > > >=20
> > > > >   sock =3D socket(AF_INET, SOCK_DGRAM, 0);
> > > >=20
> > > > 8->
> > > >=20
> > > > >   setsockopt(sock, SOL_SOCKET, SO_BROADCAST, &enable,
> > > > >   sizeof(enable));
> > > >=20
> > > > 9->
> > > >=20
> > > > >=20
> > > > >   memset(&snd_addr, 0, sizeof(struct sockaddr_in));
> > > > >   snd_addr.sin_family =3D AF_INET;
> > > > >   snd_addr.sin_port =3D htons(DEF_SND_PORT);
> > > > >   snd_addr.sin_addr =3D snd_ip;
> > > > >=20
> > > > >   while (1) {
> > > > >     ret =3D sendto(sock, buffer, 6, 0 , &snd_addr, len);
> > > >=20
> > > > 10->
> > > >=20
> > > > So, that is 10 function calls without checking the return value.
> > > > Please check the function return values.
> > > >=20
> > > > --=20
> > > > 					    Gilles.
> > > > https://click-hack.org
> > >=20
> > > You are right the test case has not been perfect. The answer to the f=
irst question, sending to unicast cause that receiver get frames. Regarding=
 the return values of the syscalls when broadcast
> > >=20
> > > 1 -> 0
> > > 2 -> 896
> > > 3 -> -1
> > > 4 -> 0
> > >=20
> > > Five is not printed because of waiting on recvfrom
> > >=20
> > > 6 -> 0
> > > 7 -> 1
> > > 8 -> 897
> > > 9 -> -1
> > > 10 -> -1
> > > 10 -> -1
> > > 10 -> -1
> > > 10 -> -1
> > > 10 -> -1
> >=20
> > So, finally, the problem is that SO_BROADCAST is not implemented for
> > RTnet sockets, and that RTnet sendto does not work for a broadcast
> > address?
> >=20
> > --=20
> > 					    Gilles.
> > https://click-hack.org
>=20
> It does work, but when you receive on remote host, and it doesn't when re=
ceive on the same host. According to this post on the RTnet forum=20
>=20
> https://sourceforge.net/p/rtnet/mailman/message/26686897/
>=20
> the RT-UDP sockets have SO_BROADCAST automatically enabled.

>From what I understand from this post, it is not easy to fix, as it
requires duplicating packets. So, patch welcome.

The thing that I do not understand though, is that according to what
you said, "sendto" fails, what is the value of errno when it fails.
Maybe you do not know it, because you do not seem to be used to
checking for errors, but when a unix call fails, it returns -1 and
sets errno, the interesting information is errno.

--=20
					    Gilles.
https://click-hack.org

