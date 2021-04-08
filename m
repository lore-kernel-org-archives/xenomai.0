From: "Wang, Rick Y" <rick.y.wang@intel.com>
Subject: Xenomai Community Call Minutes - April 7, 2021
Date: Thu, 8 Apr 2021 00:51:45 +0000
Message-ID: <CO6PR11MB56493CA60ADCFBEFC2670FF3BA749@CO6PR11MB5649.namprd11.prod.outlook.com>
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

Jan Kiszka, Florian Bezdeka, Florent Pirou, Hongzhan Chen,
Dao Zhang, Jianbo Cao, Yanfeng Pu, Rick Wang


*Community update

- No code change in the past two weeks
- Greg is debugging jitter issue on ARM.
- Siemens is testing WIP-Dovetail branch internally. Some issues were
reported related to clock source or gdb crash.
- Jan will log the issues to gitlab Xenomai hacker space:
https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues
- For Xenomai 3.2, there are some submitted patches pending on Jan's review
and merge. Also some patches in Philippe's private tree are pending on
submission.
- Florian and Song are working on Y2038 issue on Philippe's tree. It depend=
s
on some Dovetail codes to be merged first.
- Hongzhan is working on latmus GPIO porting. 5.10 Dovetail-based Xenomai
and EVL can't boot up on his dev board yet. 5.9 kernel can boot on the
same board. It could be related to clock source and ACPI changes in kernel.



Thanks,
Rick
