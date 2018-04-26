References: <ca00a2b2-b44d-a25a-cb53-852a0f8e2d32@gmail.com>
 <594f0ba9-8e01-d2d2-a58e-2abcb3b72289@gmail.com>
 <fb226301-fe52-c9c9-f5a0-3f760b8d5492@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <74da7f07-6df9-5a5f-ff63-b414437749b2@xenomai.org>
Date: Thu, 26 Apr 2018 17:30:02 +0200
MIME-Version: 1.0
In-Reply-To: <fb226301-fe52-c9c9-f5a0-3f760b8d5492@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Crash with longer dlopen/dlcose sequence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Edouard Tisserant <edouard.tisserant@gmail.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 04/26/2018 11:24 AM, Edouard Tisserant wrote:
> One more question. Sorry for flooding the list.
> 
> As a workaround to avoid leaking memory, I would like to try this :
> 
>  - xeno_stub.so : stub library, linked with bootstrap-pic.o
>  - 1.so, 2.so, ... n.so : libraries calling alchemy/posix realtime
> resources, NOT linked with bootstrap-pic.o
> 
> Process life-cycle would be :
> 
> - process start
> 
> dlopen(xeno_stub.so)
> 
> dlopen(1.so)
> dlsym + call 1.so
> dlclose(1.so)
> ...
> dlopen(n.so)
> dlsym + call n.so
> dlclose(n.so)
> 
> dlclose(xeno_stub.so)
> 
> - process end
> 
> Is that correct to assume that this way, pointers setup while calling
> xenomai_init() as a side effect of first dlopen() would stay valid while
> other non-bootstrap-pic libraries are loaded and unloaded ?

If by pointer setup, you mean all the init stuff run by the various
Xenomai libraries when called on behalf of xenomai_init(), then yes. The
bootstrap mechanism should be able to support the lifecycle described above.

The init sequence is explained here:
http://xenomai.org/2015/05/application-setup-and-init/#Initialization_sequence

This document refers to the bootstrap module included in the main
executable, but same logic would apply to DSOs which include
bootstrap-pic such as xeno_stub.so.

-- 
Philippe.

