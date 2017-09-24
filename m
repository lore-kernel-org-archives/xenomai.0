References: <CAB6vvjnpmzM7U0baR3JTpzziFtoKd9KgPWBk0faYNFSYt+MC2A@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a6a27622-2f86-ff8b-ed7d-52309276dce4@xenomai.org>
Date: Sun, 24 Sep 2017 17:17:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAB6vvjnpmzM7U0baR3JTpzziFtoKd9KgPWBk0faYNFSYt+MC2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Boost thread macro confilct
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine Hoarau <hoarau.robotics@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/24/2017 04:52 PM, Antoine Hoarau wrote:
> Hi again,
> 
> I'm having some issues with boost threads macros. If I compile the
> following code :
> 
> #include <alchemy/task.h>
> #include <boost/thread.hpp>
> int main() { return 0; }
> 
> g++ b.cc $(xeno-config --alchemy --cflags)  $(xeno-config --alchemy
> --ldflags) -lboost_system -lboost_thread
> 
> It gives me a lot of errors regarding "barrier", a macro present in both
> librairies. Copperplate's debug macro also created similar issues with
> log4cpp lib.
> 
> It compiles only if :
> 1) Unsetting barrier from alchemy
> 
> #include <alchemy/task.h>
> #unset barrier
> #include <boost/thread.hpp>
> int main() { return 0; }
> 
> 2) Changing the order of the includes (easy here, but hard on a big library)
> 
> #include <boost/thread.hpp>
> #include <alchemy/task.h>
> int main() { return 0; }
> 
> I guess it's not a redefinition, but an overloading :
> 
> /usr/include/boost/thread/barrier.hpp:138:22: error: too many arguments
> provided to function-like macro invocation
>     explicit barrier(unsigned int count) :
>                      ^
> /usr/xenomai/include/boilerplate/atomic.h:83:9: note: macro 'barrier'
> defined here
> #define barrier()       __asm__ __volatile__("": : :"memory")
> 

We want to define a compiler barrier that represents a strong sequence
point in the instruction flow, this has nothing to do with a thread
synchronization method. We only have a very few instances of such
barriers, so the best fix is to rename our macro.

Please pull this change:
http://git.xenomai.org/xenomai-3.git/commit/?id=cd8815510e4ea53218a36518be09276bab21750d

-- 
Philippe.

