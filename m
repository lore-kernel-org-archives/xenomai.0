From: "Wang, Rick Y" <rick.y.wang@intel.com>
Subject: Xenomai Community Call Minutes - July 28, 2021
Date: Thu, 29 Jul 2021 16:03:27 +0000
Message-ID: <CO6PR11MB56499E0DB3BDFE5226E2BB21BAEB9@CO6PR11MB5649.namprd11.prod.outlook.com>
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

Jan Kiszka, Philippe Gerum, Florian Bezdeka, Song Chen, Hongzhan Chen,=20
Hao Li, Jianbo Cao, Rick Wang


*Community update

- To update Xenomai wiki with mirror info - https://gitee.com/xenomai
- To add licenses summary file in Xenomai project.
- Dovetail to follow mainline LTS kernel release.=20
- CI passed for 5.4 and 5.10 kernel.
- Xenomai 3.2 main issues:
  1. GPIO timestamp issue - no update.=20
  2. Analogy module - No code update and no contributor for years.
  Yet to decide whether keep it in 3.x.=20
  It's check point for all drivers during the upgrade: Need to understand=20
  the cost to maintain them and need feedback from community.=20
- Miss matched glibc version led to some LTP test failure.
- Expect more devices can be connected to LAVA lab for Xenomai CI testing.
=09


Thanks,
Rick

