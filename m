From: "Wang, Rick Y" <rick.y.wang@intel.com>
Subject: Xenomai Community Call Minutes - March 10, 2021
Date: Wed, 10 Mar 2021 10:56:18 +0000
Message-ID: <BY5PR11MB4306385582356B11B21A19E1BA919@BY5PR11MB4306.namprd11.prod.outlook.com>
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
Antoine Hoarau, Hongzhan Chen, Dao Zhang, Jianbo Cao, Yanfeng Pu,
Anderson Huang, Florent Pirou, Xiaoyan Gong, Bryan Cheng, Rick Wang

Agenda:
*Community update - Jan, Philippe
*Open

*Community update
- x32 ABI support is removed from CXP.
- ARM64 Dovetail enabling is working in progress.
- Regression issue found with current patches merged.
- x86-32 app crash on the latest build.
- The gdb issue is fixed by Hongzhan. Patch submitted pending on merge.
- Y2038 prolem patches to rebase to Philippe's tree.

Next steps:
1. Extensive test on v3.2 dev tree
2. Fix x32 is not working issue
3. Merge gdb issue fix patches
4. Enable contributor access to giblab bug tracking
5. EVL porting from Apr.


Thanks,
Rick

