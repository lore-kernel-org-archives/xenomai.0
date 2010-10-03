Message-ID: <4CA8D713.8090900@domain.hid>
Date: Sun, 03 Oct 2010 21:18:43 +0200
From: Javier Herrero <jherrero@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Problem with dm9000 and
	adeos-ipipe-2.6.34-blackfin-1.14-02.patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

  Hello,

I'm trying adeos on a Blackfin BF532 board with a DM9000 ethernet 
interface. If ethernet is down (cable disconnected) the system boots and 
works OK, but as soon as the ethernet cable is plugged, the system 
apparently hangs. After several seconds, a message  dm9000 dm9000.0: 
status check fail: 226 appears.

I've read a previous post about problems with dm9000 and an ARM 
processor, 
https://mail.gna.org/public/xenomai-help/2010-03/msg00147.html but it 
seems that there was not a response.

Thank you very much. Best regards,

Javier

-- 
------------------------------------------------------------------------
Javier Herrero                            EMAIL: jherrero@domain.hid
Chief Technology Officer
HV Sistemas S.L.                          PHONE:         +34 949 336 806
Los Charcones, 17                         FAX:           +34 949 336 792
19170 El Casar - Guadalajara - Spain      WEB: http://www.hvsistemas.com


