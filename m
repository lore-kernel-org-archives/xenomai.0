Message-ID: <47C3EBB0.4090001@domain.hid>
Date: Tue, 26 Feb 2008 11:36:32 +0100
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
References: <200802181213.29872.leo@domain.hid>	<47C2A484.4050006@domain.hid>	<200802251317.23736.leo@domain.hid>	<47C2B9E5.9090900@domain.hid>	<18371.16698.219209.759123@domain.hid>	<47C3CA72.1090100@domain.hid>
	<47C3D7A9.6090300@domain.hid> <47C3DE6A.8000809@domain.hid>
	<47C3E312.4090003@domain.hid>
In-Reply-To: <47C3E312.4090003@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Debian package
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Paul Corner <paul_c@domain.hid>, xenomai@xenomai.org, Leopold Palomo-Avellaneda <leo@domain.hid>

Jan Kiszka wrote:
> Ah, I see... that powerpc already failed. :->

Of course... The DEBIAN/control "hackery" is operating on an
architecture independent package (linux-patch-xenomai), while only
building the architecture dependent packages on the build daemons...

Will be fixed in next revision... Thanks for the note!

Roland

