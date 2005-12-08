From: "Martijn Hazenberg (GOVA)" <martijn@domain.hid>
Subject: FW: [Xenomai-help] insmod: error inserting './xeno_posix.ko': -1
	Unknown symbol in module
Date: Thu, 8 Dec 2005 12:42:54 +0100
Message-ID: <000201c5fbec$8732bc70$0200000a@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: xenomai@xenomai.org

Hi,

Thanks for all reactions Ulrich, Heikki and Gilles....

Ok i got it running. The loading of xeno_hal goes ok.
Lsmod gives the module correctly, I can also unload it and reload it. So no
problems there.

Loading the other modules still give the error -1 Unknown symbol. The dmesg
output is as described in the text output I attached earlier.

What module is used for what and when ? or where can I find that info ? Do
all of the modules have to be loaded ? or just a few ? or only 1 ? Or
depending on application ?

Is the order in which the modules are loaded defined or can they be loaded
at random order ?

Best regards,

Martijn


