Message-ID: <4C3EF6D6.6040907@domain.hid>
Date: Thu, 15 Jul 2010 13:53:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1278943817.7023.18.camel@domain.hid>
In-Reply-To: <1278943817.7023.18.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Marvell sheeva support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tim Cussins <timcussins@domain.hid>
Cc: xenomai@xenomai.org

Tim Cussins wrote:
> Hi all,
> 
> We're looking at migrating to one of Marvell's MV88F series SOC's, and
> are very keen to deploy Xenomai as part of our solution.
> 
> I noticed Sergey Didenko was looking at this a few months back and
> things looked to be ok - has his (or anyone else's) work made it into a
> stable release?
> 
> I will be able to assist in about a fortnight if that would be useful
> for squaring that work away.
> 
> Let me know if I can help!

We are interested. I seem to remember that Serguey had unexplained
latencies issues, so, if you start with his work, please bear this in
mind, there was probably something wrong with his port. A guide
explaining how to port the I-pipe patch on ARM exists:
http://www.xenomai.org/index.php/I-pipe:ArmPorting

The section about chained GPIOs irqs is outdated, if your platform has
some, I will explain how it should be implemented.

Please start from the I-pipe git (git://git.denx.de/ipipe-2.6.git),
merging it with the branch you will use if needed, so that you can
submit a patch only containing the modifications necessary for the
Sheeva platform.

We can also provide you with a root filesystem for validating this platform.

-- 
					    Gilles.

