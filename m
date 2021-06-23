From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: about issue #14  on xenomai-hacker-space
Date: Wed, 23 Jun 2021 02:54:19 +0000
Message-ID: <BN9PR11MB5227421B89F9B4FBD590E6E7F2089@BN9PR11MB5227.namprd11.prod.outlook.com>
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>

Hi Jan

I do not know if the issue #14 you reported is about  "cpu_affinity skipped=
 (no kernel support)" in log [1].
The issue "cpu_affinity skipped (no kernel support)" is because there is no=
 non-RT cpu found in system=20
and we may pass xenomai.supported_cpus in commandline to restrict RT cpu to=
 fix it.


[1]: https://source.denx.de/Xenomai/xenomai-images/-/jobs/281066


Regards

Hongzhan Chen


