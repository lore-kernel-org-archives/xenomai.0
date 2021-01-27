From: "Wang, Rick Y" <rick.y.wang@intel.com>
Subject: Xenomai Community Call Minutes - Janurary 27, 2021
Date: Wed, 27 Jan 2021 12:45:41 +0000
Message-ID: <BY5PR11MB4306C7185C978D903C6D3524BABB9@BY5PR11MB4306.namprd11.prod.outlook.com>
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

Philippe Gerum, Jan Kiszka (Siemens), Hongzhan Chen (Intel),
Fino Meng (Intel), Yipeng (intel), Bruce Bao (Intel),=20
Florian Bezdeka (Siemens), Antoine Hoarau (Fuzzy Logic Robotics),
Chensong (kylin software), Xiaoyan Gong (Intel), Yanfeng Pu (Intel),=20
Dao Zhang (Intel), Rick Wang (Intel)=20


Agenda:

*Community update - Jan=20
*Dovetail, CXP and EVL update - Philippe
*Customer feedback - Fino
*Open


*Community update

Xenomai porting to kernel 5.4 for ARM/ARM64 is coming soon.


*Dovetail, CXP and EVL update

Xenomai on Dovetail
- Several crashing issue are being fixed.
- Adding test tool from EVL to Xenomai. Extending latency test for GPIO.
- X86 code ready within several days.
- Then switch to ARM/ARM64 porting.
- PowerPC is not supported by Dovetail. Community can chime in as needed.
- Early delivery in Feb.

CXP
- The idea is to simplify the project
  Not provide more than what we can sustain, and
  Not provide no used features
- Still lack of feedback in community.

EVL
- Support POSIX on EVL core
- Plan to port RTDM to EVL
- Concern on drivers
- RT Network stack shall leverage as much the native stack rather than=20
creating everything from the ground up.


*Customer feedback

Some PRC Xenomai customers feedback:
- Generally OK to port to POSIX API if no functionality and performance=20
downgrade;
- Some customer is using Alchemy API "rt_task_*" since Xenomai 2. The=20
customer is ok to port to POSIX API;
- RTDM drivers used for GPIO, SPI, Serial, PCIe Can card, IgH EtherCAT, etc=
.=20


Next community call: Feb 10, 2021


Thanks,
Rick

