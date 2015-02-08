Date: Sun, 8 Feb 2015 19:54:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150208185448.GD2014@hermes.click-hack.org>
References: <20150208173849.GA2014@hermes.click-hack.org>
 <2e77-54d7af80-c1-61088680@169838476>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e77-54d7af80-c1-61088680@169838476>
Subject: Re: [Xenomai] The latency test hangs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dauphin Alexandre <alexandre.dauphin@ecole.ensicaen.fr>
Cc: Xenomai <xenomai@xenomai.org>

On Sun, Feb 08, 2015 at 07:48:18PM +0100, Dauphin Alexandre wrote:
> 
> Thanks you for your answer.
> I knows that 120000 is too long. But when i tried sampling with 10
> us

Sampling with 10us should cause a lockup, and trigger the watchdog.

> ,100us or 1000us.
> It's the same result , nothing append.

100us or 1000us should be fine, have you tried waiting a few seconds
before interrupting the test? "warming up" means that nothing
happens for some 1s.

Please stay on the list.

-- 
					    Gilles.

