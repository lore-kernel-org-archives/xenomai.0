Date: Thu, 26 Feb 2015 23:37:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150226223750.GF434@hermes.click-hack.org>
References: <44siduq7us.fsf@be-well.ilk.org> <54EE07A9.4040702@xenomai.org>
 <444mq9lo5c.fsf@be-well.ilk.org> <44vbipk8m9.fsf@be-well.ilk.org>
 <54EF014A.9000902@xenomai.org> <447fv4sk55.fsf@lowell-desk.lan>
 <54EF5E45.30907@xenomai.org> <44a900eaqu.fsf@lowell-desk.lan>
 <20150226201100.GB434@hermes.click-hack.org>
 <441tlce3o1.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441tlce3o1.fsf@lowell-desk.lan>
Subject: Re: [Xenomai] interrupt service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>
Cc: xenomai@xenomai.org

On Thu, Feb 26, 2015 at 04:58:06PM -0500, Lowell Gilbert wrote:
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:
> > So, to be clear, does the ISR run on CPU0 and the thread doing the
> > reads run on CPU1? If no, does it work if you do it that way? To
> 
> The other way around, but that's pretty much what I have set up. CPU0
> handles work that doesn't need to be real-time, and CPU1 handles only
> the real-time work.

That is the part I do not understand. Since the read method is
real-time as well as the ISR, you mean you run them on the same cpu?
If yes, have you tried running them on different cpus ?

-- 
					    Gilles.

