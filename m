Message-ID: <49D1FAC6.7060004@domain.hid>
Date: Tue, 31 Mar 2009 13:13:10 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <37f89760903310217o29fe3435j286d5fa10dd6aa82@domain.hid>	<49D1E4CA.3070102@domain.hid>	<37f89760903310314j4dc92dacnfadff82c2a3a3244@domain.hid>
	<37f89760903310359u438293feyc78802613fcaa3f@domain.hid>
In-Reply-To: <37f89760903310359u438293feyc78802613fcaa3f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Test xen_16500A.ko on different serial port
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marcel Soulot <msoulot@domain.hid>
Cc: xenomai@xenomai.org

Marcel Soulot schrieb:
> Hi sorry,
> 
> I was not very explicit in my last mail.
> 
> I try to test with the code from
> http://www.captain.at/xenomai-serial-port-example.php
> 
> but i got an error: "can't open rtser6" because i try to communicate with
> the port "ttyS6"

The enumeration of the Xenomai serial driver has nothing to do with the 
Linux counterpart. Try rtser0. Also note that you have to use the RT 
serial driver through RTDM calls and not Linux system calls.

-- 
Sebastian

