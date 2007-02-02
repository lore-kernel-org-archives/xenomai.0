Message-ID: <45C30B90.5080302@domain.hid>
Date: Fri, 02 Feb 2007 10:59:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt_task_create() hangs ?
References: <45B75FFB.6030205@domain.hid> <45C1E625.1010600@domain.hid>
	<45C1EA10.9060109@domain.hid> <45C1F351.6080109@domain.hid>
In-Reply-To: <45C1F351.6080109@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Scholz <steven.scholz@domain.hid>
Cc: xenomai@xenomai.org

Steven Scholz wrote:
> Hi Gilles,
> 
> 
>>>I now tested Gille's brand new adeos-ipipe-2.6.19-arm-1.6-01.patch. The
>>>above problems disapeared. I even do see a "Xenomai: POSIX: destroyed
>>>thread" now.
>>>
>>>So is this a known bug of ipipe-1.5 vs ipipe-1.6?
>>>Or does anyone remember a bug like that?
>>
>>I do not think there is such a known bug. There were some recent fixes
>>in the native skin, but as far as I remember they were for anonymous
>>objects. In any case, as Philippe already told you, it is hard to say
>>anything without seeing any code. 
> 
> Did he? I never saw that mail. :-(
> However I attach the file that hangs when starting it for the second time.
> 
> PLEASE NOTE: I just found that the programm runs fine again and again even
> under 2.6.14 iff I deselect CONFIG_XENO_HW_FPU. With CONFIG_XENO_HW_FPU=y it
> will hang...
> 
> So I am now suspecting that it would hang with your new
> adeos-ipipe-2.6.19-arm-1.6-01.patch as well...
> Problem is: I can only compile your patch with FPU disabled! Otehrwise he
> complains about a missing fp_init() !!!

I have tried several compilations with Xenomai FPU and kernel FPU
emulation enabled, they all compile fine here. Could you send me your
.config ?

-- 
                                                 Gilles Chanteperdrix

