References: <144decef-a102-1cee-a9b1-8be5ed0d1258@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <04a6b929-41ea-1024-6c01-11a5072d1c20@xenomai.org>
Date: Sat, 13 Oct 2018 15:52:48 +0200
MIME-Version: 1.0
In-Reply-To: <144decef-a102-1cee-a9b1-8be5ed0d1258@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [ipipe 4.14][PATCH] x86: ipipe: Fix trap hooking for
 userspace routes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 10/10/2018 01:05 PM, Jan Kiszka wrote:
> Also hook into the trap path when the exception was taken over userspace
> code.
> 
> Fixes: e6b81a0ce7fb (x86: ipipe: route traps to co-kernel)
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Makes sense? I'm not feeling 100% safe yet /wrt paranoid and the
> userspace path. Should we handle this identically to the kernel path or
> not?
> 

It looks ok to me. We should always branch to error_exit in the paranoid
case for the user path, never taking the fast path out. This is
particularly important for handling debug traps properly.

-- 
Philippe.

