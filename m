From: "Wang, Rick Y" <rick.y.wang@intel.com>
Subject: Xenomai Community Call Minutes - May 5, 2021 
Date: Wed, 5 May 2021 09:01:46 +0000
Message-ID: <CO6PR11MB5649B1B930BC95B07365AF91BA599@CO6PR11MB5649.namprd11.prod.outlook.com>
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

Philippe Gerum, Jan Kiszka, Florian Bezdeka, Florent Pirou, Rick Wang


*Logistics
- Propose to find alternative tool to Teams for the community call if=20
possible. The requirements are web browser support, company env compliance=
=20
and geo friendly.=20


*Community update

- Issue tracker https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues
  Xenomai 3.2 tagged issues:
  #18 Integrate wip/dovetail changes into mainline - Philippe just pushed
  70 patches which including support to 5.10 kernel and Dovetail porting.=20
 =20
  #17 Smokey gdb test fails over dovetail - Hongzhan has submitted a patch
  to work around the issue. The root cause could be more deeper and Philipp=
e
  will further investigate.
 =20
  #16 Handling clocksource switch more gracefully - Philippe will prioritiz=
e
  to check this issue. Florian will share the image to help Philippe to=20
  reproduce.

- Latmus patches from Hongzhan was merged for Xenomai 3.2. =20
  Latmus will coexist with Latency at the moment to extend timer latency
  with GPIO latency. Long term wise a new Latmus latency test tool shall
  integrate timer and I/O latency together. The current latency tool will
  retire after that. The new tool will be modular designed with multiple
  plugins to support different features, e.g. PCIe latency on x86.

- Xenomai 4=20
  Philippe is working on network stack. Plan to open development soon.
  The main issue is how to share documents between Xenomai 3 and 4.


Thanks,
Rick

