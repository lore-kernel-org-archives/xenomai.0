From: "Wang, Rick Y" <rick.y.wang@intel.com>
Subject: Xenomai Community Call Minutes - Janurary 13, 2021
Date: Thu, 14 Jan 2021 13:31:28 +0000
Message-ID: <DM6PR11MB43143732FA2BDA6D0F9D5AEBBAA80@DM6PR11MB4314.namprd11.prod.outlook.com>
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
Hongzhan Chen (Intel), Fino Meng (Intel), Florian Bezdeka (Siemens),=20
Jeroen Van den Keybus (National Instruments), Steven, Sonnypoint,=20
Yang Yao (Intel), Dao Zhang (Intel), Jianbo Cao (Intel), Rick Wang (Intel)


Agenda:

*Community call logistics - Rick
*Community update - Jan=20
*Dovetail, CXP and EVL update - Philippe
*Clarify Xenomai Roadmap - Rick
*Open


*Community call logistics=20
-----------------------------------
Biweekly every odd week (week #1 - 2021.1.1)
Next call is on Jan 27th.

Europe and Asia friendly time:
7:00-8:00 UTC | 8:00-9:00 Munich | 15:00-16:00 Shanghai

We can't find a good time for all geos and hard to split the call.=20
For people can't attend the regular call, it's possible to setup special=20
sessions per request when needed.

Dial in info:=20
https://xenomai.org/pipermail/xenomai/2020-December/043906.html


*Community update
----------------------------
Current stable 3.1 has no new patches in the past two weeks.=20
Master branch is working on 3.2.=20
Lava CI is doing well with test matrix growing.


*Dovetail, CXP and EVL update
----------------------------------------
Dovetail 5.11 is WIP.
EVL network stack is WIP. It will not be RTNet.

Lack of feedback in mailing list to CXP.=20
CXP spec definition plan to complete in Apr 2021.

Porting for Dovetail in Xenomai is expected to complete by end of Jan.=20
Thanks Hongzhan Chen from Intel for the hard work!

>From Feb, move on to CXP RTDM, POSIX library, etc.


Clarify Xenomai Roadmap
----------------------------------

3.1 - Current stable based on I-pipe
3.2 - Add dovetail to Xenomai. Cobalt core will run on top of an=20
      abstraction layer which interface to both I-Pipe and Dovetail.
3.3 - Common Xenomai Platform. Libcobalt and Cobalt core will be updated to=
=20
      prepare for transition to EVL.
4.0 - EVL. Both libevl and libcobalt (CXP) will be supported. Cobalt core w=
ill be=20
      replaced by EVL core and a POSIX driver layer on top of it.


Open
----------------


Discussion on EVL network stack. Philippe is working on a new design to=20
implement the RT network driver alternative to XDP or DPDK approaches.



Thanks,
Rick

