Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3D3626
	for <xenomai@lists.linux.dev>; Mon, 26 Sep 2022 07:43:02 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 07C39240010;
	Mon, 26 Sep 2022 07:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1664178175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6j64Ej4w8PKzmBA6PQepGZhmXNgCBQBc1AJ37+yZTg=;
	b=hZlt0DdAkNdsoxjN5qXkkJfiiuy1OtSuhehJQLvDfFs+tbHbreywYK/8IJM2bc8eHfeQZH
	N+Tf+rFET0mnKh2k3GKdpCS3imO0Wb2LUhtQ50n3XjbUFzZHw0nRJbUfVeODC8AyKfUE/q
	0cUcCQBLFFFBnkp5gFMgz3chE+UzjLZPxwJaH0a7hNk6Q1/6fPhSL4vU0A/sF/3v4hLTYa
	XpXIsmD855YIOZMIi9Sk8aTK2t9u/G0AMwCnc4rGlviw9RbNTggKLlJvU9+85vKXKBLJWV
	Y0YVOadBMlPK1LALSs9LpTu8fHkxHz/3dDckV9DW3Bw98XCdN6/kycJY/hbsdQ==
References: <46bb98c5-43a3-f952-8251-13196dcdcf1f@iki.fi>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Jussi Viiri <ilmai@iki.fi>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] revl: Add sched() to thread::Builder
Date: Mon, 26 Sep 2022 09:13:40 +0200
In-reply-to: <46bb98c5-43a3-f952-8251-13196dcdcf1f@iki.fi>
Message-ID: <87h70ushs2.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jussi Viiri <ilmai@iki.fi> writes:

> When spawning threads with Builder, it wasn't possible to set the scheduling policy of the spawned thread as you don't have access to the Thread object after spawning. Added that option to Builder.
>
> Signed-off-by: Jussi Viiri <ilmai@iki.fi>
>
> ---
>
>  src/thread.rs | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/src/thread.rs b/src/thread.rs
> index d487658..b0300af 100644
> --- a/src/thread.rs
> +++ b/src/thread.rs
> @@ -11,6 +11,7 @@ use std::ptr;
>  use std::os::raw::c_int;
>  use std::io::Error;
>  use std::ffi::CString;
> +use evl_sys::SchedPolicy;
>  use evl_sys::{
>      evl_attach_thread,
>      evl_unblock_thread,
> @@ -29,6 +30,7 @@ pub struct Builder {
>      visible: bool,
>      observable: bool,
>      unicast: bool,
> +    sched: sched::SchedAttrs,

       sched: Option<SchedAttrs>,

I would rather use an option here, zero as a sched_policy currently
means SCHED_OTHER/NORMAL. Assuming zero is the 'unset' policy value
would cause this policy setting to be ignored by Thread::attach().

Granted, we are missing the definition of SchedOther as a unit type (and
its PolicyParam trait implementation) in sched.rs as well, so that we
may apply SCHED_OTHER to the caller (SCHED_OTHER is an alias to
(SCHED_WEAK,0) for the EVL core).

>  }
>    impl Builder {
> @@ -53,6 +55,7 @@ impl Builder {
>              visible: false,
>              observable: false,
>              unicast: false,
> +            sched: sched::get_zero_attrs(),

               sched: None,

>          }
>      }
>      /// Set the thread name. This name must conform to the [naming
> @@ -106,6 +109,11 @@ impl Builder {
>          self.unicast = true;
>          self
>      }
> +    // Set scheduling policy for the thread
> +    pub fn sched(mut self, policy: impl sched::PolicyParam) -> Self {
> +        self.sched = policy.to_attr();
> +        self
> +    }
>      /// Attach the calling thread to the EVL core, consuming the
>      /// builder.
>      ///
> @@ -257,11 +265,24 @@ impl Thread {
>  	        evl_attach_thread(c_flags, ptr::null())
>              }
>  	};
> +
>  	// evl_attach_thread() returns a valid file descriptor or -errno.
> -	match ret {
> -	    0.. => return Ok(Thread(ret)),
> -            _ => return Err(Error::from_raw_os_error(-ret)),
> +    let thread = Thread(ret);
> +
> +    if builder.sched.0.sched_policy as i32 != 0 {
> +        let c_attrs_ptr: *const evl_sched_attrs = &builder.sched.0;

Consequently, we could have something a bit more idiomatic instead:

       if let Some(attrs) = builder.sched {
               let c_attrs_ptr: *const evl_sched_attrs = &attrs.0;
               ...
       }

-- 
Philippe.
