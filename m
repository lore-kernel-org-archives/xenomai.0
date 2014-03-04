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
Message-ID: <1393904852.42577.YahooMailNeo@web140603.mail.bf1.yahoo.com>
Date: Mon, 3 Mar 2014 19:47:32 -0800 (PST)
From: Bruno Tunes de Mello <bruno_v05_2005@yahoo.com.br>
In-Reply-To: <5314CDDA.4030308@xenomai.org>
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

Hi Gilles,=0A=0AYou are right, in the first test, I executed both latency a=
nd xeno-test commands. Sorry.=0AThe others test I executed only latency com=
mand.=0A=0AI tried to enable the discard service on /etc/inetd.conf, I don'=
t know if I did it right, but in /etc/services file I found 'discard 9/tcp =
sink null' and 'discard 9/udp sink null'.=0AThen I used the command you sai=
d:=0Axeno-test -l "dohell -s 192.168.0.5 -m /media/linaro/PENDRIVE -l /opt/=
ltp" -c 0 -p 100 -g histo=0A=0AI tested a few times and the better result i=
s: http://pt-br.tinypic.com/r/206mmvn/8=0AThis result is not so good like t=
hat you showed.=0A=0AMy doubt is if this result is satisfactory (the platfo=
rm is ready for develop applications) or do you think that I need to do som=
e correction?=0A=0AThanks, =0ABruno=0A=0A=0A=0A=0A=0AEm Segunda-feira, 3 de=
 Mar=E7o de 2014 15:45, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.=
org> escreveu:=0A =0AOn 03/03/2014 07:32 PM, Bruno Tunes de Mello wrote:=0A=
> Hi Gilles,=0A> =0A> I did the tests you said to verify the system's behav=
ior with load .=0A> =0A> I executed some tests using commands 'stress', cpu=
burn for Cortex A8 and dohell with LTP, for more than 20 minutes each one.=
=0A> I printed 3 results using some of these tools together: http://pastebi=
n.com/VFavnaxW=0A> In each test it's indicated the commands used to generat=
e load.=0A> =0A> It's just to confirm if it's all right.=0A=0A71us may be a=
 bit high, but have you run xeno-test and latency at the =0Asame time? xeno=
-test runs latency, so, if you also run the latency test =0Aseparately, one=
 latency test will perturb the results of the other.=0A=0AAlso, something I=
 noted on omap4, I have no explanation, but it seems =0Alatency is better o=
n cpu 0, also, running dohell with all the options =0Ashould provide a hard=
er load.=0A=0AI use:=0Axeno-test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp"=
 -c 0 -p 100 -g histo=0A=0AWhere 192.168.0.5 has the "discard" service enab=
led in inetd.conf (the =0Adiscard service is not enabled by default).=0A=0A=
And an USB key is mounted on /mnt.=0A=0AThe generated "histo" files can be =
used with scripts/histo.gp to generate=0Ahistograms like:=0Ahttp://sisyphus=
.hd.free.fr/~gilles/core-3.10-latencies/panda.png=0A=0ANote that since the =
feedback from mx6 users about the L2 "write-allocate" =0Abit, the panda boa=
rd latency dropped down to about 25us.=0A=0A=0A-- =0A=A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.
