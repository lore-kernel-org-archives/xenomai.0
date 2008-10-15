Message-ID: <48F5E050.4090106@domain.hid>
Date: Wed, 15 Oct 2008 14:21:36 +0200
From: Axel Beierlein <belatronix@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] implementing a new rtdm driver
Reply-To: belatronix@domain.hid
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

Hello,

i will implement my Serial ppc-PSC driver into the rtdm and
there are some hardwarespecific things that differ from the 
implementation of the 16550A.

Is it right that i have to add these things to the existing Serial 
Profile in rtserial.h?
What for is the device sub class Makro and how can i use it for a new 
profile? Perhaps #ifdef compiling?

Summarize:
What is the preferred way to implement an new serial Hardware into the 
existing RTDM Serial Device Profile?


At the moment i use Xeno 2.3.5 with an 2.4.25 Kernel on an MP5200B

Thanks

Axel



