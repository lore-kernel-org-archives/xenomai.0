Date: Fri, 6 Feb 2015 16:03:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150206150311.GB27277@hermes.click-hack.org>
References: <54D49E26.6090705@control.lth.se>
 <20150206110711.GA23751@hermes.click-hack.org>
 <54D4A442.3090802@control.lth.se>
 <20150206141226.GA27277@hermes.click-hack.org>
 <54D4D464.1000906@control.lth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54D4D464.1000906@control.lth.se>
Subject: Re: [Xenomai] Support for SIOCGIFNAME in rtnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Feb 06, 2015 at 03:49:08PM +0100, Anders Blomdell wrote:
> On 2015-02-06 15:12, Gilles Chanteperdrix wrote:
> > On Fri, Feb 06, 2015 at 12:23:46PM +0100, Anders Blomdell wrote:
> >> On 2015-02-06 12:07, Gilles Chanteperdrix wrote:
> >>> On Fri, Feb 06, 2015 at 11:57:42AM +0100, Anders Blomdell wrote:
> >>>> A patch that I would find useful.
> >>>
> >>> Indeed, can we avoid strncpy ?
> >> In favour of what? I blatantly stole that line from the SIOCGIFCONF a few
> >> line above :-)
> > 
> > strlcpy. 
> Ok, change the line above my patch as well?

I will do it, thanks.

-- 
					    Gilles.

