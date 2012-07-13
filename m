Message-ID: <50000D7C.2010809@siemens.com>
Date: Fri, 13 Jul 2012 13:58:52 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <4F534D1A615F544D95E57BFD8460658301CBE3B9@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFE189C.7060504@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658301CBE3BD@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFE8B7C.60506@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658301CBE3C2@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
	<4FFFEB98.7060106@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658302FEBCEB@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
	<500001AC.5040706@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658302FEBD85@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
In-Reply-To: <4F534D1A615F544D95E57BFD8460658302FEBD85@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] BUG: Unhandled exception over domain Xenomai -
 switching to ROOT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Jorge Ramirez Ortiz, HCL Europe" <Jorge.Ramirez-Ortiz@hcl.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

[please don't top-post]

On 2012-07-13 13:24, Jorge Ramirez Ortiz, HCL Europe wrote:
> Yes it does: the caller ignores upfront whether the call will be handled in realtime or non-realtime context by the driver.
> The client (of course!) can/should (it doesn't really matter for the sake of the argument) take the adequate measures to make sure it will get into the adequate path.
> But the _interface_ does not guarantee which path it will take. This is a fact that you can't disagree with.
> 
> But please allow me to re-frame the discussion: I am not discussing here about realtime design practises or about how to use the framework properly.
> I am merely commenting on  the _interfaces_ to the realtime framework and their consistency.

As far as I understood, you were using interfaces outside of the scope
of the RTDM framework. Sorry, we can change the Linux kernel to
gracefully handle all types of improper RT designs. We already have
quite some infrastructure to detect such scenarios, and if there are
holes, we are happy for suggestions (bug reports, patches etc.) to plug
them. But, e.g., failing a call like wake_up from wrong contexts is
impractical (there are too many spots to patch). Or what is your
expectation?

BTW, if you call wake_up under PREEMPT-RT from a hard IRQ handler, you
will get similar results: at best lockdep will bark at you, at worst
your box locks up hard. Different architecture, similar problem.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

