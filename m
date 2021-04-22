From: "Wang, Rick Y" <rick.y.wang@intel.com>
Subject: Xenomai Community Call Minutes - April 21, 2021 
Date: Thu, 22 Apr 2021 14:40:49 +0000
Message-ID: <CO6PR11MB56490563F70C498863F64C4EBA469@CO6PR11MB5649.namprd11.prod.outlook.com>
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

Jan Kiszka, Florian Bezdeka, Florent Pirou, Hongzhan Chen,=20
Dao Zhang, Jianbo Cao, Yanfeng Pu, Song Chen, Rick Wang


*Community update

- CI is up for WIP-Dovetail with the blocking issues on ARM fixed.
- Florian reported a high latency issue with wip/dovetail. Debugging.
- Hongzhan submitted patches for latmus GPIO latency test tool. The test=20
  was blocked though by inconsistent GPIO voltages between the test board=20
  and the target board. Pending on new board arrival.
- Y2038 development in progress. Song to resend patchset with cover letter.

- Issue tracker https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues
  Xenomai 3.2 tagged issues:
  #18 Integrate wip/dovetail changes into mainline - Jan and Philippe
         ~70 patches, 10-15 unmerged, 20-30 queued in Philippe
  #17 Smokey gdb test fails over dovetail - Hongzhan will debug.
  #16 Handling clocksource switch more gracefully - Jan and Philippe


* Intel TCC discussion

- Need to help the community to understand more on the TCC feature.
- The starting point could be RT performance optimization with SRAM,=20
  TGPIO etc.
- Potential to add new smokey test suite for MMIO latency and MSI latency.=
=20
- Either XDP or DPDK are not available for Xenomai yet. Need further=20
  investigation on the feasibility.



Thanks,
Rick

