From: "Wang, Rick Y" <rick.y.wang@intel.com>
Subject: Xenomai Community Call Minutes - February 24, 2021
Date: Wed, 24 Feb 2021 14:50:27 +0000
Message-ID: <BY5PR11MB430648A9F8E8A229B9D5433EBA9F9@BY5PR11MB4306.namprd11.prod.outlook.com>
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

Philippe Gerum, Jan Kiszka, Fino Meng, Florian Bezdeka, Song Chen,=20
Antoine Hoarau, Hongzhan Chen, Dao Zhang, Jianbo Cao, Yanfeng Pu,=20
Yipeng Qu, Rick Wang


Agenda:

*Community call logistics update - Rick
*Community update - Jan, Philippe
*Y2038 problem - Florian, Song
*Performance tuning - Fino


*Community call logistics=20

Biweekly every odd week no change (week #1 - 2021.1.1)
Next call is on Mar 10th.

Europe and Asia friendly time:
7:00-8:00 UTC | 8:00-9:00 Munich | 15:00-16:00 Shanghai

We need to switch from Webex to Microsoft Teams meeting.

Join on your computer or mobile app:=20

https://teams.microsoft.com/l/meetup-join/19%3ameeting_MGZiMzAwOTctMTI2Yy00=
NjZlLTg3M2MtNGM0MWQ3OGY0OGVi%40thread.v2/0?context=3D%7b%22Tid%22%3a%2246c9=
8d88-e344-4ed4-8496-4ed7712e255d%22%2c%22Oid%22%3a%224ee1bb82-287c-456a-99d=
8-fb230643c947%22%7d


*Community update

Need to fix some CI issues in Dovetail branch.
Dovetail on ARM/ARM64 is working in progress.
Dovetail porting to kernel 5.11 in progress.

CXP progress on wiki:
https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Common_Xenomai_Platform

Plan to start Xenomai 4 from April.

Depending on required kernel version:
Xenomai 3.1 with i-pipe for kernel 5.4
Xenomai 3.2 and later with Dovetail for kernel 5.11


*Y2038 problem

Florian and Song to submit patches to Philippe's branch before the CI
issues been fixed in Xenomai master/next.


*Performance tuning

Discussed some configurations to tune RT performance on IA platform.




Thanks,
Rick

