From: Max Vasin <max.vasin@domain.hid>
Date: Fri, 22 Jan 2010 10:38:08 +0300
Message-ID: <hjbkl0$5lb$1@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: news <news@domain.hid>
Subject: [Xenomai-help] Vortex86SX and TSC
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

I'm trying to port my application from the DiamonSystems Hercules II SBC 
(with VIA C3 CPU) to the DiamonSystems Helios SBC (with Vortex86SX CPU). 
  The application contains one RT task running at 50 kHz and three RT 
tasks running at 2kHz. One iteration of the first task takes 15 us to 
complete. Measured latencies on the Vortex86 CPU are about 40us with max 
56us, on the VIA C3 CPU are about 7us. Vortex86SX is 486 compatible, so 
Xenomai is built without TSC support, but CPUID claims the the it 
supports TSC. Is there a way to get kernel part of Xenomai to use TSC?

Thanks in adavance.

--
WBR,
Max Vasin.


