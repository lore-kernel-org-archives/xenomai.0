Message-ID: <4CC2ECC1.5080207@domain.hid>
Date: Sat, 23 Oct 2010 16:10:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1281709057.650414331@domain.hid> <4C65583D.3030800@domain.hid>
	<1281960823.030215299@domain.hid> <4C692FC3.5040802@domain.hid>
	<1283531433.789315367@domain.hid>
	<1283590285.1709.2153.camel@domain.hid>
	<1287134519.029617765@domain.hid>
	<1287143691.028416668@domain.hid> <4CB85C64.9040307@domain.hid>
	<1287496324.10921156@domain.hid> <4CBDF92F.20403@domain.hid>
	<1287832106.517512323@domain.hid> <4CC2C361.5020608@domain.hid>
	<1287832939.719617755@domain.hid> <4CC2C8AB.70708@domain.hid>
	<1287841513.64613295@domain.hid> <4CC2E86F.5060304@domain.hid>
	<1287842205.0925650@domain.hid>
In-Reply-To: <1287842205.0925650@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Very high latencies under stress testing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: edward.robbins@domain.hid
Cc: xenomai@xenomai.org

edward.robbins@domain.hid wrote:
> Oh no...
> 
> dmesg | grep SMI
> 
> CPU0: Thermal monitoring handled by SMI CPU1: Thermal monitoring
> handled by SMI
> 
> So I guess that didn't work? I have used the 'Globally disable SMIs
> option' at kernel config time.... there is an option in  the BIOS to
> disable SMI but I was having problems with it... will investigate.
> Any other options?

See:
http://www.xenomai.org/index.php/Configuring_x86_kernels#In_case_of_high_latencies

Note that if SMIs are involved in regulating temperature on your system,
disabling them may cause your CPU to overheat. So, when running dohell,
you should check the CPU temperature.

-- 
                                                                Gilles.

