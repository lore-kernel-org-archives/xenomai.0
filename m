Message-ID: <54C0E277.8080406@siemens.com>
Date: Thu, 22 Jan 2015 12:43:51 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <1537147.Wm9AbiuW5D@soho> <5878976.hoeVIdWPhU@soho>
 <20150122104813.GA23461@hermes.click-hack.org> <1724720.ZWD9XnFxZe@soho>
 <20150122113105.GB23461@hermes.click-hack.org>
In-Reply-To: <20150122113105.GB23461@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-3 creating debian packages
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On 2015-01-22 12:31, Gilles Chanteperdrix wrote:
> On Thu, Jan 22, 2015 at 12:17:15PM +0100, Leopold Palomo-Avellaneda wrote:
>> I have renamed the subject according with the theme.
>>
>> El Dijous, 22 de gener de 2015, a les 11:48:13, Gilles Chanteperdrix va 
>> escriure:
>>>>>
>>>>> Well, the fact that the compilation error happens when trying to
>>>>> compile a Xenomai file would seem to indicate that prepare-kernel.sh
>>>>> has put the wrong link into init/Kconfig.
>>>>>
>>>>> You pass --arch=x86 to prepare-kernel.sh, right, not --arch=x86_64 ?
>>>>
>>>> yes, I have tried both, but I put --arch=x86 or the default option as I
>>>> said it in my email from yesterday ( :-P)
>>>
>>> Well, maybe the default option does not work, so please try
>>> specifying --arch=x86. The error you have is not in the compiled
>>> files, but in the Kconfig files. So, the fact that you can compile
>>> does not really prove that prepare-kernel.sh did not fail.
>>
>> Ok, from a clean sources I have run from the linux tree sources:
>>
>> $ ../xenomai-3.git/scripts/prepare-kernel.sh --linux=. --
>> ipipe=../xenomai-3.git/kernel/cobalt/arch/x86/patches/ipipe-core-3.16-
>> x86-1.patch --arch=x86 
>>  
>>> Now, prepare-kernel.sh adds the scripts/Kconfig.frag file to
>>> init/Kconfig. Kconfig.frag contains:
>>
>> I don't understand that sentence. Yes, the  Kconfig.frag now, contains this:
>>
>> source "arch/$ARCH/xenomai/Kconfig"
> 
> Ah OK. Could you try to revert that commit ?
> 
> http://git.xenomai.org/xenomai-3.git/commit/scripts/Kconfig.frag?h=next&id=26cc64313e2e695ac227e5a02992c5fe72df2e5f

Better directly replace $ARCH with $SRCARCH. That should fix my patch
(which was tested only on x86-64 build systems that do not set ARCH).

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

