Message-ID: <48AD78C9.1050405@domain.hid>
Date: Thu, 21 Aug 2008 16:16:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF8AF7B8AE.31B3D7A5-ONC12574AC.004DF0CC-C12574AC.004E0846@domain.hid>
In-Reply-To: <OF8AF7B8AE.31B3D7A5-ONC12574AC.004DF0CC-C12574AC.004E0846@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] problems patching the kernel 2.6.25.11 with
 xenomai 2.4.4 under ubuntu
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: juergen.lanner@domain.hid
Cc: xenomai@xenomai.org

juergen.lanner@domain.hid wrote:
> Shouldn't there be all the xenomai specific settings there?
> What went wrong?
> How do they usually come into the .config file?

In your report I read:
Xenomai conflicts with PC speaker support.
(menu Device Drivers/Input device support/Miscellaneous devices)
Xenomai needs either X86_LOCAL_APIC enabled or HPET_TIMER
disabled.(menu Processor type and features)

So, what do you think ?

-- 
                                                 Gilles.

