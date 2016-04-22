Date: Fri, 22 Apr 2016 15:29:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160422132926.GE1780@hermes.click-hack.org>
References: <CAMQ-e4_L=X+8Nn5R+LnsEgtz4ZRgz8KaN48qhV-4vFCwpkFt5A@mail.gmail.com>
 <5719E9A4.5050701@xenomai.org>
 <CAMQ-e4_PrqpX3Eo8nQLo8k4B9aEKPXTEe1Ug4bThcA3kpA2aOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMQ-e4_PrqpX3Eo8nQLo8k4B9aEKPXTEe1Ug4bThcA3kpA2aOA@mail.gmail.com>
Subject: Re: [Xenomai] Assertion failed on "test posix_clock" on some
 executions of xeno-test.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andrea <andrea.schiappacasse@camelotbio.com>
Cc: Xenomai@xenomai.org

On Fri, Apr 22, 2016 at 02:32:19PM +0200, Andrea wrote:
> Hi Philippe, thanks for your answer,
> 
> I ran autotune but the output didn't change, sometimes the assertion just
> fails as before.
> Do you think that it could lead to any problem in the standard Xenomai
> usage? Or is it something that I may safely ignore? I didn't notice any
> strange behaviour so far, but I'm wondering if this could be an indicator
> of something going wrong in the system I'm testing.
> 
> Just in case it can be of any use, you can find attached the config of my
> kernel.

Are you sure that nothing else is running in the background? Like
dohell processes from the previous run? Most of the unit test are
supposed to be run on the machine with no load.

-- 
					    Gilles.
https://click-hack.org

