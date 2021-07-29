Subject: Re: xenomai warning after upgrade to linux 5.4.115
References: <BN9PR11MB52270515FDDDB8D6AFD37F6FF2EB9@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c79cae1e-d905-53eb-4f23-6f9d57d2d34f@siemens.com>
Date: Thu, 29 Jul 2021 10:02:11 +0200
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB52270515FDDDB8D6AFD37F6FF2EB9@BN9PR11MB5227.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 29.07.21 08:43, Chen, Hongzhan wrote:
> After we upgraded our linux to 5.4.115 from 5.4.76 and rebased IPIPE patchset for xenomai 3.1.X,  there is xenomai warning
> printed as in attached xenomai_warning_on_linux5.4.115 on some specific boards according to our validation.

>From a first inspection: Linux considers its interrupts to be off around

xenomai_init
  xntimer_grab_hardware
    ipipe_timer_start
      smp_call_function_single

But that should not be the case. The call path is valid and used for a
long time. The issue should come from somewhere else.

You you try to debug where interrupts are turned off from Linux
perspective? Compare that to boot ups where Linux does not complain.

> But I cannot reproduce the issue on same type of board like Maxtang that I have.  In addition,
> on one specific board, we found that there is similar warning happened in smp_call_function_single  when ACPI init
> ahead of warning happened in xenomai init as in attached ACPI_warning_and_xenomai_warning_on_linux5.4.115.
> When we set acpi=off in cmdline for all problematic boards , warning totally disappear.  Since I cannot get the problematic board
> to further debug, would you mind help check attached logs and kernel config and find the root cause out?
> Thanks for your help in advance.
> 

Does that other case only occur when CONFIG_IPIPE is enabled? If it also
happens with plain Linux, we may see a mainline issue. Or firmware bugs.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

