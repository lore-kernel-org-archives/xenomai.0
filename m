MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17227.32989.726582.610079@domain.hid>
Date: Tue, 11 Oct 2005 11:07:41 +0200
Subject: Re: [Xenomai-core] Generated docs
In-Reply-To: <434B7DFD.4050806@domain.hid>
References: <434B6BC6.4030401@domain.hid>
	<17227.27763.201941.114412@domain.hid>
	<434B6FA4.80309@domain.hid>
	<17227.29206.223750.761504@domain.hid>
	<434B7422.6040603@domain.hid>
	<17227.30216.496851.780843@domain.hid>
	<434B7928.1080201@domain.hid>
	<17227.31188.962652.600870@domain.hid>
	<434B7DFD.4050806@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
 > Gilles Chanteperdrix kirjoitti:
 > > It means looking at the doc, if there are no anomalies, like warnings,
 > > parsing errors of doxygen, or typos in the text. Usually takes an hour
 > > or two. I admit I am not fast, but I think it would take some time for
 > > Philippe to do that too.
 > 
 > Okay. Although, I would be stupid enough to trust that if it generates 
 > nicely for you it does so for Philippe, too, and not take the usual 
 > metaphysical factors into account. Assuming that some coordination is 
 > done to ensure that similar configurations are used - not too hard if 
 > both use the same distro, for example.

Definitely not enough: doxygen need some external programs, which
presence is detected by the configure script, but in their absence the
same documentation is not generated. The docbook generation use some
tools which do not even exist as Debian packages.

-- 


					    Gilles Chanteperdrix.

