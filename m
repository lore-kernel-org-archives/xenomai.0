Subject: Re: [Xenomai-core] Undefined reference to
	___wrap_pthread_mutex_lock and friends on Blackfin
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4558339F.5070500@domain.hid>
References: <822467320611121613u2cbcd224nc3afedd43d4b4463@domain.hid>
	<4558339F.5070500@domain.hid>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 10:40:51 +0100
Message-Id: <1163410852.4990.11.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, 2006-11-13 at 09:58 +0100, Gilles Chanteperdrix wrote:

[...]

> > Also, it would appear that Xenomai releases post 2.2.3 will not run on
> > an unpatched uClinux R06R1-RC2.  The problem seems to be that some
> > macros were added to the newer kernel for addressing various
> > peripherals.  Xenomai > 2.2.3 uses these macros which are not defined
> > in this official uClinux release.  It would be nice to note something
> > to this effect in the readme.
> 
> What macros ?
> 

Not related to the POSIX skin, but rather to the HAL/SAL Xenomai layers.
These are MMIO register accessors which were not defined in earlier
Blackfin kernel versions, including the official R06R1-RC2 release.
Since I'm tracking the Blackfin CVS, I've updated the Xenomai codebase
to use them, but this prevents to compile Xenomai against earlier
kernels.

-- 
Philippe.



