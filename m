Date: Tue, 29 Sep 2015 19:47:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150929174728.GA18188@hermes.click-hack.org>
References: <CAJqUr7zP85A6V7n9O=++iC4tJK8LCG5JC8xtO9Xd+u3sQW4G1A@mail.gmail.com>
 <5604517A.2000602@mperpetuo.com>
 <20150925150248.GE1332@hermes.click-hack.org>
 <560580E6.6070208@mperpetuo.com>
 <20150925180137.GF1332@hermes.click-hack.org>
 <20150926112419.GH1332@hermes.click-hack.org>
 <CAPuu0=hEDw3g4pkJfWsAy-LkgwL=SrGyb1xPuU7a3-5LKYuHZg@mail.gmail.com>
 <20150929001233.GB15767@hermes.click-hack.org>
 <560A89FC.9060808@xenomai.org> <560ACAF1.2020305@mperpetuo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <560ACAF1.2020305@mperpetuo.com>
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Cc: xenomai@xenomai.org

On Tue, Sep 29, 2015 at 10:31:29AM -0700, Dmitriy Cherkasov wrote:
> 
> 
> On 09/29/2015 05:54 AM, Jorge Ramirez Ortiz wrote:
> > On 09/28/2015 08:12 PM, Gilles Chanteperdrix wrote:
> >> On Mon, Sep 28, 2015 at 04:57:28PM -0700, Dmitriy Cherkasov wrote:
> >> Ok, this page:
> >> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0024a/CJHECGIH.html
> >>
> >> seems to indicate that armv8 may or may not trap upon
> >> exception. Or maybe the exceptions can be enabled with the FPCR
> >> register? Or the glibc functions defined in the fenv.h header?
> >>
> > the way it is worded it appears to be a decision left to the SoC vendor.
> > I'll post the question to support@arm.com for confirmation.
> >
>  From some earlier docs, it looks like it was possible to toggle 
> trapping with FPCR, but as Lennart mentioned those bits appear to now be 
> reserved. On our hardware, setting them has no effect.
> 
> 
> I also enjoyed this part:
> 
> Both floating-point and NEON are required in all standard ARMv8 
> implementations. However, implementations targeting specialized markets 
> may support the following combinations:
> 
>   *
> 
>     No NEON or floating-point

Well, I guess there is a difference between "standard" and
"implementation targeting specialized markets".

-- 
					    Gilles.
https://click-hack.org

