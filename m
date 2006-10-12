From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4546494d0609300026s6be1145awedaeb10af460d56d@domain.hid>
References: <4546494d0609300026s6be1145awedaeb10af460d56d@domain.hid>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 23:09:39 +0200
Message-Id: <1160687379.4970.34.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: Updated ADEOS patch for Blackfin uClinux 2006R2
	release
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
To: "Li Yi (Adam)" <liyiadam@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org


Hello Yi,

On Sat, 2006-09-30 at 15:26 +0800, Li Yi (Adam) wrote:
> Hi Philippe,
> 
> I updated the adeos-bfin patch to bfin-uClinux 2006R2 (the release
> will be available soon).
> Could you please have a look?

This looks good, and works as expected, thanks.

> The patch can also be found and the bfin-uClinux CVS:
> http://blackfin.uclinux.org/plugins/scmcvs/cvsweb.php/~checkout~/uClinux-dist/bfin_patch/adeos_patch/adeos-bfin-cvs.patch?rev=1.1.2.1;content-type=text%2Fplain;cvsroot=uclinux533
> 

Ok, I've merged your patch with the latest generic changes in the Adeos
CVS, so we will have the Blackfin support in sync with the most recent
I-pipe updates, over the Blackfin CVS head. Figures look good, actually
with a better worst-case than the 1.4 series had, likely due to the
PF_EVNOTIFY feature which has been recently introduced. The large
latency spot I told you recently about has also been fixed in the
meantime (the vanilla Blackfin kernel was out of cause, but the Adeos
PF_EVNOTIFY feature did break due to a Blackfin-specific issue).

I'm now merging your tracer support. From now on, the latter will be
integrated to the main Adeos patch for all archs, since it does not make
much sense to have two separate patches for each of them now, which
would also uselessly increase the maintenance burden.

This said, I'm currently struggling with the tracer, which makes the
bf533 freeze when enabled, during the very early boot steps. I suspect
some issues with having -pg enabled for early setup code. Another issue
causes the linker to choke on the "mcount" symbol being undefined for
some files; this looks like some inconsistency with the C symbol prefix.
Btw, I'm using the 06r2 toolchain.

Could you send me your .config with the tracer options you used
(configuration for a bf533 or bf537 would do), and confirm that an
unmodified 06r2 toolchain should work properly building the whole tree
with -pg enabled? TIA,

> Best Regards,
> 
> -Yi
-- 
Philippe.



