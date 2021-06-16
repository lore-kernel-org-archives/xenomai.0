From: "Wang, Rick Y" <rick.y.wang@intel.com>
Subject: Xenomai Community Call Minutes - June 16, 2021 
Date: Wed, 16 Jun 2021 11:52:21 +0000
Message-ID: <CO6PR11MB5649BB3ABA9B2176C98F7F7EBA0F9@CO6PR11MB5649.namprd11.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

Jan Kiszka, Florian Bezdeka, Florent Pirou, Hongzhan Chen, Yanfeng Pu,
Dao Zhang, Hao Li, Antoine Hoarau, Rick Wang


*Community update

- Dovetail support is now in master. All but the latmus patches have been
  merged. CI pipelines are setup and running.
- Top issues:
  https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues
  #16 Handling clocksource switch more gracefully - WIP
  #18 Integrate wip/dovetail changes into mailine - Done
  #20 Resolve Dovetail stability issues - Done
  #23 smokey's rtdm test unreliable - WIP

- Y2038 patches are not gating 3.2 as long as not breaking the system.

- Networking - DPDK polling at high priority as RT thread may cause system
  stall. It's encouraged to discuss on mailing list for any ideas or
  experiments on this.



Thanks,
Rick

