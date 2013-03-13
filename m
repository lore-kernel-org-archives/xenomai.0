Message-ID: <51407147.1010305@siemens.com>
Date: Wed, 13 Mar 2013 13:29:59 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <1362541011.90317.YahooMailNeo@web161401.mail.bf1.yahoo.com>
	<5136F3A6.8090400@antcom.de> <513F96BA.4030309@xenomai.org>
	<513F9DF2.2030803@antcom.de> <51404997.7000900@hilscher.com>
In-Reply-To: <51404997.7000900@hilscher.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] about Xenomai in Debian and Ubuntu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?ISO-8859-1?Q?St=E9phane_LOS?= <slos@hilscher.com>
Cc: xenomai@xenomai.org

Hi St=E9phane, (hope that is better ;) )

On 2013-03-13 10:40, St=E9phane LOS wrote:
> Hi,
>=20
> I just want to say that I agree with Roland about the tone.
>=20
> My colleague J=E9r=F4me and I ARE NOT kernel developers for sure.
>=20
> Hilscher is proposing a Linux driver for the cifX boards. Not for free,
> I can't do anything about that fact.
> Then our customer gets the source code. The documentation is available
> on our web site.
>=20
> As I like FLOSS and have years of fiddling here and there, I have
> noticed Xenomai existence and usage in projects such as Orocos and Linu=
x
> CNC.
> And I have noticed also the usage of CIF boards in those projects.
>=20
> So I have proposed to my manager and J=E9r=F4me to work on a Xenomai dr=
iver
> for cifX boards and it was accepted.
>=20
> Again, we are not kernel developers and our background is different.
>=20
> Of course we could sell some boards but it is nothing compared to the
> time and energy we have already spent in this project.

You should not underestimate the value of code review here. Gilles and I
both pointed out flaws in your code that existed not just due to the
"unusual" target environment. I hope there were some patterns to pick up
for other projects as well.

And don't take it personally, it's human to err. I've seen a lot of code
written by a single person or a certain group that is very "focused",
not taking care of corner cases. And you'll find bugs in my code as well
before - and sometimes unfortunately also after - it went through
thorough review.

>=20
> Our customers are traditionally using RTX or VxWorks with our boards. I
> wanted to promote the use of Linux / Xenomai for some kind of applicati=
ons.

Which is likely a good idea when thinking long-term.

>=20
> We have received some support from Gilles and Jan and I thank them very
> much but the tone was never very friendly.
>=20
> I understand that FLOSS projects need to sell training and development
> but the cost would have cancelled the project since we don't think we
> could generate the cash to cover the expenses. So the driver is done on
> our free time.

We appreciate your effort, and I'm sorry to hear that you have no
backing to finish this officially - specifically as the result should
provide a better customer experience of your products. I know what you
are talking about, sometimes I'm still involved in similar fights.

>=20
> I am just wondering why in this list nobody cares of saying Hi or Hello
> before anything.
> May be you are just too busy reading / writing kernel code lines.
>=20
> I am a little bit disappointed. Sorry for bothering you.

The tone may appear rough, sorry, and it is sometimes related to the
number of mails and, thus, contexts we work in every day (various OSS
projects, customer projects, internal stuff...). So some statements
become briefer. Sometimes they also become a bit rougher when requests
to change certain issues are simply ignored without commenting on the why.

Jan

--=20
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

