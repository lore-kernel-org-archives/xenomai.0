Message-ID: <4D3871F1.6020306@domain.hid>
Date: Thu, 20 Jan 2011 18:33:37 +0100
From: Cagnulein <cagnulein@domain.hid>
MIME-Version: 1.0
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>	<alpine.DEB.1.10.1101200922440.1211@domain.hid>	<4D384CC9.2040303@domain.hid>	<alpine.DEB.1.10.1101201702340.1990@domain.hid>
	<4D386922.5080807@domain.hid>
In-Reply-To: <4D386922.5080807@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] gpio
Reply-To: cagnulein@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I ported a linux environment module implementing gpio handling to
Xenomai environment.
Under linux i was able to see /dev/gpio1 and execute echo 1>  /dev/gpio1
command via bash shell to set the gpio output state.
Now, under Xenomai, with the RTDM driver developed and loaded I am not
able to get the gpio1 device.
Could you help me ?
Thanks
Roberto Viola


