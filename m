Message-ID: <47DA7CCD.40901@domain.hid>
Date: Fri, 14 Mar 2008 14:25:33 +0100
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Moving from 2.6.14(ppc) to 2.6.20(powerpc): illicit
 calls detected by ipipe
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Hello,

I am trying to move from 2.6.14(ppc) to 2.6.20(powerpc). On ppc I am 
using Xenomai 2.4.1 and I-Pipe version 1.5-03, on powerpc I am using 
Xenomai 2.4.1, I-Pipe version 1.7-12.
Most of the system is working, but I am having some problems with one 
device driver. This is a "standard" Linux driver, that I converted into 
a Xenomai driver. This driver does a very limited initialization, the 
main init is done when the device is opened and after some IOCTL calls.

The problem is that I am getting "Detected illicit call from domain 
'Xenomai' into a service reserved for domain 'Linux' and below." 
messages from Adeos, which I did not get when using 2.6.14. The code I 
use is identical, except for some small areas where the API kernel 
changed between 2.6.14 and 2.6.20. Has there been a change between the 
versions of Adeos or Xenomai which could cause this change in behavior?
(BTW: this message is generated when the option IPIPE_DEBUG_CONTEXT is 
on, when this option is off I get a kernel Oops in kernel/ipipe/core.c:210.

The affected calls are calls like kmalloc and kfree, but also calls like 
check_mem_region, which uses kmem_cache_zalloc inside the function. 
Normally these should not be used inside a RT application, but this is 
the startup phase of the application and there are no RT restraints at 
this point.

Kind regards,
    Johan Borkhuis

-- 
Johan Borkhuis                                  Dutch Space BV
email:        j.borkhuis@domain.hid          Newtonweg 1
phone:        071-5245788                       Leiden
fax:          071-5245499                       The Netherlands


