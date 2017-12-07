References: <48bfcc92-3224-c7ce-10d9-9f4621e10331@tuebingen.mpg.de>
 <d009beb3-49d6-b318-e872-51ce93e49cf2@xenomai.org>
 <3fd685e2-b399-34c7-8529-48edc391712b@tuebingen.mpg.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <613f564f-97c2-6f52-9da7-d5c0c59462ae@xenomai.org>
Date: Thu, 7 Dec 2017 15:16:27 +0100
MIME-Version: 1.0
In-Reply-To: <3fd685e2-b399-34c7-8529-48edc391712b@tuebingen.mpg.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai 3.0.5 : RTIPC/XDDP protocol not supported by
 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Vincent Berenz <vberenz@tuebingen.mpg.de>, xenomai@xenomai.org

On 12/07/2017 02:42 PM, Vincent Berenz wrote:
> Many thanks for the answer
> 
> The demos xddp-echo , xddp-label and xddp-stream seems all to be working
> ok.
> 
> As sanity check, I copied xddp-echo.c to my workspace and compiled it
> with the rest of our code.
> 
> Compilation goes ok, but execution fails with message:
> 
>     socket: Address family not supported by protocol
> 
> This brought my attention to this:
> 
>    http://xenomai.org/pipermail/xenomai/2014-February/030113.html
> 
> which says:
> 
>   "Your application is likely not wrapping POSIX symbols properly, calling
>    regular socket() instead of the Xenomai implementation. "
> 
> We do things this way, possibly something is missing ?
> 

Yes, but this is most likely a different issue than the one observed
with rt_pipe_create() in compat mode.

>        0"000.000| WARNING: [main] RTIPC/XDDP protocol not supported by
kernel

There is likely an error number following this message, what is it?

>   exec_program(${XENOMAI_ROOT}/bin/xeno-config ARGS "--skin=native
> --cflags"
>                                                   OUTPUT_VARIABLE
> XENOMAI_C_FLAGS)
>   exec_program(${XENOMAI_ROOT}/bin/xeno-config ARGS "--skin=native
> --ldflags"
>     OUTPUT_VARIABLE XENOMAI_LD_FLAGS)
> 

You need --posix as well in the ldflags. However, caveat: adding this
flag will wrap all calls libcobalt shadows from the glibc (see
lib/cobalt/cobalt.wrappers). Or, you may omit --posix, explicitly
marking real-time calls by enclosing them with __RT().

e.g. __RT(socket(....));

Ugly, but in some cases handy when full wrapping is not a practical option.

-- 
Philippe.

