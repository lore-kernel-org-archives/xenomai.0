Date: Sat, 20 Dec 2014 17:29:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141220162937.GA12315@daedalus.click-hack.org>
References: <CAFgu5KXBDRLxt4q3PUw9he+4Z97RV0=Q96Y+or7FzEwT3CVZRA@mail.gmail.com>
 <20141220153337.GD24110@csclub.uwaterloo.ca>
 <20141220160408.GB3961@daedalus>
 <20141220162139.GF24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141220162139.GF24110@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Kernel Configuration Woes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Sat, Dec 20, 2014 at 11:21:39AM -0500, Lennart Sorensen wrote:
> On Sat, Dec 20, 2014 at 05:04:08PM +0100, Gilles Chanteperdrix wrote:
> > To make it simple: from Linux point of view, Xenomai behaves just as
> > an SMI.
> 
> Certainly true, but that's the software you control so you can make it
> behave itself.

Well, the only way to make it behave itself is to not run it at all,
because as soon as Xenomai run its threads, it "steals" time to
Linux. So, the workaround is to get it to run not too long, but it
is not guaranteed to be sufficient to avoid detection, and the other
workaround is to disable Linux detection mechanisms.

-- 
					    Gilles.

