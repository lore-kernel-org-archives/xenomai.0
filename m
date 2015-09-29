Date: Tue, 29 Sep 2015 20:55:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150929185525.GC18188@hermes.click-hack.org>
References: <20150929012542.GC15767@hermes.click-hack.org>
 <1443489996-3001-1-git-send-email-gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1443489996-3001-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai] [PATCH] ipipe/tracer: allow hrclock late init
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Tue, Sep 29, 2015 at 03:26:36AM +0200, Gilles Chanteperdrix wrote:
> diff --git a/include/linux/ipipe_trace.h b/include/linux/ipipe_trace.h
> index deb0a47..edea346 100644
> --- a/include/linux/ipipe_trace.h
> +++ b/include/linux/ipipe_trace.h
> @@ -32,6 +32,7 @@
>  #define __BUILTIN_RETURN_ADDRESS1 ((unsigned long)__builtin_return_address(1))
>  #endif /* !BUILTIN_RETURN_ADDRESS */
>  
> +void __ipipe_tracer_hrclock_initialized(void);
>  void ipipe_trace_begin(unsigned long v);
>  void ipipe_trace_end(unsigned long v);
>  void ipipe_trace_freeze(unsigned long v);
> @@ -43,6 +44,7 @@ int ipipe_trace_frozen_reset(void);
>  
>  #else /* !CONFIG_IPIPE_TRACE */
>  
> +#define __ipipe_tracer_hrclock_initialized()	do { } while(0)
>  #define ipipe_trace_begin(v)			do { (void)(v); } while(0)
>  #define ipipe_trace_end(v)			do { (void)(v); } while(0)
>  #define ipipe_trace_freeze(v)			do { (void)(v); } while(0)

The function __ipipe_tracer_hrclock_initialized() function is an
internal function, so has no reason to be in the linux/ipipe_trace.h
header, which contains the ipipe tracer public API. The following
patch moves it to linux/ipipe.h where all the I-pipe internal
functions are declared.

-- 
					    Gilles.
https://click-hack.org

