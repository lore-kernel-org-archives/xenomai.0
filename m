From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: <4AF12B70.3020004@domain.hid>
References: <B0122F57-107F-4E31-A663-D4DE560C08B8@domain.hid>
	<C790DE41-A093-46C5-9F44-D3F0EA839CF5@domain.hid>
	<20091104065257.A164B3F6C1@domain.hid>
	<4AF12B70.3020004@domain.hid>
Date: Wed, 04 Nov 2009 08:26:05 +0100
Message-Id: <20091104072605.D26E63F6C1@domain.hid>
Subject: Re: [Xenomai-help] bring down the system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonas Buchli <jonas@domain.hid>
Cc: Peter Pastor <pastor@domain.hid>, xenomai@xenomai.org

Dear Jonas Buchli,

In message <4AF12B70.3020004@domain.hid> you wrote:
> 
> did you compile with exactly our compile statement or with additional 
> flags (i.e. optimization)?

With optimization, of course.

> compiling with our statement, just throwing in the -S flag, i am getting 
> a very getting different assembly code - while has been a while i have 
> been reading assembly, it seems our loop is not getting optimized away.
> 
> anyway, the point here is not about if this is a meaningful program or 
> not, but we are getting system lock ups and this one is a minimal 
> program that does reproduce the problem for us.

What sort of machine is this?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
Do you suppose the reason the ends of the `Intel Inside'  logo  don't
match up is that it was drawn on a Pentium?

