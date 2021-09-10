From: "Wang, Rick Y" <rick.y.wang@intel.com>
Subject: Xenomai Community Call Minutes - September 8, 2021
Date: Fri, 10 Sep 2021 03:07:08 +0000
Message-ID: <CO6PR11MB5649D49F10D38A691DF02E14BAD69@CO6PR11MB5649.namprd11.prod.outlook.com>
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
Jan Kiszka, Philippe, Florian Bezdeka, Hongzhan Chen,=20
Hao Li, Jianbo Cao, Rick Wang


*Community update

- Xenomai 3.2-rc1 released. Call for testing!
  1. GPIO timestamp issue resolved.=20
  2. Some issues reported in mailing list.
  3. Observation on performance regression. Tracing on spikes.
     Investigating functions, kernel configs, debug switches, SMIs, etc.

- Xenomai + KVM
  1. It's OK to make RT workload running on native Xenomai. Non-RT workload=
=20
     running inside KVM guest OS.
  2. Can't enable Xenomai in KVM guest OS.
 =20


Thanks,
Rick

