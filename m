Message-ID: <53E92A8D.8030505@xenomai.org>
Date: Mon, 11 Aug 2014 22:41:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEGbdidABiixUba3TiheYcLx1Swh5TrTbt_FtenZsExq7weUYg@mail.gmail.com>
In-Reply-To: <CAEGbdidABiixUba3TiheYcLx1Swh5TrTbt_FtenZsExq7weUYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] C++ std::thread and xenomai pthread
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthew Lindner <mattlindn@gmail.com>, xenomai@xenomai.org

On 08/11/2014 05:33 PM, Matthew Lindner wrote:
> Has anyone experimented with using std::thread from the C++ STL library? I
> am curious if it automatically incorporates the xenomai pthread API layer
> or whether it bypasses that and accesses the linux pthread library.

If the call to pthread_create (for instance), is in the libstdc++
library, and this library is dynamic, then the library needs to be
recompiled to use Xenomai's __wrap_pthread_create instead of
pthread_create. If the library is static, then you can wrap
pthread_create to __wrap_pthread_create when linking the library with
your program.


-- 
                                                                Gilles.

