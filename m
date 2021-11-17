From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: compile error about TODO after make 
Date: Wed, 17 Nov 2021 08:33:59 +0000
Message-ID: <MN2PR11MB428569A16DE7BAB22F23FC9EF29A9@MN2PR11MB4285.namprd11.prod.outlook.com>
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>

Hi Jan

Internally , we try to do some basic validation for linux_dovetail branch. =
One of test is to
pass build after make allyesconfig. But it would fail because of enabled CO=
NFIG_XENO_TODO.=20
There is still something NTD in  include/cobalt/kernel/dovetail/pipeline/tr=
ace.h and=20
include/cobalt/kernel/dovetail/pipeline/clock.h related to this config. I a=
m tying to=20
look into TODO in include/cobalt/kernel/dovetail/pipeline/clock.h but I do =
not know how to fix
TODO in include/cobalt/kernel/dovetail/pipeline/trace.h. Could you suggest =
something about
fixing them?


Regards

Hongzhan Chen


