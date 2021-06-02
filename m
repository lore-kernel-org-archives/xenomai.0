From: "Wang, Rick Y" <rick.y.wang@intel.com>
Subject: Xenomai Community Call Minutes - June 2, 2021
Date: Wed, 2 Jun 2021 13:43:20 +0000
Message-ID: <CO6PR11MB56491BFB87CB46C2B7D94B57BA3D9@CO6PR11MB5649.namprd11.prod.outlook.com>
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

Philippe Gerum, Jan Kiszka, Florian Bezdeka, Florent Pirou,=20
Hongzhan Chen, Yanfeng Pu, Dao Zhang, Jianbao Cao, Xiaoyan Gong, Song Chen,
Rick Wang


*Logistics

Time no change - Biweekly Wednesday 9:00-10:00 Munich, 15:00-16:00 Shanghai

Join Zoom Meeting=20
https://us05web.zoom.us/wc/join/81175706978?pwd=3DS1FmTWtKTGY3REJqNzJRbmt0Z=
zN4QT09=20
or
https://us05web.zoom.us/j/81175706978?pwd=3DS1FmTWtKTGY3REJqNzJRbmt0ZzN4QT0=
9=20
Meeting ID: 811 7570 6978=20
Passcode: 6RhNiS=20


*Community update

- Xenomai 3.1.1 released.
- New home for dovetail enabled kernel:
  https://source.denx.de/Xenomai/linux-dovetail
- Half of Dovetail patches have been merged. Less than 30 patches are pendi=
ng.
- Top issues:
  1. RCU stalls issue - Philippe's P1 task.
  2. rtdm/nrtsig issue - Hongzhan volunteered to dig into it.
- Y2038 2-3 series of patches ready for integration.
- Latmus tool test setup signal issues with Rock Pi X board. Put on hold.
  Another option is to measure GPIO latency on Intel platform with Time-
  Aware GPIO (TGPIO) support.
- Open: do we need a mirror on gitee.com for PRC users?


Thanks,
Rick

