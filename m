Subject: Re: Interrupt timeout
References: <VI1PR05MB5917D6B0922458527599EDE1F6ED0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <CALLqZ8RSqv_OZTRApV+n+3zmgjz1KcLRBLmd+vLWE6MRYaS9ag@mail.gmail.com>
 <VI1PR05MB591716533325E3DB1EEBD573F6ED0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <2e8126ff-7b0d-e114-568f-1e38c530f895@siemens.com>
 <VI1PR05MB59178FFEA9E3D2E2E9D62D2FF6ED0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <8fcf4459-fb45-e80d-7158-cd664da30545@siemens.com>
 <VI1PR05MB591787E77D7AC62A5E4231E1F6ED0@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <34e9e31f-82c0-a0ed-df4a-e5efd3014397@siemens.com>
Date: Tue, 25 Feb 2020 19:17:24 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB591787E77D7AC62A5E4231E1F6ED0@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Lange Norbert <norbert.lange@andritz.com>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 25.02.20 18:53, Lange Norbert wrote:
>> isolcpus should work. If not, we need to debug and fix.
> 
> See it does, atleast I did not run into problems yet.
> 
> I added "irqaffinity=0 isolcpus=1-3" to the cmdline, which binds the driver irqs to core 0,
> and prevents automatic scheduling to the remaining cpus.
> 
> I am a bit unclear how the Xenomai-side is supposed to work.
> 
> Setting "xenomai.supported_cpus=0xe" will strictly deny running anything there,
> My process did bail out with
> [   27.726681] [Xenomai] thread rtgate[793] switched to non-rt CPU0, aborted.
> 
> That means I either have to
> echo 0xfffffffe > /proc/xenomai/affinity
> 
> or set affinity manually (early enough) each time.
> Whatever I do, I guess xenomais "printf" thread will always have to run
> on a cobalt-enabled thread, even if its just using linux sycalls?
> 
> Why is there no xenomai.affinity kernel commandline parameter (or alternatively an xenomai.isolcpus)?
> 

xenomai.supported_cpus=0xe should work for your case. Processes starting 
RT threads without forcing them to CPU 0 should find them auto-migrated 
to a supported RT core. Well, that's without isolcpus. You probably need 
to start them right away on one of those isolated cores.

> 
>>
>> Less convenient alternative: manually tuning /proc/irq/*/smp_affinity or
>> instructing irqbalanced to keep some cores free. cgroups with CPU
>> affinities can help to keep tasks away.
> 
> Yes, systemd-system.conf has an CPUAffinity option. The Linux-side seems solved
> with the two kernel parameters anyways.

Perfect.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

