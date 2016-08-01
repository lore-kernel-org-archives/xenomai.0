Date: Mon, 1 Aug 2016 14:48:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160801124836.kdisxymme6ljjq3k@hermes.click-hack.org>
References: <20160709132949.GA22236@hermes.click-hack.org>
 <20160801132946.368f30eb@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160801132946.368f30eb@md1em3qc>
Subject: Re: [Xenomai] [Announce] Xenomai 2.6.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Mon, Aug 01, 2016 at 01:29:46PM +0200, Henning Schild wrote:
> Hey Gilles,
> 
> i just checked out the new release, which came as a surprise. Thanks
> for publishing that!
> 
> Some of the patches prepare for kernel 4.0+ but one specifically makes
> sure the combination 4.0+ and 2.6.5 wont work.
> 
> Am Sat, 9 Jul 2016 15:29:49 +0200
> schrieb Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> 
> ...
> >       hal/x86: forbid compilation with Linux 4.0+

Actually, the commit message is prefixed with hal/x86, so it only
makes sure that the combination 4.0+ and 2.6.5 does not work on x86.
It does not make sure that the combination does not work for other
architectures.

-- 
					    Gilles.

