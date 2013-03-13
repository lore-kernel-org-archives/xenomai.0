Message-ID: <514092E3.50401@hilscher.com>
Date: Wed, 13 Mar 2013 15:53:23 +0100
From: =?ISO-8859-1?Q?St=E9phane_LOS?= <slos@hilscher.com>
MIME-Version: 1.0
References: <1362541011.90317.YahooMailNeo@web161401.mail.bf1.yahoo.com>
	<5136F3A6.8090400@antcom.de> <513F96BA.4030309@xenomai.org>
	<513F9DF2.2030803@antcom.de> <51404997.7000900@hilscher.com>
	<51407147.1010305@siemens.com>
In-Reply-To: <51407147.1010305@siemens.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Le 13/03/2013 13:29, Jan Kiszka a =E9crit :
> Hi St=E9phane, (hope that is better ;) )
Hi Jan, (Yes, I feel better ! :-) )
>
> On 2013-03-13 10:40, St=E9phane LOS wrote:
>> Hi,
>>
>> I just want to say that I agree with Roland about the tone.
>>
>> My colleague J=E9r=F4me and I ARE NOT kernel developers for sure.
>>
>> Hilscher is proposing a Linux driver for the cifX boards. Not for free,
>> I can't do anything about that fact.
>> Then our customer gets the source code. The documentation is available
>> on our web site.
>>
>> As I like FLOSS and have years of fiddling here and there, I have
>> noticed Xenomai existence and usage in projects such as Orocos and Linux
>> CNC.
>> And I have noticed also the usage of CIF boards in those projects.
>>
>> So I have proposed to my manager and J=E9r=F4me to work on a Xenomai dri=
ver
>> for cifX boards and it was accepted.
>>
>> Again, we are not kernel developers and our background is different.
>>
>> Of course we could sell some boards but it is nothing compared to the
>> time and energy we have already spent in this project.
> You should not underestimate the value of code review here. Gilles and I
> both pointed out flaws in your code that existed not just due to the
> "unusual" target environment. I hope there were some patterns to pick up
> for other projects as well.
We do not underestimate and we try to observe every point you make.
Of course, we know we can learn a lot from Gilles and you.
> And don't take it personally, it's human to err.
I don't take it personally, specially because I am not the developer.
But I feel concerned about J=E9r=F4me's feelings.
> I've seen a lot of code
> written by a single person or a certain group that is very "focused",
> not taking care of corner cases. And you'll find bugs in my code as well
> before - and sometimes unfortunately also after - it went through
> thorough review.
You have to consider that we are not kernel coders and we have struggled=20
with code coming from UIO, RTDM and Hilscher's toolkit, which we cannot=20
offer to review since it is Mister Hilscher property.
We have read the documentation on drivers writing and it has not been=20
easy to figure out what was really needed.
So it is likely that there are bugs in our code and we are happy if you=20
can help us to get rid of them.
Unfortunately, we can only offer the RTDM code for review and cross=20
fingers about the user land stuff.

>
>> Our customers are traditionally using RTX or VxWorks with our boards. I
>> wanted to promote the use of Linux / Xenomai for some kind of applicatio=
ns.
> Which is likely a good idea when thinking long-term.
May be. Everyone has to make a living.
I don't blame anybody who has a different opinion. Hilscher is not an=20
Open Source company either.

>
>> We have received some support from Gilles and Jan and I thank them very
>> much but the tone was never very friendly.
>>
>> I understand that FLOSS projects need to sell training and development
>> but the cost would have cancelled the project since we don't think we
>> could generate the cash to cover the expenses. So the driver is done on
>> our free time.
> We appreciate your effort, and I'm sorry to hear that you have no
> backing to finish this officially - specifically as the result should
> provide a better customer experience of your products. I know what you
> are talking about, sometimes I'm still involved in similar fights.
Well, I wish I had a customer buying 500 boards to use with Xenomai.=20
This would trigger some interest.

>
>> I am just wondering why in this list nobody cares of saying Hi or Hello
>> before anything.
>> May be you are just too busy reading / writing kernel code lines.
>>
>> I am a little bit disappointed. Sorry for bothering you.
> The tone may appear rough, sorry, and it is sometimes related to the
> number of mails and, thus, contexts we work in every day (various OSS
> projects, customer projects, internal stuff...). So some statements
> become briefer. Sometimes they also become a bit rougher when requests
> to change certain issues are simply ignored without commenting on the why.
Simply ignored, I don't think so. Sometimes one only simply doesn't=20
understand what another meant.
We really have no reason to not do what you want us to do.
If we see what you mean, you will get it done.

Gilles and you have a good English level, it is not our case.
We may have other weaknesses.

>
> Jan
>

Best Regards,
Cordialement,

St=E9phane LOS
slos@hilscher.com
Support technique

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Hilscher France
12, rue du 35=E8me R=E9giment d'Aviation
Miniparc du Ch=EAne
69500 BRON
France
T=E9l. : +33 (0) 4 72 37 98 40
Fax  : +33 (0) 4 78 26 83 27
http ://www.hilscher.fr
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


