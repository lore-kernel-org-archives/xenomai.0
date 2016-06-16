From: "Heinick, J Michael" <Michael.Heinick@Honeywell.com>
Date: Thu, 16 Jun 2016 15:51:17 +0000
Message-ID: <D9EDB4F689BF9F4EA6F2158A073942732E801DAA@de08ex3008.global.ds.honeywell.com>
References: <D9EDB4F689BF9F4EA6F2158A073942732E8007D6@de08ex3008.global.ds.honeywell.com>
 <20160608193911.GA31360@hermes.click-hack.org>
 <D9EDB4F689BF9F4EA6F2158A073942732E8008F3@de08ex3008.global.ds.honeywell.com>
 <20160609174118.GD1785@hermes.click-hack.org> <575AF2E1.3060401@siemens.com>
In-Reply-To: <575AF2E1.3060401@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Xenomai/Cobalt on i7-3770S CPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>



-----Original Message-----
From: Jan Kiszka [mailto:jan.kiszka@siemens.com]=20
Sent: Friday, June 10, 2016 1:03 PM
To: Gilles Chanteperdrix; Heinick, J Michael
Cc: xenomai@xenomai.org
Subject: Re: Xenomai/Cobalt on i7-3770S CPU

On 2016-06-09 19:41, Gilles Chanteperdrix wrote:
> On Thu, Jun 09, 2016 at 05:32:51PM +0000, Heinick, J Michael wrote:
>>
>> -----Original Message-----
>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>> Sent: Wednesday, June 08, 2016 3:39 PM
>> To: Heinick, J Michael
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai] Xenomai/Cobalt on i7-3770S CPU
>>
>> On Wed, Jun 08, 2016 at 09:42:26AM +0000, Heinick, J Michael wrote:
>>>
>>> We currently have an RTDM driver that is running well on=20
>>> Xenomai/Cobalt 3.0.1 on 2 Dell computers with Core2 processors, but=20
>>> will hang (unresponsive mouse and keyboard, no discernable activity)=20
>>> an entire SuperLogics i7 computer with a Core i7-3770S processor (4=20
>>> physical cores, 4 logical cores).  The hang occurs in the ioctl=20
>>> function at an rtdm_sem_down call that waits for the interrupt=20
>>> handler to signal the handling of an interrupt.  We suspect that we=20
>>> have a problem with our kernel build/installation configuration=20
>>> options.  We have attempted to configure the Core i7-3770S system so=20
>>> that Xenomai/Cobalt only uses 2 cores like the other 2 working Core2=20
>>> computers, but the system still hangs (more detail on the results of=20
>>> our attempt is included beow).  Eventually, we would like to configu
>  re Xenomai/Cobalt to run on 4 cores of the i7 computer if possible.
>>>
>>> Any suggestions to help us make/install/configure Xenomai/Cobalt to run=
 on the SuperLogics computer with the i7-3770S processor so that the rtdm_s=
em_down call in the RTDM driver does not hang the entire system would be ap=
preciated.
>>
>> This sounds like an irq conflict: a device handled by an RTDM driver can=
 not use the same irq line as a device handled by a plain Linux driver with=
out modifying the plain Linux driver. See FAQ for solutions to that problem=
.
>>
>> --=20
>> 					    Gilles.
>> https://click-hack.org
>>
>>
>> Thanks for the reply, Gilles.
>>
>> Yes, there was a conflict on irq 16. We disabled the conflicting=20
>> component so that now our driver is the only one on irq 16, but the=20
>> i7-3770S system is still hanging. We know the interrupt handler is=20
>> receiving the interrupts and handling them without hanging the i7=20
>> system. With the interrupts running at 20Hz, the handler stores=20
>> counts of the second and sub-second interrupts that we can retrieve=20
>> with a different ioctl call that does not wait for an interrupt. The=20
>> hang only occurs in the ioctl call at the wait with the rtdm_sem_down=20
>> call. The contents of selected files from the /proc directory are=20
>> included below.
>=20
>=20
> Could you post the simplest driver which generates this issue?
>=20

And do you have CONFIG_XENO_OPT_DEBUG_COBALT enabled? That may reveal sleep=
ing issues in the driver design (common source of troubles).

Jan

--
Siemens AG, Corporate Technology, CT RDA ITP SES-DE Corporate Competence Ce=
nter Embedded Linux

------------------
Thanks Gilles and Jan for your help last week. =20

We have apparently found the bug in my code that caused the problem.  This =
is our first RTDM driver, and early in its development only the ioctl_nrt h=
andler was specified in the ops structure of the rtdm_driver structure, and=
 not the ioctl_rt handler.  During the process this past week of stripping =
down the driver to generate some code to post that would demonstrate the pr=
oblem, the stripped down driver would hang the core2 computer just like the=
 i7 computer.  Eventually, I noticed that only nrt handlers were specified =
in the ops structure.   After moving our ioctl functions to .ioctl_rt, both=
 the stripped down driver and the full driver run on both the core2 and i7 =
computers.  Why the core2 computers appeared to work with only the ioctl_nr=
t handler specified in the full driver and hang the i7 computer is still a =
mystery to us.

Thanks again for your help,
Mike

