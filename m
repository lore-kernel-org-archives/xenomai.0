Message-ID: <47C43124.2010804@domain.hid>
Date: Tue, 26 Feb 2008 16:32:52 +0100
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
References: <47C3CD06.6030006@domain.hid>	
	<2ff1a98a0802260226m167bdb45u930ee7d8c8caaa95@domain.hid>	
	<47C3ED42.5070307@domain.hid>
	<2ff1a98a0802260520u41f84ad8m1b674b952678ba2f@domain.hid>
In-Reply-To: <2ff1a98a0802260520u41f84ad8m1b674b952678ba2f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai in Debian
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

Gilles Chanteperdrix wrote:
>>  The binary package list changed to adjust to Debian conventions:
>>
>>  xenomai-runtime
>>  linux-patch-xenomai
>>  libxenomai1
>>  libxenomai-dev
>>  xenomai-doc
> 
> So, I need to install all these packages, then continue at make-kpkg ?

Similar to the Wiki description before. You certainly don't _need_
xenomai-doc for make-kpkg. Some of the other packages can be missing,
will need to check later. But I'm sure you already know it better:
xenomai-runtime is all the executables (except xeno-config),
libxenomai-dev is the installed header files, xeno-config and static
libs, libxenomai1 is the shared lib.

bye,
  Roland

