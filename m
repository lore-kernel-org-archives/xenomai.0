Subject: Re: TSN support on xenomai
References: <SG2PR04MB325361212B0F13BA9DE98BC0A49D0@SG2PR04MB3253.apcprd04.prod.outlook.com>
 <263bfd52-638e-1205-dc57-c0fb773b0acf@numalliance.com>
 <dee89c0f-c026-33c2-da13-42d090f58d6c@siemens.com>
 <VI1PR05MB59171660A06A205C47F6DF3AF69D0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <c244091f-127a-e3ac-8116-b3624907f17a@siemens.com>
 <SG2PR04MB3253BF73D742CF3A816C1B61A49D0@SG2PR04MB3253.apcprd04.prod.outlook.com>
 <ffc06274-9349-1883-3cb6-73a0d0cc0cf4@siemens.com>
 <BYAPR11MB376590FC75BCFF24F87E64BDEE9A0@BYAPR11MB3765.namprd11.prod.outlook.com>
 <SG2PR04MB3253B1CD0502D28DB492F601A49A0@SG2PR04MB3253.apcprd04.prod.outlook.com>
 <8e61c085-7b37-04ac-4658-fd724b581db4@numalliance.com>
 <SG2PR04MB325305DCE18BB1D83FF31A81A49A0@SG2PR04MB3253.apcprd04.prod.outlook.com>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <dfb8e8af-ffdf-5eeb-bcc0-167f9a1611fa@numalliance.com>
Date: Wed, 17 Jun 2020 18:25:53 +0200
MIME-Version: 1.0
In-Reply-To: <SG2PR04MB325305DCE18BB1D83FF31A81A49A0@SG2PR04MB3253.apcprd04.prod.outlook.com>
Content-Language: fr
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Peter Wong <tsnuser@outlook.com>, "Meng, Fino" <fino.meng@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>, Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>, "Pirou, Florent" <florent.pirou@intel.com>, "Gong, Xiaoyan" <xiaoyan.gong@intel.com>, "Pu, Yanfeng" <yanfeng.pu@intel.com>, "Zhang, Wei E" <wei.e.zhang@intel.com>


Le 17/06/2020 =E0 16:59, Peter Wong a =E9crit=A0:
> Hi S.Ancelot,
>
> You have done some comparison between kernel network stack vs xenomai=20
> RTnet stack?=A0 Can you share some data ?
>
Giving some data will not help anybody that really depends on your=20
application.


Looking at tc - ETF features of the latest kernels , I had to understand=20
a bit how it was working .

The most complicated thing to understand is how to setup nic queues.

I managed to run our proprietary Ethercat master with RT Preempt with an=20
RT task cycle of 1ms, to sync drives using DC clocks .

There can be big jitter of this task=A0 without any problem.

The only requirement is being sure the next frame programmed being sent=20
BEFORE the next DC sync.=A0 (in my case at least 180us before next DC sync)

And in this case, offloading and dedicating this task to the i210 NIC=20
hardware helps.




Some interesting past weblinks used to understand, it has a lot evolved=20
since ...:

https://elinux.org/images/5/56/ELC-2018-USA-TSNonLinux.pdf

https://github.com/torvalds/linux/blob/master/net/sched/sch_etf.c

Time Based packet transmlission , now renamed ETF:=20
https://lwn.net/Articles/744797/ <https://lwn.net/Articles/744797/>

v2 : https://lwn.net/Articles/758592/

...


SO_TXTIME:

https://gitlab.freedesktop.org/lima/linux/commit/80b14dee2bea128928537d61c3=
33f24cb8cbb62f




You can=A0 search google=A0 for data, with=A0 TSN and OPC-UA protocol too.


