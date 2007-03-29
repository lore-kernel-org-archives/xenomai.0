From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17932.2766.324689.52172@domain.hid>
Date: Thu, 29 Mar 2007 20:51:58 +0200
Subject: Re: [Xenomai-help] Re: Latencies due to RT-Socket-CAN register
	accesses
In-Reply-To: <460BECFD.2030003@domain.hid>
References: <45F68258.5040603@domain.hid> <45F6A44A.2030000@domain.hid>
	<45F6A73C.8030301@domain.hid> <45F6AA11.40707@domain.hid>
	<bc4264770703281005v17fc4802v53728cda11cb6b17@domain.hid>
	<460AB8FF.5060904@domain.hid> <460B21C0.7090200@domain.hid>
	<460B7FDF.8030100@domain.hid> <460BECFD.2030003@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

Roland Tollenaar wrote:
 > Hi Wolfgang,
 > 
 > Typically without load the average latecny is 30 us and 20 us min 
 > latency. Yes I am using the latency program of the test suit.
 > 
 > Where do I check to find the latency "killer" settings? The 
 > powermanagement and all that s switched of. As is the PC speaker. What 
 > else can I look at?

Latency killers are detailed in the TROUBLESHOOTING guide.
Not all the power management is bad, ACPI is Ok, and is even recommended
except for the ACPI processor module.
Select a processor with a tsc and enable the local APIC if your hardware
supports it.
Make sure Xenomai debug features are disabled.

-- 


					    Gilles Chanteperdrix.

