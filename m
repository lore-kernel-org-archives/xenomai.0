References: <2051280157.356274520.1476686698980.JavaMail.root@zimbra19-e3.priv.proxad.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <03f63e59-6773-ae07-3adc-1c0654cb55f4@xenomai.org>
Date: Mon, 17 Oct 2016 09:37:43 +0200
MIME-Version: 1.0
In-Reply-To: <2051280157.356274520.1476686698980.JavaMail.root@zimbra19-e3.priv.proxad.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [xenomai]:heap memory management
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: pierre.roumagnac@free.fr
Cc: xenomai@xenomai.org

On 10/17/2016 08:44 AM, pierre.roumagnac@free.fr wrote:
> For my culture can someone explain me (or provide doc) the difference between the memory pool create with --mem_pool_size and the 
> rt_heap_create api of alchemy?
> http://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__heap.html#ga1d19ad24dc9f94b969aa0f574170bdc4.

With Xenomai 3, any application process has access to a main memory
pool, whose size can be set explicitly using --mem-pool-size, 1Mb by
default. The Xenomai libraries allocate the dynamic memory they need
from this main pool, which can be shared between multiple processes if
you built the Xenomai code stack with the --enable-pshared option set.
This allows multi-process applications to share real-time objects such
as tasks, sema4, queues, heaps and so on.

Applications using the alchemy API may call rt_heap_create() to
initialize specific memory heaps for their own usage, whose memory is
pulled from the main pool; this way, such heaps inherit the
shared/private property of the main pool memory, depending on whether
--enable-pshared was given to the configure script.

Bottom line is that --enable-pshared should be set only for applications
composed of multiple concurrent processes which must share data and/or
real-time constructs; this feature should be left disabled otherwise.

See the command line options for any Xenomai 3 application:
http://xenomai.org/2015/05/application-setup-and-init/#Standard_Xenomai_command_line_options

-- 
Philippe.

