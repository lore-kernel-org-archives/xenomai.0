Date: Mon, 1 Aug 2016 14:43:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160801124349.e43drmgcwknjcsde@hermes.click-hack.org>
References: <20160709132949.GA22236@hermes.click-hack.org>
 <20160801132946.368f30eb@md1em3qc>
 <20160801140351.1a2b224e@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160801140351.1a2b224e@md1em3qc>
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

On Mon, Aug 01, 2016 at 02:03:51PM +0200, Henning Schild wrote:
> Am Mon, 1 Aug 2016 13:29:46 +0200
> schrieb Henning Schild <henning.schild@siemens.com>:
> 
> > Hey Gilles,
> > 
> > i just checked out the new release, which came as a surprise. Thanks
> > for publishing that!
> > 
> > Some of the patches prepare for kernel 4.0+ but one specifically makes
> > sure the combination 4.0+ and 2.6.5 wont work.
> > 
> > Am Sat, 9 Jul 2016 15:29:49 +0200
> > schrieb Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> > 
> > ...
> > >       hal/x86: forbid compilation with Linux 4.0+  
> > ...
> > 
> > Could you please provide details on how the FPU support is broken. I
> > am successfully using xenomai 2.6 with 4.1.18 for some time now. I am
> > not sure whether the applications on top use the FPU and if so, if
> > there are multiple FPU-users per core.
> 
> In continous integration the switchtest FPU test never triggered, not
> in 64 nor in 32-bit mode.

That is probably because you have one of the two options known to
cause Linux to use FPU in kernel-space (raid or a K6 processor),
which prevents the switchtest test itself to use the FPU in Linux
kernel-space and test that we can preempt it in the middle of such
usage. If that is the case, your continuous integration tests kernel
logs should contain:

Warning: Linux is compiled to use FPU in kernel-space.
For this reason, switchtest can not test using FPU in Linux
kernel-space.

The kernels for continuous integration should be compiled without
raid or X86_USE_3DNOW support, so that switchtest can test
preempting Linux in the middle of using FPU in kernel-space, and if
the test work, it should normally be safe to enable RAID or
X86_USE_3DNOW in the production kernel.

If the test do not pass, and you enable, say RAID, on your
production kernel, and actually use RAID, you can expect data
corruption.

So, all in all, having that thing broken is better handled with a
#error than with silent data corruption.

There may be other ways around though, such as forcing Linux to use
integer implementation of RAID rather than FPU based version.

-- 
					    Gilles.

