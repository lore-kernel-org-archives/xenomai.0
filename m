Message-ID: <446321DF.9000603@domain.hid>
Date: Thu, 11 May 2006 13:37:03 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Kernel panic on rmmod xeno_vxworks
References: <200605102227.09892.niklaus.giger@domain.hid>
	<44630BF3.5010203@domain.hid>
In-Reply-To: <44630BF3.5010203@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Niklaus Giger wrote:
> 
>> Hi
>>
>> I compiled and started my test with a recent xenomai/trunk (revision 
>> 1068).
>> I booted into single user mode, did a "modprobe xeno_vxworks" (no 
>> problem) and then a "rmmod xeno_vxworks" and got as response on my 
>> PowerBook only
>> "Kernel panic: -not syncing: Aiee, killing interrupt handler".
>>
> 
> It's the VxWorks tick handler that's still called after the module is 
> unloaded. Oops, rainy day indeed. I will send a fix for that. Thanks.

Commit #1077 fixes that. Thanks for the report.

-- 

Philippe.

