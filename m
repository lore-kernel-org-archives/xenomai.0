From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17304.3484.102658.597744@domain.hid>
Date: Thu, 8 Dec 2005 11:40:28 +0100
Subject: Re: [Xenomai-help] insmod: error inserting './xeno_posix.ko': -1
	Unknown symbol in module
In-Reply-To: <002301c5fbde$7534e740$0200000a@domain.hid>
References: <002301c5fbde$7534e740$0200000a@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Martijn Hazenberg (GOVA)" <martijn@domain.hid>
Cc: xenomai@xenomai.org

Martijn Hazenberg (GOVA) wrote:
 > (...)
 > insmod: error inserting '/usr/realtime/modules/xeno_hal.ko': -1 No such
 > device

Heikki is right: your first problem is why insmoding xeno_hal fails.

Maybe your machine has a local APIC, but it is disabled by BIOS. If this
is your problem, you should try and add "lapic" to your kernel boot
parameters. For more details, you should read the last two questions
of the "TROUBLESHOOTING" file.

-- 


					    Gilles Chanteperdrix.

