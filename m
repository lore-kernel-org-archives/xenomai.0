Message-ID: <4B7657E2.6000901@domain.hid>
Date: Sat, 13 Feb 2010 08:42:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02581002110136x481f99cby7edbb811af7f905b@domain.hid>
	<4B73ED7A.9090803@domain.hid>
	<1f3e02581002121826j9341915v1349a2188e75927@domain.hid>
In-Reply-To: <1f3e02581002121826j9341915v1349a2188e75927@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [ARM-MV88F6290] Xenomai 2.5.1 latency test
 results (still negative and huge)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sergey Didenko <didenkos@domain.hid>
Cc: xenomai@xenomai.org

Sergey Didenko wrote:
> Thank you, Gilles
> 
> 1) Yeah, I understand that my application (originally written for VxWorks)
> is not adapted somehow to work properly under Xenomai (the threads are
> switching to secondary mode very often, for example)..ok..but, test
> application is also running under xenomai and if I define the highest
> priority for my test task it should show the best latency it can ever get
> from Xenomai, I'm I right?
> Could you please comment what kind of BUG I should try find out...in how
> should I optimize my application?

The bug is not in the applications, since the application in question
(latency) is running fine on other platforms, including ARM ones. The
bug is in your port.

> 
> 2) which options you usualy use for diff command to make the proper (I mean
> the format which is commonly used by Xenomai guys) diff file?

diff -u
git diff does it just fine. And if you do not use git, you should.

> 
> 3) Do you have enough documentation where I can find the answers for my
> questions?
> Looks like yes, since you ignore answering the questions I asked you. Give
> me the links on it then, please!

I do not think there is a general documentation on how to debug code. It
really depends on what code you debug, and what are the symptoms you
observe.

-- 
					    Gilles.

