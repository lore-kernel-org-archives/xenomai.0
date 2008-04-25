Date: Fri, 25 Apr 2008 11:37:30 -0700 (PDT)
From: George Pitich <george_pitich@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <251241.46467.qm@domain.hid>
Subject: [Xenomai-help] xenomai installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I'm pretty much sure this was answered before. If this
is the case could you please refer me to the post?

I'm getting a bit frustrated in my attempts to install
xenomai. I'm following the readme.install from
xenomai-2.4.3 but to no avail. When I execute make
menuconfig after patching the kernel with
prepare-kernel.sh, Real-time sub-system presents me
with:

-- NOTE: Xenomai conflicts with PC speaker support.   
--- (menu Device Drivers/Input device
support/Miscellaneous devices)
--- NOTE: Xenomai needs either X86_LOCAL_APIC enabled
or HPET_TIMER disabled.               &#9474; &#9474;
--- (menu Processor type and features)).

None of this options is selectable nor configurable.

By looking into .config, I can see only one xeno
option CONFIG_XENO_GENERIC_STACKPOOL=y. After
compiling the kernel and booting it, xenomai build
looks incomplete. I can't find xenomai LKMs and
therefore can't run testsuite.

I hope it is not because of AMD Athlon cpu on the box.
Many Thanks.


      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ

