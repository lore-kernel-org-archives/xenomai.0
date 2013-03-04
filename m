Message-ID: <51348C8C.9050407@siemens.com>
Date: Mon, 04 Mar 2013 12:59:08 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <1362151982.5735.YahooMailNeo@web171205.mail.ir2.yahoo.com>
	<5130E0C7.80709@siemens.com> <5130E6FE.2070905@siemens.com>
	<1362185238.64750.YahooMailNeo@web171203.mail.ir2.yahoo.com>
	<5131B5A2.6000501@web.de> <5131DC27.80909@xenomai.org>
	<5131DE8D.4070701@web.de> <51320ACA.4070101@xenomai.org>
	<51320EDF.2090104@web.de> <51320F98.7010900@xenomai.org>
	<51330EB1.9030801@web.de> <51331123.9070800@xenomai.org>
	<1362345350.16477.YahooMailNeo@web171206.mail.ir2.yahoo.com>
In-Reply-To: <1362345350.16477.YahooMailNeo@web171206.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kvm freeze with ipipe patch for kernel 3.x
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gabriele Moabiti <gabmoa@yahoo.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-03-03 22:15, Gabriele Moabiti wrote:
>>>>>>>>
> 
>>>>>>>> I'm planning to get them merged into 3.8 first of all, maybe also into
>>>>>>>> 3.5 (as this is our current production baseline). No plans exist beyond
>>>>>>>> that. I'd rather like to leave older kernels alone to reduce maintenance
>>>>>>>> efforts (porting is simple, proper testing takes time).
>>>>>>>>
>>>>>>>> Also note that 3.2 is lacking much more critical fixes than those few
>>>>>>>> around KVM. IOW: Don't use it for anything serious with x86.
>>>>>>>
>>>>>>>
>>>>>>> Maybe reverting the mprotect/ipipe_pin_vma patches in the 3.2 branch, so
>>>>>>> as to avoid the zero page corruption, but take some faults sometimes
>>>>>>> would be a simple, feasible solution? 3.2 seems to have been chosen as a
>>>>>>> long term stable branch.
>>>>>>
>>>>>> Again, the problem is not writing the patches
>>>>>
>>>>>
>>>>> It is easy to forget a patch when (back)porting patches from an I-pipe
>>>>> to the other.
>>>>>
>>>>>> but testing all the stuff
>>>>>> in all necessary combinations.
> 
> So.. does 3.2 or 3.4 (at least an LTS kernel) will be supported or it's better to use only the 3.5.7 (EOL)?

For the time being and as you depend on KVM, use my queues/core-3.5 branch.

> I think if a kernel patch has serious problems should be marked as broken or unstable.

I agree, and I already requested to remove patches from the Xenomai code
base at least that contain known bugs. Should improve over the next
releases.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

