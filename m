MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18450.13958.813644.217977@domain.hid>
Date: Fri, 25 Apr 2008 21:52:38 +0200
In-Reply-To: <251241.46467.qm@domain.hid>
References: <251241.46467.qm@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] xenomai installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: George Pitich <george_pitich@domain.hid>
Cc: xenomai@xenomai.org

George Pitich wrote:
 > I'm pretty much sure this was answered before. If this
 > is the case could you please refer me to the post?
 > 
 > I'm getting a bit frustrated in my attempts to install
 > xenomai. I'm following the readme.install from
 > xenomai-2.4.3 but to no avail. When I execute make
 > menuconfig after patching the kernel with
 > prepare-kernel.sh, Real-time sub-system presents me
 > with:

Please do the following in Linux kernel configuration:

 > 
 > -- NOTE: Xenomai conflicts with PC speaker support.   
 > --- (menu Device Drivers/Input device
 > support/Miscellaneous devices)

disable PC speaker support (you will find it in the Device Drivers/Input
device support/Miscellaneous devices menu).

 > --- NOTE: Xenomai needs either X86_LOCAL_APIC enabled
 > or HPET_TIMER disabled.               &#9474; &#9474;
 > --- (menu Processor type and features)).

Enable Local APIC option (if your box has a local APIC, but anything
recent probably has an APIC), or disable HPET timer option (you will find
these options in the Processor type and features menu).

-- 


					    Gilles.

