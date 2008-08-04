Message-ID: <48971838.40202@domain.hid>
Date: Mon, 04 Aug 2008 16:54:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20080804144936.45B241C066@domain.hid>
In-Reply-To: <20080804144936.45B241C066@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai version 2.4.4 with linux kernel
 2.6.25.11 under ubuntu problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: stefano.franzoni@domain.hid
Cc: xenomai@xenomai.org

stefano.franzoni@domain.hid wrote:
> - I have also included in the kernel, not as module, the
> ATA/ATAPI/MFM/RLL Support -> Enhanced IDE/MFM
> 
> Any suggestions?

You also need to enable the actual IDE controller used by your computer
(the Enhanced IDE/MFM setting is just an option that will make the IDE
controllers visible, but as such it does not cause any
controller-specific code to be compiled). If in doubt, enable all IDE
controllers, boot, read the logs, then only keep the controller which
you really use.

Note that if you have a sufficiently recent hardware, your IDE
controller will in fact be a SATA controller, and your root partition
will become /dev/sda3, this requires a few changes in /etc/fstab that
are unfortunately incompatible with a previous installation.

-- 
                                                 Gilles.

