Date: Thu, 5 Apr 2007 17:18:17 +0200 (CEST)
From: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Message-ID: <Pine.LNX.4.64.0704051650360.3108@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Xenomai-core] [ANNOUNCE] EtherCAT master on top of Xenomai/RTNet
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, rtnet-users@domain.hid

Hi all,

At <http://ethercatmaster.berlios.de/>, you can now get an _alpha_
version of a port of the EtherCAT Master Library (EML) to
Xenomai/RTNet through SVN
<https://developer.berlios.de/svn/?group_id=6087>.

The port allows you to create an <http://www.ethercat.org>EtherCAT
master running on top of Xenomai/RTNet.  It uses the raw socket
API from RTNet and the Xenomai POSIX skin.

ATM, it has only been tested on i386 with a realtek 8139 board [+].

The RTNet tree contains some example programs talking to an EtherCAT
evaluation board and some Beckhoff IO modules.

Special kudos to Jan Kiszka for keeping me under pressure into writing
this email ;-)
Feedback welcome (preferably on one of the EML mailinglists).

regards,

Klaas

[+] Contrary to the eCos port, endianness issues are not yet dealt
with properly.

