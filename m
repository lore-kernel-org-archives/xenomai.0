Message-ID: <4FEAFEB7.1030303@xenomai.org>
Date: Wed, 27 Jun 2012 14:38:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <D1DC5191D5CF3A45A867CD95644B92392162B41F@REXMF.intranet.epfl.ch>
	<4FEAFBFF.5070702@xenomai.org>
In-Reply-To: <4FEAFBFF.5070702@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] integrated drivers not built?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kronander Klas <klas.kronander@epfl.ch>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/27/2012 02:26 PM, Gilles Chanteperdrix wrote:
> On 06/27/2012 12:22 PM, Kronander Klas wrote:
>> Hello,
>>
>> Is there some special configuration that must be set in order to
>> build the integrated drivers (specifically the can-related ones)?
>>
>> I built xenomai, but I am not able to load any of the drivers. When
>> looking in /lib/modules/[MYKERNEL]/ folder, I find the drivers listed
>> in modules.builtin:
>>
>> cat /lib/modules/[MYKERNEL]/modules.builtin | grep xeno
>>
>> kernel/kernel/xenomai/nucleus/xeno_nucleus.ko 
>> kernel/kernel/xenomai/skins/native/xeno_native.ko 
>> kernel/kernel/xenomai/skins/posix/xeno_posix.ko 
>> kernel/kernel/xenomai/skins/rtdm/xeno_rtdm.ko 
>> kernel/drivers/xenomai/can/xeno_can.ko 
>> kernel/drivers/xenomai/can/sja1000/xeno_can_sja1000.ko 
>> kernel/drivers/xenomai/can/sja1000/xeno_can_peak_pci.ko 
>> kernel/drivers/xenomai/serial/xeno_16550A.ko 
>> kernel/drivers/xenomai/testing/xeno_timerbench.ko 
>> kernel/drivers/xenomai/testing/xeno_switchtest.ko
>>
>> but I can't find any of these object files on the paths specified in
>> the moduels.builtin file.  There is no xenomai directory in
>> /lib/modules/[MYKERNEL]/kernel/drivers, which I believe there should
>> be?
> 
> All modules named xeno_* are xenomai modules.

Sorry, I misunderstood the question. You want to know how to build and
install modules. I suggest you read:
http://kernelnewbies.org/FAQ/KernelCompilation

-- 
					    Gilles.

