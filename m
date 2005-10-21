Message-ID: <43592E98.4080202@domain.hid>
Date: Fri, 21 Oct 2005 20:08:24 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Adeos then Xenomai over Blackfin
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


FYI, I have uploaded the initial release of Adeos for the Blackfin architecture:
http://download.gna.org/adeos/patches/v2.6/adeos/bfin/adeos-ipipe-uc-2.6.12-bfin-1.0-00.patch

It is based on the 2.6.12 kernel found in the uClinux-2005R3 distribution, and 
tested on a BF533 eval board. Functionally, it is complete for a uniprocessor 
configuration, which means that porting Xenomai over it is now possible.

Special thanks to the Analog Devices people (http://www.analog.com/) who kindly 
provided evaluation boards and support for this Adeos port to happen.

-- 

Philippe.

