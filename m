From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4546494d0609300026s6be1145awedaeb10af460d56d@domain.hid>
References: <4546494d0609300026s6be1145awedaeb10af460d56d@domain.hid>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 23:18:26 +0200
Message-Id: <1160342307.4963.35.camel@domain.hid>
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

On Sat, 2006-09-30 at 15:26 +0800, Li Yi (Adam) wrote:
> Hi Philippe,
> 
> I updated the adeos-bfin patch to bfin-uClinux 2006R2 (the release
> will be available soon).
> Could you please have a look?
> 

Looks good, thanks. I'm currently upgrading it to use the PF_EVNOTIFY
support available with the latest Adeos core, so that all archs will be
in sync.

> The patch can also be found and the bfin-uClinux CVS:
> http://blackfin.uclinux.org/plugins/scmcvs/cvsweb.php/~checkout~/uClinux-dist/bfin_patch/adeos_patch/adeos-bfin-cvs.patch?rev=1.1.2.1;content-type=text%2Fplain;cvsroot=uclinux533
> 
> Best Regards,
> 
> -Yi
-- 
Philippe.



