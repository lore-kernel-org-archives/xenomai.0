Message-ID: <43982ADF.5090609@domain.hid>
Date: Thu, 08 Dec 2005 14:45:19 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: FW: [Xenomai-help] insmod: error inserting './xeno_posix.ko':
	-1	Unknown symbol in module
References: <000701c5fbf4$e400d920$0200000a@domain.hid>
In-Reply-To: <000701c5fbf4$e400d920$0200000a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Martijn Hazenberg (GOVA) kirjoitti:
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

Yikes. I'm no x86 expert, so can't help much there. You could try if the 
  APICs are causing the trouble by disabling local APIC altogether from 
kernel config.

-- hl

