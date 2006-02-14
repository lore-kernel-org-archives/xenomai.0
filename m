Message-ID: <43F21556.8080700@domain.hid>
Date: Tue, 14 Feb 2006 18:37:26 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Kconfig inconsistencies
References: <43F08392.3000403@domain.hid> <43F20E47.1070908@domain.hid>
	<43F2131F.4010508@domain.hid>
In-Reply-To: <43F2131F.4010508@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>>I haven't worked out any patch for those issues. Actually, I only wanted
>>>to put this patch forward when stumbling over the other:
>>>
>>>--- ksrc/skins/native/Kconfig   (revision 564)
>>>+++ ksrc/skins/native/Kconfig   (working copy)
>>>@@ -127,7 +127,6 @@
>>>
>>> config XENO_OPT_NATIVE_INTR
>>>     bool "Interrupts"
>>>-    default y
>>>     help
>>>
>>>     This option provides a simple API to deal with interrupts,
>>>
>>>Rationale: the /default/ way of handling IRQs should be via RTDM-based
>>>drivers. Only users who know what they are doing should leave this path
>>>and will have to switch on this feature explicitly. If this view can be
>>>commonly accepted, I will add some lines to the feature's help text as
>>>well.
>>>
>>
>>Agreed.
>>
> 
> 
> Then apply this one, please. I noticed that 2.4 does not know default
> values for bool options, correct?
>

Correct.

> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: ksrc/skins/native/Kconfig
> ===================================================================
> --- ksrc/skins/native/Kconfig	(revision 568)
> +++ ksrc/skins/native/Kconfig	(working copy)
> @@ -128,11 +128,11 @@
>  
>  config XENO_OPT_NATIVE_INTR
>  	bool "Interrupts"
> -	default y
>  	help
>  	
>  	This option provides a simple API to deal with interrupts,
> -	both in kernel and user-space contexts. Registry support is
> -	required.
> +	both in kernel and user-space contexts. Note that the preferred
> +	way of implementing generic drivers usable across all Xenomai
> +	interfaces is defined by the Real-Time Driver Model (RTDM).
>  
>  endif


-- 

Philippe.

