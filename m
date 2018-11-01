Subject: Re: Problem when binding a queue (rt_queue_bind) on Xenomai 3
References: <CAMDdWuz_CkFKsE1oo5AjLEUOEpmVNQhQxGbJ8pP7hdOPQnqONg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <efcb961b-ffe1-3d19-86ea-c47613b80d77@xenomai.org>
Date: Thu, 1 Nov 2018 09:34:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAMDdWuz_CkFKsE1oo5AjLEUOEpmVNQhQxGbJ8pP7hdOPQnqONg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matheus Pinto <lpinto.matheus@gmail.com>, xenomai@xenomai.org

On 10/31/18 11:00 PM, Matheus Pinto wrote:
> I am trying to simple bind a queue in a task on a executable file, where
> the queue is created on another task on another executable file.
> The queue is created normally, no error is sent. In both task I use the
> exactly same string name to identify the queue when created in one task
> (rt_queue_create) and binded in the other task (rt_queue_bind). When I try
> bind the queue in another task with rt_queue_bind, a error is returned.

You probably need to build the user-space system with --enable-pshared
passed to the configure script, which enables sharing of objects between
different processes. In that mode, most objects created by the alchemy
API are defined in a global namespace which can be shared by multiple
processes belonging to the same so-called "session" (--session switch).
See [1] and [2].

> However, the error dont fit in anyone errors described on API, or in
> "/usr/include/asm-generic/errno-base.h"  and
> "/usr/include/asm-generic/errno.h" . The error value is -110.
> 

I believe it is documented as -ETIMEDOUT for rt_queue_bind(), which
timed out (only the remote process creating the queue knows about it,
unless --enable-pshared is given).

[1] https://gitlab.denx.de/Xenomai/xenomai/wikis/App_Setup_And_Init
[2] https://gitlab.denx.de/Xenomai/xenomai/wikis/Installing_Xenomai_3

-- 
Philippe.

