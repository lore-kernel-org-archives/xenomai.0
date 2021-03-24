From: "Wang, Rick Y" <rick.y.wang@intel.com>
Subject: Xenomai Community Call Minutes - March 24, 2021 
Date: Wed, 24 Mar 2021 16:29:14 +0000
Message-ID: <BY5PR11MB430683E41B8D0A2FAC5CB28BBA639@BY5PR11MB4306.namprd11.prod.outlook.com>
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

Jan Kiszka, Florent Pirou, Fino Meng, Florian Bezdeka, Song Chen,=20
Antoine Hoarau, Hongzhan Chen, Dao Zhang, Jianbo Cao, Yanfeng Pu,
Xiaoyan Gong, Jeroen Van den Keybus, Rick Wang


Agenda:

*Community update
*Intel TCC
*I/O latency
*Open


*Community update

Online update from Jan:

- Next branch is in good state.=20
- Testing heavily on the Dovetail branch.=20
- Debugging a TSC issue on Coffee Lake.
- A Xenomai Hacker Space was setup on gitlab:
  https://gitlab.com/Xenomai/xenomai-hacker-space
  "This hacker space shall not replace the official project page but=20
  augment it. Users with gitlab.com accounts can file issue or comment=20
  on them, developers can request access in order to edit the wiki, and=20
  - in the future - also benefit from CI and test lab resources Siemens=20
  is donating to the project."


Offline update from Philippe:

"
- The Xenomai/arm64 port to Dovetail is complete, available from my
  private tree. Tested on kvm/aarch64, imx8mm, rpi4 and Odroid C4 so
  far.
- All pending patches now merged into my 3.2 tree.
- A regression with Xenomai/I-pipe on this tree was fixed a couple of
  days ago, causing switchtest to freeze the machine. You may want to
  rebase on it.
"


* Intel(r) Time Coordinated Computing (Intel(r) TCC)

https://www.intel.com/content/www/us/en/design/technologies-and-topics/iot/=
real-time.html

- TCC enabled processors deliver optimal compute and time performance for=20
  real-time applications
- Need to follow up on leveraging TCC capability in Xenomai


* I/O latency

- Currently no I/O latency benchmark tool or reference result in Xenomai
- Philippe and Hongzhan are working on porting the latmus tool for GPIO
  latency measurement
- Jan used DPDK Pingpong test to measure the latency.=20
- There is a RTCP KPI in TCC tools to measure round trip cycle time from=20
  I/O to I/O (e.g. with I210 NIC).
 =20



Thanks,
Rick

