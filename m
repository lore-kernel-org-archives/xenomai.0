Date: Sat, 13 Feb 2016 19:42:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160213184233.GB5255@hermes.click-hack.org>
References: <20160208090702.GA29803@hermes.click-hack.org>
 <20160208101810.7aec631a@md1em3qc> <56B87392.8040703@web.de>
 <20160208123757.GC29803@hermes.click-hack.org>
 <20160208140259.66e5dc7f@md1em3qc>
 <20160208195533.24C19384496@gemini.denx.de>
 <20160209123826.2add02cc@md1em3qc>
 <20160209163025.B77DD385B08@gemini.denx.de>
 <20160209190544.GH5654@hermes.click-hack.org>
 <20160209214846.C3085380907@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160209214846.C3085380907@gemini.denx.de>
Subject: Re: [Xenomai] mailinglist write access for non-subscribers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Denk <wd@denx.de>
Cc: Jan Kiszka <jan.kiszka@web.de>, Xenomai <xenomai@xenomai.org>

On Tue, Feb 09, 2016 at 10:48:46PM +0100, Wolfgang Denk wrote:
> Dear Gilles,
> 
> In message <20160209190544.GH5654@hermes.click-hack.org> you wrote:
> >
> > > Yes, there is spamassassin running...
> > 
> > xenomai.org also has spamassassin at SMTP time rejecting mails with
> > score higher than 10. Since we had one spam today, I wonder if 10 is
> > may not be a little high. If I may ask, at what score do you reject
> > posts on the u-boot mailing list?
> 
> We are using the default: required_score 5.0
> 
> I cannot remember that I've ever seen a false positive with this
> setting.  But I realize that this is similar to the statement "our
> computer has never had an undetected error." :-)

Ok, I have been a bit more cautious and redirected all mails with a
score higher than 50 to a new mailing list named spam@xenomai.org,
so that we can check the archives if a mail gets lost.

If everybody receives this mails, this means that I have not broken
the mailman setup in the same move.

-- 
					    Gilles.
https://click-hack.org

