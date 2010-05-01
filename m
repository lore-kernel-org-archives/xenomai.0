From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4BDC6924.2070302@domain.hid>
References: <4BD5987A.2050804@domain.hid> <4BD59A48.5070002@domain.hid>
	<4BD5BA03.5000101@domain.hid>
	<1272331158.28983.287.camel@domain.hid>	<4BD68843.4030806@domain.hid>
	<1272356029.28983.333.camel@domain.hid>
	<4BD69F7D.9060006@domain.hid>
	<1272359559.28983.380.camel@domain.hid>
	<4BD6AE1E.6050704@domain.hid>
	<1272360740.28983.382.camel@domain.hid>
	<4BD6AFC2.1090300@domain.hid>
	<1272361898.28983.395.camel@domain.hid>
	<4BD6BF21.20303@domain.hid>
	<1272734766.2440.46.camel@domain.hid>
	<4BDC6924.2070302@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 01 May 2010 20:59:21 +0200
Message-ID: <1272740361.2440.49.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] nucleus: Plug race between
 rpi_clear_remote and rpi_next
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Sat, 2010-05-01 at 19:47 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > Don't you think that, quoting yourself:
> > 
> > "I have to confess, I do not understand how the patch may relate to our
> > crash. But that's because I still only have a semi-understanding of this
> > frightening complex RPI code"
> > 
> > does not fit that well with any kind of strong assertion made later on
> > the same topic, not backed by facts?
> 
> See, as long as you do not directly explain why my concerns on this
> naturally racy construct were not valid (I brought up quite a few
> concrete questions),

Which were answered. And you seem to consider that a construct is racy
by design without taking care of understanding why they could be
perfectly valid in the proper context. This is what I was pointing out,
all time long.

>  I couldn't help raising them over and over again.
> This has, in fact, nothing to do with understanding the RPI code in all
> its details. It's about reviewing basic patterns of it. But now that the
> critical bit is gone, I'm surely no longer concerned. :)
> 
> > 
> > So, I'm suggesting that we move on, and end this discussion in a
> > positive manner, i.e. by fixing this code. I hear your concerns, like I
> > always do, and I'm trying to find a solution that does not paper over
> > another issue. I guess we should be able to settle on this.
> > 
> > I pushed two patches in my for-upstream queue, with lengthy comments to
> > explain what they do and why this is needed:
> > 
> > http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=ac5c739dabcb14334c2e390a9e3064f11f97283c
> > http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=d3242401b8e1cf2c28822f801b681194243b4394
> > 
> > - the first patch is a plain revert of the commit introducing
> > rpi_next(), which caused the bug you observed in SMP mode, and that your
> > patch plugged successfully.
> > 
> > - the second patch is the proper fix for the issue rpi_next() tried to
> > address.
> > 
> > Could you please try them, and report whether this also fixes the issue
> > for you? In the meantime, I will be analyzing the RPI code once again,
> > to check whether your patch still covers a possible case, or not.
> 
> I will try my best, but the issue showed up only once in countless
> application runs. We will role out the patches at the next chance (we
> already had to push my workaround as we need to deliver the fastsynch
> fix, so it may take a while).
> 

No problem with that, you were the one hit by the issue so far.

> Jan
> 


-- 
Philippe.



