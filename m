From: <romain.perier@scle.fr>
Date: Tue, 14 Apr 2015 10:15:56 +0200
Message-ID: <299A38B133279A4EBA47BCB60993FEAF858030C89E@xs203433.MELINDA.LOCAL>
References: <299A38B133279A4EBA47BCB60993FEAF858030C89D@xs203433.MELINDA.LOCAL>
 <20150414073454.GA1589@hermes.click-hack.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] RTNET
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

Le 14/04/2015 09:35, Gilles Chanteperdrix a =E9crit :=0A=
>> I have two questions :=0A=
>>=0A=
>> 1. Have you any ideas about the problem described above ?=0A=
> No, the macb driver has been tested on AT91, and was working. Have=0A=
> you tried loading rtipv4 and passing an IP address to rtifconfig (in=0A=
> that order)?=0A=
=0A=
I have just tried, same behaviour, it freezes.=0A=
$ modprobe rtipv4 (rtnet and macb are already loaded)=0A=
$ /usr/xenomai/sbin/rtifconfig rteth0 up 192.168.0.1=0A=
   # freeze=0A=
=0A=

