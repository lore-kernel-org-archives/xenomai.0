MIME-Version: 1.0
In-Reply-To: <a6a27622-2f86-ff8b-ed7d-52309276dce4@xenomai.org>
References: <CAB6vvjnpmzM7U0baR3JTpzziFtoKd9KgPWBk0faYNFSYt+MC2A@mail.gmail.com>
 <a6a27622-2f86-ff8b-ed7d-52309276dce4@xenomai.org>
From: Antoine Hoarau <hoarau.robotics@gmail.com>
Date: Sun, 24 Sep 2017 20:19:45 +0200
Message-ID: <CAB6vvj=PpNw_zdk0KD8w3OY_Rqz0BACCNOX7oE4HRCjtuAiSrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Boost thread macro confilct
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

2017-09-24 17:17 GMT+02:00 Philippe Gerum <rpm@xenomai.org>:
> On 09/24/2017 04:52 PM, Antoine Hoarau wrote:
>> Hi again,
>>
>> I'm having some issues with boost threads macros. If I compile the
>> following code :
>>
>> #include <alchemy/task.h>
>> #include <boost/thread.hpp>
>> int main() { return 0; }
>>
>> g++ b.cc $(xeno-config --alchemy --cflags)  $(xeno-config --alchemy
>> --ldflags) -lboost_system -lboost_thread
>>
>> It gives me a lot of errors regarding "barrier", a macro present in both
>> librairies. Copperplate's debug macro also created similar issues with
>> log4cpp lib.
>>
>> It compiles only if :
>> 1) Unsetting barrier from alchemy
>>
>> #include <alchemy/task.h>
>> #unset barrier
>> #include <boost/thread.hpp>
>> int main() { return 0; }
>>
>> 2) Changing the order of the includes (easy here, but hard on a big libr=
ary)
>>
>> #include <boost/thread.hpp>
>> #include <alchemy/task.h>
>> int main() { return 0; }
>>
>> I guess it's not a redefinition, but an overloading :
>>
>> /usr/include/boost/thread/barrier.hpp:138:22: error: too many arguments
>> provided to function-like macro invocation
>>     explicit barrier(unsigned int count) :
>>                      ^
>> /usr/xenomai/include/boilerplate/atomic.h:83:9: note: macro 'barrier'
>> defined here
>> #define barrier()       __asm__ __volatile__("": : :"memory")
>>
>
> We want to define a compiler barrier that represents a strong sequence
> point in the instruction flow, this has nothing to do with a thread
> synchronization method. We only have a very few instances of such
> barriers, so the best fix is to rename our macro.
>
> Please pull this change:
> http://git.xenomai.org/xenomai-3.git/commit/?id=3Dcd8815510e4ea53218a3651=
8be09276bab21750d
>
> --
> Philippe.

Excellent, that fixes the barrier problem.
There's now also clz and cls in boilerplate/compiler.h, that conflicts
with libtbb, and debug() in copperplate/debug.h, that conflicts with a
lot of libs I use.


I really don't know why the compiler gets so confused, here's an example :

#include <alchemy/task.h>

struct A
{
A():debug(0){}
bool debug;
};

int main() { return 0; }

The build returns :

/usr/xenomai/include/copperplate/debug.h:38:30: error: expected
identifier before =E2=80=98do=E2=80=99
 #define debug(fmt, args...)  do { } while (0)
                              ^
/home/hoarau/dev/boost-xeno3/b.cc:6:6: note: in expansion of macro =E2=80=
=98debug=E2=80=99
  A():debug(0){}
      ^

hack-fix using #define _COPPERPLATE_DEBUG_H before including xeno3 headers.

