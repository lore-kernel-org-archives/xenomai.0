From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <d4cab393-f878-55f5-a582-8c5f9c008056@numalliance.com>
Date: Fri, 23 Feb 2018 10:47:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] c++11 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

hi,


I have got problems using c++ 11 with tunables .compiling this snippet=20
code with -std=3Dc++0x gcc option fails to next error messages:

#include <xenomai/init.h>
#include <xenomai/tunables.h>



/nfs/solaris/AFFAIRES_ECLIPSE/DEVELOPPEMENT/DEVELOPPEMENTS_RD/DEBIAN_64BI=
TS/sancelot/KERNEL/TARGET/usr/xenomai-3.0-igb/include/boilerplate/tunable=
s.h:40:43:=20
error: variable or field '__assign_cpu_affinity_config' declared void
 =C2=A0 void __tunable_set_call(__name, __scope)(typeof(__type) __val)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
/nfs/solaris/AFFAIRES_ECLIPSE/DEVELOPPEMENT/DEVELOPPEMENTS_RD/DEBIAN_64BI=
TS/sancelot/KERNEL/TARGET/usr/xenomai-3.0-igb/include/boilerplate/tunable=
s.h:46:2:=20
note: in expansion of macro '__define_tunable'
 =C2=A0 __define_tunable(__name, __type, __val, config)
 =C2=A0 ^
/nfs/solaris/AFFAIRES_ECLIPSE/DEVELOPPEMENT/DEVELOPPEMENTS_RD/DEBIAN_64BI=
TS/sancelot/KERNEL/TARGET/usr/xenomai-3.0-igb/include/boilerplate/tunable=
s.h:72:15:=20
note: in expansion of macro 'define_config_tunable'
 =C2=A0static inline define_config_tunable(cpu_affinity, cpu_set_t, cpus)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ^
/nfs/solaris/AFFAIRES_ECLIPSE/DEVELOPPEMENT/DEVELOPPEMENTS_RD/DEBIAN_64BI=
TS/sancelot/KERNEL/TARGET/usr/xenomai-3.0-igb/include/boilerplate/tunable=
s.h:40:56:=20
error: expected primary-expression before ')' token
 =C2=A0 void __tunable_set_call(__name, __scope)(typeof(__type) __val)


Regards,

S.ancelot

