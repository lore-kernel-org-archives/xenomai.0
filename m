Subject: Re: [PATCH][3.0-backport] cobalt: syscall: don't bark at internal
 syscalls
References: <268ab3b0-cc0d-531c-1494-547871ea3eac@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <bbf26ac5-cbfb-9000-ebda-3189636404bf@xenomai.org>
Date: Wed, 24 Jul 2019 21:36:12 +0200
MIME-Version: 1.0
In-Reply-To: <268ab3b0-cc0d-531c-1494-547871ea3eac@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 7/24/19 9:20 PM, Jan Kiszka wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> Some architectures may define a secondary system call range for
> internal operations, fix the consistency check not to warn about them.
> 
> [Jan: backport to 3.0.x, taking care of ipipe_root_nr_syscalls moving]
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> I noticed that we want this not only for secondary ranges, also for
> running newer applications on older kernels when they probe for syscalls
> that did not yet existed back then.
> 

Ack.


-- 
Philippe.

