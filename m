References: <1392993075.52404.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530766CD.3060707@xenomai.org>
 <1393198348.29895.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530A862C.1060805@xenomai.org>
 <1393204287.98060.YahooMailNeo@web140606.mail.bf1.yahoo.com>
 <530B374B.1080507@xenomai.org>
 <1393298793.43978.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530C6AC6.6030200@xenomai.org>
 <1393335358.33826.YahooMailNeo@web140603.mail.bf1.yahoo.com>
 <530C9D87.60805@xenomai.org>
 <1393871535.96739.YahooMailNeo@web140604.mail.bf1.yahoo.com>
 <5314CDDA.4030308@xenomai.org>
 <1393904852.42577.YahooMailNeo@web140603.mail.bf1.yahoo.com>
 <5315ED1F.60602@xenomai.org>
Message-ID: <1394499114.45142.YahooMailNeo@web140602.mail.bf1.yahoo.com>
Date: Mon, 10 Mar 2014 17:51:54 -0700 (PDT)
From: Bruno Tunes de Mello <bruno_v05_2005@yahoo.com.br>
In-Reply-To: <5315ED1F.60602@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] User Space Problems
Reply-To: Bruno Tunes de Mello <bruno_v05_2005@yahoo.com.br>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Gilles,=0A=0AI understand. I have a beaglebone too and as soon as possib=
le I will make some test on it.=0A=0AThank you for all help and attention,=
=0ABruno=0A=0A=0A=0A=0A=0AEm Ter=E7a-feira, 4 de Mar=E7o de 2014 12:13, Gil=
les Chanteperdrix <gilles.chanteperdrix@xenomai.org> escreveu:=0A =0AOn 03/=
04/2014 04:47 AM, Bruno Tunes de Mello wrote:=0A> Hi Gilles,=0A> =0A> You a=
re right, in the first test, I executed both latency and xeno-test commands=
. Sorry.=0A> The others test I executed only latency command.=0A> =0A> I tr=
ied to enable the discard service on /etc/inetd.conf, I don't know if I did=
 it right, but in /etc/services file I found 'discard 9/tcp sink null' and =
'discard 9/udp sink null'.=0A> Then I used the command you said:=0A> xeno-t=
est -l "dohell -s 192.168.0.5 -m /media/linaro/PENDRIVE -l /opt/ltp" -c 0 -=
p 100 -g histo=0A> =0A> I tested a few times and the better result is: http=
://pt-br.tinypic.com/r/206mmvn/8=0A> This result is not so good like that y=
ou showed.=0A> =0A> My doubt is if this result is satisfactory (the platfor=
m is ready for develop applications) or do you think that I need to do some=
 correction?=0A=0A70us is a bit high, but on the other hand:=0A- the mx6q i=
s a quad-core, whereas the omap4 is a dual core, the latency=0Aincreases wi=
th the number of cores;=0A- the tests I make on omap4 do not use much of th=
e processor=0Aperipherals, such as the graphic co-processor, so, if you use=
 the=0Agraphic co-processor, you may observe an increase in latencies as we=
ll.=0A=0AFinally, whether this is satisfactory depends on your application.=
=0A=0AThe only way to improve latency is to enable the I-pipe tracer, and t=
ry=0Aand understand where the maximum latency come from, but this is time=
=0Aconsuming.=0A=0AAlso, some settings are known to result in an improvemen=
t in latencies:=0A- turn off CONFIG_PREEMPT (i.e. enable CONFIG_PREEMPT_NON=
E), this looks=0Acontradictory, as the menu entry says "low latency", but i=
t is talking=0Aabout Linux latencies, not Xenomai's=0A- build kernel and us=
er-space in thumb2=0A- disable Xenomai unlocked context switch=0A=0ABut do =
not expect these settings to reduce the latency by more than say 5us.=0A=0A=
=0A=0A-- =0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.
