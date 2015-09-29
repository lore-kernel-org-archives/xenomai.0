Date: Tue, 29 Sep 2015 22:49:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150929204945.GD18188@hermes.click-hack.org>
References: <55E5FB89.3080604@xenomai.org> <55E60743.30600@xenomai.org>
 <CAJqUr7zP85A6V7n9O=++iC4tJK8LCG5JC8xtO9Xd+u3sQW4G1A@mail.gmail.com>
 <5604517A.2000602@mperpetuo.com>
 <20150925150248.GE1332@hermes.click-hack.org>
 <560580E6.6070208@mperpetuo.com>
 <20150925180137.GF1332@hermes.click-hack.org>
 <20150926112419.GH1332@hermes.click-hack.org>
 <CAPuu0=hEDw3g4pkJfWsAy-LkgwL=SrGyb1xPuU7a3-5LKYuHZg@mail.gmail.com>
 <20150929141439.GS15616@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150929141439.GS15616@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Sep 29, 2015 at 10:14:39AM -0400, Lennart Sorensen wrote:
> On Mon, Sep 28, 2015 at 04:57:28PM -0700, Dmitriy Cherkasov wrote:
> > To be accurate, my answer is not "no", but more of a "not yet".
> > 
> > My original goal is to get it working without lazy switching, then optimize
> > later if needed.
> > 
> > Yes, this looks correct, and thank you for the patch. I've applied it to
> > ipipe and made the relevant changes to Xenomai. I will push this to our
> > gitlab shortly.
> > 
> > However, armv8 does not trap divide by zero or overflows, and does not seem
> > to trap other things like sqrt(-1) either (at least on A53). So currently
> > I've been unable to exercise this code.
> 
> Wow, they dropped the exceptions from armv8 and just made those bits
> reserved?  Why would they do that?

Well, now that I think about it, not a long time ago, I tried
generating FPU exceptions traps on omap3, omap4 and maybe
at91sama5d3 and discovered these processors could not generate such
traps either.

-- 
					    Gilles.
https://click-hack.org

