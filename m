From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] Re: [Xenomai-help] General Xenomai / RTAI Skin
	=?iso-8859-1?q?Usage=09Questions?=
Date: Tue, 1 Nov 2005 18:46:34 +0900
References: <OF8F0700EC.A1D80BF4-ONC12570AB.004AE3CB-C12570AB.005254F3@domain.hid>
	<200511011227.03173.rlenglet@domain.hid>
	<4366F875.6050802@domain.hid>
In-Reply-To: <4366F875.6050802@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011846.34223.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

> > CONFIG_PCI_MSI
> > This option messes with the oneshot timer (timer freezes).
> > (thanks to Gilles to have found this out)
>
> Could you confirm that this issue still happens with
> adeos-ipipe-2.6.13-1.0-05 or higher?

Ok. I have just checked adeos-ipipe-2.6.14-1.0-09 with 
CONFIG_PCI_MSI enabled, and the oneshot timer works fine.
The issue appears to be solved, thanks!

-- 
Romain Lenglet

