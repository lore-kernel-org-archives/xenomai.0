Date: Thu, 30 Apr 2015 22:14:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150430201409.GA1993@hermes.click-hack.org>
References: <CAKC9m6fXKqNhwy3sZ9zqzoAu=Xb7TUSxceogpE7xxB9-J=11wQ@mail.gmail.com>
 <20150430183147.GZ1993@hermes.click-hack.org>
 <CAKC9m6cXp+ZQdZG2qCQA5+J2m0W-2hnLniL0wswfSu5aD32wwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKC9m6cXp+ZQdZG2qCQA5+J2m0W-2hnLniL0wswfSu5aD32wwg@mail.gmail.com>
Subject: Re: [Xenomai] Ipipe-core patched kernel fails to start when certain
 platform drivers are enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongfei Cheng <hongfei@mperpetuo.com>
Cc: xenomai@xenomai.org

On Thu, Apr 30, 2015 at 01:04:07PM -0700, Hongfei Cheng wrote:
> On Thu, Apr 30, 2015 at 11:31 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Thu, Apr 30, 2015 at 08:53:10AM -0700, Hongfei Cheng wrote:
> >> 4). High resolution counter is not yet supported as we're exploring
> >> different way(s) to implement TSC.
> >
> > Note the implications here: if you say "all armv8 will use
> > architected timer", we can get away with a unique implementation. If
> > you want to use another timer, then we will have to implement kernel
> > helpers with a constant kernel/user ABI, so probably in the vdso.
> > All this for an improved accuracy that may well not be worth the
> > trouble.
> 
> Currently we're not concerned about tsc accuracy.
> 
> Could you elaborate a bit more on the "architected timer" and the
> possible implementation you envision on Cortex-A53/A57?

"architected timer" is the name of the timers available since cortex
A15 (on A7 also, I guess it allows big/little to run exactly the
same code on both cores), and I thought I had understood it was also
available on armv8. These timers are guaranteed to operate a long
period of time without wrapping (something like tens of years), so
they do not have a resolution as high as they could have (especially
since implementations use less than 32 bits of the higher 32 bits).

> 
> Is the I-pipe tracer dependent upon a live/running tsc counter?

To get timestamped results yes. But you can probably run it with
stubs, the timing information will be unusable that is all. The
frequency can not be null though, so you can set something like 1
MHz and it should work.

-- 
					    Gilles.

