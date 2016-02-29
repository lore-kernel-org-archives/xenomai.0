Date: Mon, 29 Feb 2016 21:58:25 +0100
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <56d4b0f131fc36.79352149@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Xenomai] RTnet -- receive broadcast frame at the local machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Dnia Poniedzia=B3ek, 29 Lutego 2016 21:29 Gilles Chanteperdrix <gilles.chan=
teperdrix@xenomai.org> napisa=B3(a)=20
> On Mon, Feb 29, 2016 at 09:24:11PM +0100, Mariusz Janiak wrote:
> > Dear Xenomai users,
> >=20
> > Since RTnet has been integrated with Xenomai I address this question to=
 you. The question is, how to receive a broadcast frame at the local machin=
e without using the localhost? The issue is following, we have two process =
with separate rtsockets at the single machine (of course we have different =
machines in the network but this is not a case). One process send a broadca=
st UDP frame to the specified UDP port -- we have one rteth device on the m=
achine. The second process listen on that port=20
> > (receivefrom) and does not receive the broadcast frame sent by first pr=
ocess. I have found the following thread on the RTnet mailing list=20
> >=20
> > https://sourceforge.net/p/rtnet/mailman/message/6787561/
> >=20
> > Could you please point me the place which should be hacked to duplicate=
 outgoing packets if there are multiple
> > matching routes?
>=20
> I ma not sure I understand what you are looking for, but to receive
> on a host the frames sent by that host, you need to enable and load
> the loopback module. When you do that, no hack should be needed.
>=20
> --=20
> 					    Gilles.
> https://click-hack.org

Hi Gilles,

I am pretty sure that loopback module has been loaded, this is standard RTn=
et configuration that has not been changed by me. Beside that, there is rtl=
o (127.0.0.1) device which is created when RT_LOOPBACK=3D"yes" in rtnet.con=
f.=20

Below you will find simple testcase. Compile this using Xenomai posix skin.=
=20

1) receiver.c
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <rtnet.h>
#define DEF_REC_PORT 1883

int sock;
struct sockaddr_in rec_addr;

int main()
{
  int enable =3D 1;
  int buffer[100];
  socklen_t len =3D sizeof(rec_addr);

  mlockall(MCL_CURRENT|MCL_FUTURE);

  sock =3D socket(AF_INET, SOCK_DGRAM, 0);
  setsockopt(sock, SOL_SOCKET, SO_BROADCAST, &enable, sizeof(enable));

  memset(&rec_addr, 0, sizeof(struct sockaddr_in));
  rec_addr.sin_family      =3D AF_INET;
  rec_addr.sin_port        =3D htons(DEF_REC_PORT);
  rec_addr.sin_addr.s_addr =3D INADDR_ANY;
  bind(sock, (struct sockaddr *) &rec_addr, sizeof(struct sockaddr_in));

  while (1) {
    memset(buffer, 0, 100);
    recvfrom(sock, buffer, 100, 0, &rec_addr, &len);
    printf("%s\n", buffer);
  }
  close(sock);
  return 0;
}


2. sender.c
#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <rtnet.h>
#include <rtnet_config.h>
#define DEF_SND_PORT 1883
#define DEF_SND_IP   "10.0.0.255"

int sock;
struct sockaddr_in snd_addr;
int ret, size;

int main()
{
  int enable =3D 1;
  struct in_addr  snd_ip;
  char buffer[] =3D "Hello";
  socklen_t len =3D sizeof(snd_addr);

  mlockall(MCL_CURRENT|MCL_FUTURE);

  inet_aton(DEF_SND_IP, &snd_ip);
  sock =3D socket(AF_INET, SOCK_DGRAM, 0);
  setsockopt(sock, SOL_SOCKET, SO_BROADCAST, &enable, sizeof(enable));

  memset(&snd_addr, 0, sizeof(struct sockaddr_in));
  snd_addr.sin_family =3D AF_INET;
  snd_addr.sin_port =3D htons(DEF_SND_PORT);
  snd_addr.sin_addr =3D snd_ip;

  while (1) {
    ret =3D sendto(sock, buffer, 6, 0 , &snd_addr, len);
    sleep(1);
  }
  return 0;
}

Best,
Mariusz



