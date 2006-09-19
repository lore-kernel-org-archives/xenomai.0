Message-ID: <451068AD.6080000@domain.hid>
Date: Tue, 19 Sep 2006 17:01:17 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai v2.2.3
References: <1158564530.5020.5.camel@domain.hid> <450F1686.3010304@domain.hid>
In-Reply-To: <450F1686.3010304@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Jeff Webb wrote:
> Philippe Gerum wrote:
>> Here is the third maintenance release for the v2.2.x branch.
>> ...
> 
> This release works fine on my 2.6 kernel x86 machine, with the exception 
> of the FPU problems noted elsewhere.
> 
> I have the following problems with my 2.4 kernel x86 machine:
>  * The latency and switchtest test programs yield segmentation faults.
>  * My own user-space test programs seg fault.
> 
> Things that work:
>  * The kernel boots and runs fine.
>  * xeno_native, _posix, _rtai all insert and remove without problems.
>  * Some simple kernel module test programs work fine.
> 
> I am using the same config as I was for 2.2.2 (which worked fine), but I 
> am running a slightly newer kernel version (2.4.33.3 as opposed to 2.4.32).

I was able to build a working xenomai-2.2.3 by using linux-2.4.32 and adeos-ipipe-2.4.32-i386-1.2-07.patch.  The latency and switchtest programs seem to work now.  My problematic build used linux-2.4.33.3 and the adeos-ipipe-2.4.33-i386-1.3-00.patch.  I used the same kernel config for both builds.  

So, does this mean the problem is with the ipipe patch?

This machine is an AMD Athlon(tm) XP 3200+, gcc version 3.3.2, Fedora Core 1.

-Jeff
 

