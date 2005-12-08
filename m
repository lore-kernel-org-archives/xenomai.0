From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17304.11485.9921.915682@domain.hid>
Date: Thu, 8 Dec 2005 13:53:49 +0100
Subject: RE: FW: [Xenomai-help] insmod: error inserting './xeno_posix.ko':
	-1	Unknown symbol in module
In-Reply-To: <000701c5fbf4$e400d920$0200000a@domain.hid>
References: <439826C4.5010009@domain.hid>
	<000701c5fbf4$e400d920$0200000a@domain.hid>
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
 > Ok...
 > 
 > Installing the modules in this order : 
 > 
 > xeno_hal
 > xeno_nucleus
 > xeno_native
 > 
 > lsmod gives all three loaded...
 > 
 > Running the normal latency with ./run
 > 
 > crashes the pc.
 > Restarting and running the switch test, also crashes the pc, leaving nothing
 > else then just to restart....

It is hard to know why your system crashes. This may be due to some
kernel configuration options. According to your boot log, you enabled the
"processor" option in ACPI (CONFIG_ACPI_PROCESSOR), you should disable
it (you will have to disable thermal zone too). As mentioned by Heikki,
you may try disabling APIC too.

If you get an error message on the console (you have run latency in
text-mode for that), it will be of great help.

-- 


					    Gilles Chanteperdrix.

