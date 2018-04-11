Date: Wed, 11 Apr 2018 09:45:04 -0400
Message-ID: <20180411134504.c5pswbha72ywtc7l@csclub.uwaterloo.ca>
References: <CAOuPNLhmVjMMm80Xmu9DKCAD7QqyRZ_qBbnmCi38nKX9defDVQ@mail.gmail.com>
 <fg9ar1ooobcbsnuj1ib0ko69.1523444325709@embeddedgreg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fg9ar1ooobcbsnuj1ib0ko69.1523444325709@embeddedgreg.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [Xenomai] How to use rtdm serial driver on beagle bone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Apr 11, 2018 at 06:58:45AM -0400, Greg Gallagher wrote:
> What serial chip is on the beaglebone? If it's not supported then your best bet is to port the Linux driver to rtdm.

I believe the normal driver is the 8250_omap.

So it is 16550 style, but not 100% the same.

-- 
Len Sorensen

