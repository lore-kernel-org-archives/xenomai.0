Date: Tue, 15 Dec 2015 19:43:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151215184347.GA16267@hermes.click-hack.org>
References: <CAG6c7CZ4_mpBc-gK0Li2yQJFW4pNkSCN26U2hWnw_osG+2RaDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG6c7CZ4_mpBc-gK0Li2yQJFW4pNkSCN26U2hWnw_osG+2RaDA@mail.gmail.com>
Subject: Re: [Xenomai] patch for RPI2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ilyasse toumi <toumi.ily@gmail.com>
Cc: xenomai@xenomai.org

On Tue, Dec 15, 2015 at 01:22:55PM +0100, ilyasse toumi wrote:
> Hi there,
> 
> I'm using kernel rpi-3.18.y as mentioned in an email sent by Joe Lee about
> RPI2, I used the patch ipipe-core-3.18.20-arm-6.patch and also the patch
> for RPI2 version5, the problem is that when i try to compile the kernel
> after patching it it gives some errors.
> It's about some implicit declarations of functions that are present in the
> patch like
> 
> __ipipe_mach_update_tsc

This one is probably due to a misconfiguration, i.e. you enabled
xenomai, but not a SOC or SOC family which provides an emulated tsc.
A lot of the coded added by the patch is compiled conditionally, so
the fact that a definition for a function is present in the patch
does not necessarily mean that it will be present with your
particular build configuration.

> smp_mb__before_atomic_dec
> smp_mb__before_atomic_dec

This one indicates a version of Xenomai not ready for Linux 3.18.
Xenomai 2.6.4 for instance can not be compiled with anything more
recent than Linux 3.14. You can use Xenomai 2.6 git if you want
Linux 3.18 support, or if starting a new development, it probably
makes more sense to jump to Xenomai 3.0 directly.

Regards.

-- 
					    Gilles.
https://click-hack.org

