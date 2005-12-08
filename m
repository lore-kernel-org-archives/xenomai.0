From: "Martijn Hazenberg (GOVA)" <martijn@domain.hid>
Subject: RE: FW: [Xenomai-help] insmod: error inserting './xeno_posix.ko':
	-1	Unknown symbol in module
Date: Thu, 8 Dec 2005 13:42:45 +0100
Message-ID: <000701c5fbf4$e400d920$0200000a@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <439826C4.5010009@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Heikki Lindholm' <holindho@domain.hid>
Cc: xenomai@xenomai.org

Ok...

Installing the modules in this order :=20

xeno_hal
xeno_nucleus
xeno_native

lsmod gives all three loaded...

Running the normal latency with ./run

crashes the pc.
Restarting and running the switch test, also crashes the pc, leaving =
nothing
else then just to restart....

Slowly but certain we're getting somewhere...

Best regards,

Martijn



