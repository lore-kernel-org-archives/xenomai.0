MIME-Version: 1.0
From: Cris Almaraz <cristina.almaraz@gmail.com>
Date: Wed, 10 Jul 2019 15:25:32 +0200
Message-ID: <CALTC7XLtQUJ9xqwAbURTDeCHzJouAUjz1Lj0nhMovsEeL0q0EQ@mail.gmail.com>
Subject: [Xenomai] c++11 issue
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi all,

I have a problem similar to the one described in
https://xenomai.org/pipermail/xenomai/2018-February/038373.html.

Compiling with -std=3Dc++11 and adding the headers:
    #include <xenomai/init.h>
    #include <xenomai/tunables.h>

Error extract:
In file included from /usr/xenomai/include/xenomai/tunables.h:21:0,
                 from myApplication.cpp:
/usr/xenomai/include/boilerplate/tunables.h:72:15: error: variable or
field =E2=80=98__assign_cpu_affinity_config=E2=80=99 declared void  static =
inline
define_config_tunable(cpu_affinity, cpu_set_t, cpus)
               ^
/usr/xenomai/include/boilerplate/tunables.h:72:15: error: expected
primary-expression before =E2=80=98)=E2=80=99 token  static inline
define_config_tunable(cpu_affinity, cpu_set_t, cpus) ...

Do you have any ideas how to solve the issue? I noticed that there is
no answer for the previous mail.

Thank you in advance and best regards,
Cristina.

System configuration:
Xenomai 3.0.9 Core Mercury
CentOS 7.4

