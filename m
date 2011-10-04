MIME-Version: 1.0
Sender: patrickdepinguin@domain.hid
Date: Tue, 4 Oct 2011 11:49:54 +0200
Message-ID: <CAAXf6LWD9VfTLz-o9My1CM1A=MfaZt_EKoXMYrMwRPopfVE5Tg@domain.hid>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] xenomai-forge: enable-smp useful?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid, Ronny Meeus <ronny.meeus@domain.hid>

Hi,

The original Xenomai userland had to be configured explicitly with
--enable-smp if the kernel was SMP capable. The xenomai-forge
configure script still accepts this parameter.

Are we correctly assuming that this flag is no longer needed for xenomai-forge?

Thanks,
Thomas

