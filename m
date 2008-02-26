Message-ID: <47C3DE6A.8000809@domain.hid>
Date: Tue, 26 Feb 2008 10:39:54 +0100
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
References: <200802181213.29872.leo@domain.hid>	<47C2A484.4050006@domain.hid>	<200802251317.23736.leo@domain.hid>	<47C2B9E5.9090900@domain.hid>
	<18371.16698.219209.759123@domain.hid>
	<47C3CA72.1090100@domain.hid> <47C3D7A9.6090300@domain.hid>
In-Reply-To: <47C3D7A9.6090300@domain.hid>
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

Hi,

I hope you don't mind that we move this to the xenomai-core mailing list
with CC, since I fear the same questions will be raised again there at
some point.

Jan Kiszka wrote:
> Now the next question: You are providing i386 packages so far. Do you
> have plans for x86-64 as well?

The respective debian/control line currently is:

Architecture: amd64 arm i386 ia64 powerpc

At http://packages.qa.debian.org/x/xenomai.html , you can also see the
current status of the different architectures' build daemons (i.e., a
link to the logs).

bye,
  Roland

