Date: Wed, 16 Dec 2015 07:42:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151216064242.GC1786@hermes.click-hack.org>
References: <CAG6c7CZ4_mpBc-gK0Li2yQJFW4pNkSCN26U2hWnw_osG+2RaDA@mail.gmail.com>
 <20151215184347.GA16267@hermes.click-hack.org>
 <BLU437-SMTP66295A1035F746065AC6D9F0EF0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLU437-SMTP66295A1035F746065AC6D9F0EF0@phx.gbl>
Subject: Re: [Xenomai] patch for RPI2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Cc: ilyasse toumi <toumi.ily@gmail.com>, xenomai@xenomai.org

On Tue, Dec 15, 2015 at 07:12:26PM -0800, Mathieu Rondonneau wrote:
> On 15-12-15 10:43 AM, Gilles Chanteperdrix wrote:
> > On Tue, Dec 15, 2015 at 01:22:55PM +0100, ilyasse toumi wrote:
> >> Hi there,
> >>
> >> I'm using kernel rpi-3.18.y as mentioned in an email sent by Joe Lee about
> >> RPI2, I used the patch ipipe-core-3.18.20-arm-6.patch and also the patch
> >> for RPI2 version5, the problem is that when i try to compile the kernel
> >> after patching it it gives some errors.
> >> It's about some implicit declarations of functions that are present in the
> >> patch like
> >>
> >> __ipipe_mach_update_tsc
> > 
> > This one is probably due to a misconfiguration, i.e. you enabled
> > xenomai, but not a SOC or SOC family which provides an emulated tsc.
> > A lot of the coded added by the patch is compiled conditionally, so
> > the fact that a definition for a function is present in the patch
> > does not necessarily mean that it will be present with your
> > particular build configuration.
> >
> if you do use Xenomai-3.0, it could be that you are missing this part of
> the patch?

More likely, the SOC is not enabled in the kernel configuration.

> >> smp_mb__before_atomic_dec
> >> smp_mb__before_atomic_dec
> > 
> > This one indicates a version of Xenomai not ready for Linux 3.18.
> > Xenomai 2.6.4 for instance can not be compiled with anything more
> > recent than Linux 3.14. You can use Xenomai 2.6 git if you want
> > Linux 3.18 support, or if starting a new development, it probably
> > makes more sense to jump to Xenomai 3.0 directly.
> > 
> > Regards.
> > 
> That is correct, the patch is only for Xenomai 3.0.

No. The patch should also work with Xenomai 2.6, but you need
Xenomai 2.6 git.

-- 
					    Gilles.
https://click-hack.org

