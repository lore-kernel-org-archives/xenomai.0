Message-ID: <457EC0CE.5040307@domain.hid>
Date: Tue, 12 Dec 2006 15:46:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] consolidate testsuite installation
References: <457BDF99.1020405@domain.hid>
	<1165778549.8255.17.camel@domain.hid>		<457CA36C.5060805@domain.hid>
	<1165828053.5025.8.camel@domain.hid> <457D23CA.0@domain.hid>
	<457E6A01.4090500@domain.hid> <457EA179.5070606@domain.hid>
	<457EAACF.3060307@domain.hid> <457EAD7F.2040902@domain.hid>
In-Reply-To: <457EAD7F.2040902@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>>At some point in time:
>>https://mail.gna.org/public/xenomai-help/2006-09/msg00181.html
>>
>>I started to use exec_prefix and prefix for separating the binaries,
>>libraries and script that need to be installed on the target from the
>>include files, documentation and xeno-config script that need to be
>>installed on the host.
>>
> 
> 
> OK, appears reasonable, though I cannot asses if it's a standard usage.

Do not know either if it is standard, but it may be useful to some users.

> 
> What do you suggest as a replacement for $(pkgdatadir) then?
> $(exec_prefix)/share/xenomai? Or where to put the testsuite start scripts?

I am Ok with anything under $(exec_prefix)...

-- 
                                                 Gilles Chanteperdrix

