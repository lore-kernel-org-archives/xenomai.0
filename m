Message-ID: <50001532.60406@xenomai.org>
Date: Fri, 13 Jul 2012 14:31:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
Content-Type: text/plain; charset=UTF-8
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

On 07/13/2012 01:24 PM, Jorge Ramirez Ortiz, HCL Europe wrote:
> Yes it does: the caller ignores upfront whether the call will be
> handled in realtime or non-realtime context by the driver. The client
> (of course!) can/should (it doesn't really matter for the sake of the
> argument) take the adequate measures to make sure it will get into
> the adequate path. But the _interface_ does not guarantee which path
> it will take. This is a fact that you can't disagree with.
> 
> But please allow me to re-frame the discussion: I am not discussing
> here about realtime design practises or about how to use the
> framework properly. I am merely commenting on  the _interfaces_ to
> the realtime framework and their consistency.

Philippe and Jan have answered already, so I am going to make it really
short.

The Linux kernel API has hundreds of services, much of which can not be
re-entered from an RT context, that is a consequence of the "dual
kernel" model. It would simply be silly to assume that we have put LARTs
in these hundreds of services. Knowing that you can not call linux
services when in RT context in driver code is simply part of the things
you should know when developing an RTDM driver.

You forgot that, you got bitten, now get over it.

-- 
					    Gilles.

