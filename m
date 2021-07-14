From: "Wang, Rick Y" <rick.y.wang@intel.com>
Subject: Xenomai Community Call Minutes - July 14, 2021
Date: Wed, 14 Jul 2021 10:04:21 +0000
Message-ID: <CO6PR11MB5649C263459CED696B0A368DBA139@CO6PR11MB5649.namprd11.prod.outlook.com>
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
Hao Li, Yanfeng Pu, Rick Wang


*Community update

- Xenomai mirror on gitee.com is setup. Commit to the original repo will
auto sync to the mirror (Not vice versa though). It's expected that PRC=20
developers can get much improved download speed with this mirror.
https://gitee.com/xenomai

- Xenomai CI LAVA master setup on public cloud. Open for Xenomai developers
to connect target boards to the system.=20
http://lava.xenomai.org/

- Xenomai 3.2 is just a few weeks away. The major blocker so far is the=20
GPIO latency issue. Philippe/Jan will follow up.

- Dovetail and I-PIPE ABI compatibility will not be covered in Xenomai 3.2.

- Yanfeng tested a DPDK demo app on Cobalt which works just fine.
=20
- Hao Li shared Xenomai dovetail kernel test result on Intel platform.=20
Total 560 passed, 16 failed and 2 blocked. Investigating the fail cases.



Thanks,
Rick