>
>
>
>
>
> ------------------------------------------------------------------------
> *From:* St=E9phane Ancelot <sancelot@numalliance.com>
> *Sent:* Wednesday, June 17, 2020 9:19 PM
> *To:* Peter Wong <tsnuser@outlook.com>; Meng, Fino=20
> <fino.meng@intel.com>; Jan Kiszka <jan.kiszka@siemens.com>; Lange=20
> Norbert <norbert.lange@andritz.com>; Xenomai (xenomai@xenomai.org)=20
> <xenomai@xenomai.org>; Pirou, Florent <florent.pirou@intel.com>; Gong,=20
> Xiaoyan <xiaoyan.gong@intel.com>; Pu, Yanfeng <yanfeng.pu@intel.com>;=20
> Zhang, Wei E <wei.e.zhang@intel.com>
> *Subject:* Re: TSN support on xenomai
>
>
> Le 17/06/2020 =E0 09:25, Peter Wong a =E9crit=A0:
>> I think of 2 benefit by running tsn over rtnet + xenomai network driver
>>
>>   * better performance since xenomai delivering stringent real-time
>>     guarantee and rtnet is smaller network stack
>>   * xenomai rt application can run on tsn network
>>
>> Is that right?
>>
> From my experience=A0 : The answer is no.
>
>
> The kernel network stack has been rewritten=A0 in order being efficient=20
> to achieve these tasks.
>
>
> Furthermore , thanks to the way TSN (or ethercat) protocol works you=20
> don't need a very hard realtime OS, allowing a bigger jitter for the=20
> RT task using=A0 the network.
>
> This is up to the nic hardware component to=A0 send the frame at the=20
> programmed time . The only RT task requirement is that it should have=20
> provided the frame to the nic interfaces before the next clock sync=20
> occurs.
>
>
> Regards,
>
> S.Ancelot
>
>
>
>>
>> ------------------------------------------------------------------------
>> *From:* Meng, Fino <fino.meng@intel.com> <mailto:fino.meng@intel.com>
>> *Sent:* Wednesday, June 17, 2020 2:08 PM
>> *To:* Jan Kiszka <jan.kiszka@siemens.com>=20
>> <mailto:jan.kiszka@siemens.com>; Peter Wong <tsnuser@outlook.com>=20
>> <mailto:tsnuser@outlook.com>; Lange Norbert=20
>> <norbert.lange@andritz.com> <mailto:norbert.lange@andritz.com>;=20
>> St=E9phane Ancelot <sancelot@numalliance.com>=20
>> <mailto:sancelot@numalliance.com>; Xenomai (xenomai@xenomai.org=20
>> <mailto:xenomai@xenomai.org>) <xenomai@xenomai.org>=20
>> <mailto:xenomai@xenomai.org>; Pirou, Florent=20
>> <florent.pirou@intel.com> <mailto:florent.pirou@intel.com>; Gong,=20
>> Xiaoyan <xiaoyan.gong@intel.com> <mailto:xiaoyan.gong@intel.com>; Pu,=20
>> Yanfeng <yanfeng.pu@intel.com> <mailto:yanfeng.pu@intel.com>; Zhang,=20
>> Wei E <wei.e.zhang@intel.com> <mailto:wei.e.zhang@intel.com>
>> *Subject:* RE: TSN support on xenomai
>>
>>
>> >Sent: Tuesday, June 16, 2020 10:39 PM
>> >
>> >On 16.06.20 16:00, Peter Wong wrote:
>> >> Can we compile linuxptp (cobalt POSIX wrap) to run on RTnet=A0 + Xeno=
mai
>> >> I210 driver so that we only need one NIC to run TSN on RTnet?
>> >>
>> >
>> >There is nothing like that upstream so far. Maybe Fino or Florent
>> >already have some plans, though I expect them to target newer hardware.
>> >
>> >Jan
>>
>> We are working on TSN over Xenomai/Cobalt.
>> For example, have tested such simple case:
>> The synchronizing NIC is inside Linux domain, the TSN stack on=20
>> vanilla kernel,
>> Cobalt Thread share data to Linux thread first, then send out through=20
>> TSN stack,
>> Cyclic is 250us, 802.1Qbv enabled, single way, 5 minutes,
>> with some stress-ng workload and 100M noise traffic,
>> test result is identical with preempt-rt Linux, although this case=20
>> may not
>> match real world scenario.
>>
>> Our current target is find a BKM, let Xenomai app can use the TSN stack,
>> so the synchronizing NIC is stay in vanilla kernel.
>> Let TSN & RTNet merge into one NIC is not in current plan. But if found
>> real world use case really need it, we would like to working on it,
>>
>> BR fino
>>
>> >
>> >>=20
>> ------------------------------------------------------------------------
>> >> *From:* Xenomai <xenomai-bounces@xenomai.org>=20
>> <mailto:xenomai-bounces@xenomai.org> on behalf of Jan Kiszka
>> >> via Xenomai <xenomai@xenomai.org> <mailto:xenomai@xenomai.org>
>> >> *Sent:* Tuesday, June 16, 2020 5:44 PM
>> >> *To:* Lange Norbert <norbert.lange@andritz.com>=20
>> <mailto:norbert.lange@andritz.com>; St=E9phane Ancelot
>> >> <sancelot@numalliance.com> <mailto:sancelot@numalliance.com>;=20
>> Xenomai (xenomai@xenomai.org <mailto:xenomai@xenomai.org>)
>> >> <xenomai@xenomai.org> <mailto:xenomai@xenomai.org>
>> >> *Subject:* Re: TSN support on xenomai
>> >>
>> >> On 16.06.20 11:41, Lange Norbert wrote:
>> >>>
>> >>>
>> >>>> -----Original Message-----
>> >>>> From: Xenomai <xenomai-bounces@xenomai.org>=20
>> <mailto:xenomai-bounces@xenomai.org> On Behalf Of Jan Kiszka
>> >>>> via Xenomai
>> >>>> Sent: Dienstag, 16. Juni 2020 10:58
>> >>>> To: St=E9phane Ancelot <sancelot@numalliance.com>=20
>> <mailto:sancelot@numalliance.com>; xenomai@xenomai.org=20
>> <mailto:xenomai@xenomai.org>
>> >>>> Subject: Re: TSN support on xenomai
>> >>>>
>> >>>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>> >>>> ATTACHMENTS.
>> >>>>
>> >>>>
>> >>>> On 16.06.20 10:55, St=E9phane Ancelot via Xenomai wrote:
>> >>>>> Hi,
>> >>>>>
>> >>>>> This is natively supported in standard linux kernel
>> >>>>>
>> >>>>
>> >>>> Right. What is missing it linking the Xenomai timebase with that=20
>> of the kernel
>> >>>> so that we would benefit from Linux doing the sync for us already.
>> >>>
>> >>> But that means you can't use the synchronizing NIC with RTNet /=20
>> Realtime traffic.
>> >>>
>> >>> Regarding linking timebases, it would help (for various things)
>> >>> If you could easily read those various timebases from the kernel.=20
>> The rest can happen in
>> >>> userspace.
>> >>>
>> >>> I actually have 3: Linux Monotonic, Xenomai Monotonic, and a PPS=20
>> synchronized IEEE1588 clock,
>> >>> Cant fold them into one but sometimes need to map between these.
>> >>> Solved this by letting the NIC read out all 3 and providing them=20
>> to (Xenomai) userspace.
>> >>>
>> >>> Better would be a shared mmap (with 2 or more buffers), so that=20
>> Linux tasks can asynchronously get that info too.
>> >>>
>> >>
>> >> Latest Intel hardware supports mapping for the PTP time to the system
>> >> time (tsc) natively. You only need to read out the conversion=20
>> factors in
>> >> the end. That's what we want to have as well.
>> >>
>> >> If using that will create a conflict with using the NIC for RT=20
>> traffic?
>> >> Likely. But that needs to be sorted out in the future, not only on=20
>> Intel hw.
>> >>
>> >> Jan
>> >>
>> >> --
>> >> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>> >> Corporate Competence Center Embedded Linux
>> >>
>> >
>> >--
>> >Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>> >Corporate Competence Center Embedded Linux
