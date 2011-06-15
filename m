Message-ID: <4DF837EF.6010207@domain.hid>
Date: Tue, 14 Jun 2011 21:41:19 -0700
From: David Wiebe <dwiebe2@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Beagleboard xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

Thanks for reading this. I checked out the beagleboard version of 
xenomai. I tried make menuconfig and got the following

david@domain.hid$ make 
menuconfig
scripts/kconfig/mconf arch/arm/Kconfig
init/Kconfig:1319: can't open file "arch/arm/xenomai/Kconfig"
make[1]: *** [menuconfig] Error 1
make: *** [menuconfig] Error 2

I know that arch/arm/xenomai/Kconfig is a link to a file but its broken. 
How now? Where should the link be pointing?

Thanks

David



