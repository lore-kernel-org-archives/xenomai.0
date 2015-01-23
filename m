Date: Fri, 23 Jan 2015 16:52:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150123155231.GD9521@hermes.click-hack.org>
References: <129277905.Ag2XebZWbK@soho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <129277905.Ag2XebZWbK@soho>
Subject: Re: [Xenomai] Packaging Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On Fri, Jan 23, 2015 at 01:09:41PM +0100, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> now that I have some kernel to boot, I would like to ask some aspects of 
> Xenomai-3 in order to package it.
> 
> Reading the documentation, now the new libxenomai could use two kind of 
> kernels: the patched one (Cobalt) or the preempt_rt (Mercury).

a preempt_rt kernel is a patched kernel too.

> 
> 1) Is it possible to have _only_ one library (binary) that uses one or another 
> kernel in function which is running?

No, you could want to run a kernel with both patches. So basing the
decision on which patch you are running does not make sense.

-- 
					    Gilles.

