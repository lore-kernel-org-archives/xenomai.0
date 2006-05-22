Message-ID: <44722DCF.80208@domain.hid>
Date: Mon, 22 May 2006 23:31:59 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Xenomai v2.2-rc2. PowerPC 405GPr board does
	not start up
References: <446F852B.7090400@domain.hid>
	<200605221808.38756.niklaus.giger@domain.hid>
	<4471EB2C.5050402@domain.hid>
	<200605222208.15908.niklaus.giger@domain.hid>
In-Reply-To: <200605222208.15908.niklaus.giger@domain.hid>
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Hi
> 
> Am Montag, 22. Mai 2006 18:47 schrieb Philippe Gerum:
> 
>>Niklaus Giger wrote:
>>
>>>Am Montag, 22. Mai 2006 17:40 schrieb Philippe Gerum:
>>>
>>>>Niklaus Giger wrote:
>>>>
>>>>>Hi everybody
>>>>>
>>>>>Philippe Gerum wrote:
>>>>>
>>>>>>Here is the second release candidate for the v2.2 branch. Short log
>>>>>>follows:
>>>
>>><...>
>>>
>>>>Could you try building all skins as modules with only the nucleus
>>>>statically built into the kernel? I'd like to know whether the lockup
>>>>occurs when one of the skin attempts to initialize, or if the problem is
>>>>in the early Xenomai bootstrap. TIA,
>>>
>>>Okay. With the following .config XENOMAI settings my target starts up
>>>without any problem till the login:
>>
>>Does the board still boot with only the native skin enabled statically?
> 
> No. It does not.
> 
>>If it does not, wild guess: does the following patch prevent the lockup
>>in the latter case?
>>
>>--- pod.c~	2006-05-15 15:03:52.000000000 +0200
>>+++ pod.c	2006-05-22 18:45:21.000000000 +0200
>>@@ -509,12 +509,14 @@
>>
>>      xnarch_notify_ready();
>>
>>+#if 0
>>      err = xnpod_reset_timer();
>>
>>      if (err) {
>>          xnpod_shutdown(XNPOD_FATAL_EXIT);
>>          return err;
>>      }
>>+#endif
>>
>>      return 0;
>>  }
> 
> Excellent wild guess! With this patch I get my target up and running. First 
> test is with only the native skin worked. Then I restore my original .config, 
> touched it and rebuilt. Still boots without any problems.
>

Ok, relatively good news. Now I need to find why starting the timer 
early breaks the system...

> Thanks a lot for your help.
> 
> Best regards
> 


-- 

Philippe.

