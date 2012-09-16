Message-ID: <5055E244.4040101@web.de>
Date: Sun, 16 Sep 2012 16:29:24 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <1347634862.78737.YahooMailNeo@web29605.mail.ird.yahoo.com>
In-Reply-To: <1347634862.78737.YahooMailNeo@web29605.mail.ird.yahoo.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Context Switch with rtnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Franz Engel <franz_lambert_engel@yahoo.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2012-09-14 17:01, Franz Engel wrote:
> Hi,
> =

> I've a little problem. I'm using the rtnet.h-header and the following fun=
ction:
> ret =3D recvfrom ( ethernetConnection.sock, &recBuffer, sizeof ( recBuffe=
r ),0, ( struct sockaddr * ) &ethernetConnection.dest_addr,&destlen );
> =

> =

> I compiled the program with the xenomai compiling flags and library.
> =

> When I look to the xenomai state I get something like this:
> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>  22  0      0          834840     0     00000082    0.1  rtnet-stack
>  22  0      0          1          0     00000082    0.0  rtnet-rtpc
>   0  6262   2          2          0     00300380    0.0  qs_robotpositio
>   2  6265   2          6          0     00300380    0.0  qs_robotpositio
>   0  6266   1          1          0     00300380    0.0  robotrsiinterfa
>   1  6268   1147       2365       0     00300182    0.8  robotrsiinterfa
> =

> You can see, I get a lote of context and module switches just as the rtne=
t-stack itself. Is that normal?

Well, I have no clue what you configured, so I can only guess. If your
task 6268 is a pure RT task that is not supposed to interact with Linux
services, you first of all have a bug in your software stack. You should
look for the reason of those mode switches to Linux, e.g. by asking
Xenomai to raise SIGXCPU when this happens.

Regarding the rtnet-stack context switches: basically, every switch is
one packet arriving at your NIC. Either you are receiving a lot of small
but valid packets or you are on an open network, and that is basically
heavy unrelated broadcast traffic of other sources than the RT device(s).

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120916/21fcac6=
4/attachment.pgp>
