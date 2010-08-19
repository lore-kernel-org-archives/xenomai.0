Message-ID: <4C6CFD24.1080004@domain.hid>
Date: Thu, 19 Aug 2010 11:45:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=dpYJNx+UzbjLy6Jpky2sscccUoVS5VZCAKMUv@domain.hid>	<4C6CF5BF.3060405@domain.hid>
	<AANLkTi=MKjwGhRXVGQtPQML5dyO6wUB0edWngncZVqjP@mail.gmail.com>
In-Reply-To: <AANLkTi=MKjwGhRXVGQtPQML5dyO6wUB0edWngncZVqjP@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] using floating point in rtdm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ramon costa <ramoncostacastello@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

ramon costa wrote:
> Hi,
> 
> I'm trying to port some old stuff from RTLinuxfree.  As a first step I would
> like to recompile
> and check everything. Latter I will try to modify the code structure to  fit
> xenomai structure.
> 
> 
> - let the kernel compile your module as is, this will generated
>> "soft-float" code, which means that the operations will be done in
>> software. Your module will contain undefined references to functions
>> actually implemented in libgcc. So, you will have to extract the needed
>> .o from libgcc.a and put them in your module.
>>
> 
> As this is only "temporary" this is the best option. I think my old
> RTLinuxfree
> code does something similar.
> 
> How can I do this in the Xenomai framework ?
> 
> Does RTDM task store the floating point context during task switching ?

Also note that if you need libm functions, you will need a soft-float
kernel-mode libm.

-- 
					    Gilles.

