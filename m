Message-ID: <4358FE53.4010505@domain.hid>
Date: Fri, 21 Oct 2005 16:42:27 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Adeos for the Blackfin architecture
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org


I have uploaded the initial version of the Adeos real-time enabler for the 
Blackfin architecture:
http://download.gna.org/adeos/patches/v2.6/adeos/bfin/adeos-ipipe-uc-2.6.12-bfin-1.0-00.patch

It is based on the 2.6.12 kernel found in the uClinux-2005R3 distribution, and 
tested on a BF533. Functionally, it is complete for a uniprocessor 
configuration, which means that porting the Xenomai RTOS over it is now 
possible. The Adeos support for the Blackfin will likely evolve in a positive 
way as a result of being stressed by a client RTOS.

Special thanks to the Analog Devices people (http://www.analog.com/) who kindly 
provided evaluation boards and support for this port to happen.

-- 

Philippe.

