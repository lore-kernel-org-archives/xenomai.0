Subject: Re: [Xenomai-core] [PATCH] Xenomai configuration help for Linux 2.4
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4555C56B.3070205@domain.hid>
References: <4555C56B.3070205@domain.hid>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 17:34:12 +0100
Message-Id: <1163262853.5765.222.camel@domain.hid>
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Sat, 2006-11-11 at 13:43 +0100, Wolfgang Grandegger wrote:
> Hello,
> 
> the attached patch adds Xenomai configuration help for Linux 2.4:
> 
> 2006-11-11  Wolfgang Grandegger  <wg@domain.hid>
> 
> 	* scripts/prepare_kernel.sh, scripts/help_from_kconfig.pl:
> 	prepare_kernel.sh will now add help for Xenomai configuration
> 	parameters to the Configure.help file of 2.4 kernels. The help
> 	is extracted from Xenomai's Kconfig files using a perl script.
> 

Nice. Applied, thanks.

> Wolfgang.
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



