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
Message-ID: <1393871535.96739.YahooMailNeo@web140604.mail.bf1.yahoo.com>
Date: Mon, 3 Mar 2014 10:32:15 -0800 (PST)
From: Bruno Tunes de Mello <bruno_v05_2005@yahoo.com.br>
In-Reply-To: <530C9D87.60805@xenomai.org>
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

Hi Gilles,=0A=0AI did the tests you said to verify the system's behavior wi=
th load .=0A=0AI executed some tests using commands 'stress', cpuburn for C=
ortex A8 and dohell with LTP, for more than 20 minutes each one.=0AI printe=
d 3 results using some of these tools together: http://pastebin.com/VFavnax=
W=0AIn each test it's indicated the commands used to generate load.=0A=0AIt=
's just to confirm if it's all right.=0A=0AThanks,=0ABruno=0A=0A=0A=0A=0A=
=0AEm Ter=E7a-feira, 25 de Fevereiro de 2014 10:41, Gilles Chanteperdrix <g=
illes.chanteperdrix@xenomai.org> escreveu:=0A =0AOn 02/25/2014 02:35 PM, Br=
uno Tunes de Mello wrote:=0A> Hi Gilles,=0A>=0A> I applied this new patch a=
nd I got the results below.=0A>=0A> This is the complete boot log: http://p=
astebin.com/YY5pFyaN=0A=0AOk, bit 23 seems enabled in the L2 cache auxiliar=
y register, which is =0Awhat I wanted to see.=0A=0A>=0A> I executed latency=
 and xeno-test some times and the results:=0A=0AThis looks much better, you=
 should let the test run longer, and if =0Apossible using dohell with LTP t=
o generate load during that time.=0A=0A=0A-- =0A=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 Gilles.
