From: "Wang, Rick Y" <rick.y.wang@intel.com>
Subject: Xenomai Community Call Minutes - December 16, 2020
Date: Wed, 16 Dec 2020 15:39:37 +0000
Message-ID: <BY5PR11MB4306415343378A8B7A622FBFBAC50@BY5PR11MB4306.namprd11.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Attendees:

Philippe Gerum, Jan Kiszka (Siemens), Florent Pirou (Intel),=20
Hongzhan Chen (Intel), Fino Meng (Intel), Song Chen (kylin software),
Antoine Hoarau (Fuzzy Logic Robotics), Florian Bezdeka (Siemens),=20
Jeroen Van den Keybus (National Instruments), Yang Yao (Intel),
Dao Zhang (Intel), Jianbo Cao (Intel), Yipeng (Intel), Lisa Li (Intel),
Anderson Huang (Intel), Hongwei Wang (Intel), Hao Huang (Intel),
Jacky Zhu (Intel), Rick Wang (Intel)


Agenda:

*Welcome and agenda - Rick=20
*Community update - Jan=20
*Xenomai/EVL roadmap (3.2 to 4.0) - Jan/Philippe
*Hot topics discussion - Hongzhan and developers
*Attendees survey
*Open


Roadmap:

3.1 - Current stable based on I-pipe
3.2 - Xenomai over Dovetail (Target porting done by Feb 2021, stable by Q2 =
2021)
3.3 - Common Xenomai Platform (Specification done by Mar 2021)=20
4.0 - EVL (TBD)

*** Call to Action: Please feedback to the community ***
Definition of next generation Xenomai needs input from users. Any feedback
to Xenomai including but not limited to below topics are welcome.=20

*How are you using Xenomai?=20
*What's the usage scenario?=20
*Which features are you using?
*Which APIs are you using?
*What's your performance expectation?
*What's your project's maintenance cycle?

Feedback to the community by end of Mar 2021 (CXP specification complete)
is highly appreciated .


Xenomai over Dovetail progress:

Jan and Hongzhan Chen have been working on porting Xenomai over Dovetail=20
in the past two months. The boot is successful with issues under debug.=20
Philippe will guide Hongzhan to finish the porting for 3.2.=20
Keep development with 5.9 kernel until we can decide a preferred=20
kernel version for 3.2.


Attendees response to the live polling regarding interested Xenomai topics:

*Ethernet drivers
*general real time system for industry control
*Low-latency scheduling
*RTOS on x86 platform
*interrupt and scheduling, finding sources of latency...
*Dual-kernel thread scheduling and IA64 interrupt pipelining, Linux debug &
latency tracing,..
*Dual-core RT IRQ pipeline and thread scheduling, Latency tracing, RTDM
*RT tuning on X86, interrupt pipeline...
*Linux, embedded systems, industry control
*RTOS implementations


Open

Philippe and Jan answered questions from team on Xenomai + Preempt-rt, vani=
lla=20
kernel syscall for RT, RTNet evolution, TSN integration, etc.=20
A lot of deep insight!
Sorry for not able to capture all the details... Please feel free to commen=
t.


Thanks for attending the first xenomai community call! We'll have the next=
=20
community call after the new year on 13th of January 2021, 7:00-8:00 UTC.


Happy holiday and stay safe!


Thanks,
Rick

