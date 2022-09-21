Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE9E7C
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 20:23:13 +0000 (UTC)
Received: from [192.168.1.112] (87-95-49-149.bb.dnainternet.fi [87.95.49.149])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ilmai)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id E3A2F1B000EF
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 23:23:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1663791789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypA3Ic75+5hVFutY9k20OAoOiarQnrMqlEZxIJTM/UE=;
	b=Ugw44Z/SGuSWXQmNdhwnKF904wXT0YGDhA50Ko2Zyt6nLNf4MM0ehdwKHixDREIn5Wdvxy
	QS/P2SGz2dlSC+9yGrKmMuiWoKkueh6UzAZjfa2bw/wFv2CohJQ7SDUGz5bMv5x8Edm4wU
	ILMbLtXercJeT6bHhU8GktexN2tPW+LknUBUXQqrF+m2cTiN+26knMB2ygbAVEv4IX0trQ
	pf0jRBKJuSj8x1uSMbxW6UQ7MiYlavIaNkzhi7GhgE0iGwIvYMubM3a/6xE3r1XRjbIOFi
	yU0c4Vrvc3p+fcMeHrttQbFx9ZYtW95OAD7bYaLY14i1rTmqKnyRJuK+q8vbVQ==
Message-ID: <4fe656c4-f90f-31bd-9f92-938a412109a9@iki.fi>
Date: Wed, 21 Sep 2022 23:23:09 +0300
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] revl: Add sched() to thread::Builder
Content-Language: en-US
From: Jussi Viiri <ilmai@iki.fi>
To: xenomai@lists.linux.dev
References: <gTXdwUk_bKng2MQYwbdY-wCvewR2NZOyi9XxSpkGlR0GL4SerQi2RIneMs5e421_D69U1vjgdpCUDWfmQW56Bw==@protonmail.internalid>
 <46bb98c5-43a3-f952-8251-13196dcdcf1f@iki.fi>
In-Reply-To: <46bb98c5-43a3-f952-8251-13196dcdcf1f@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=ilmai smtp.mailfrom=ilmai@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1663791789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypA3Ic75+5hVFutY9k20OAoOiarQnrMqlEZxIJTM/UE=;
	b=PXqK9pV6eNM79a6HaHGzOgooGtIqDSZ1cUHS0YFAlCfuG5PLq6MoSaXMWpyzb0SVAsDyCd
	qayfdZ1ZMPnArMt7AiQO6TVijDxWfLnmjXzzM40lVNgkpVHKZhOnPCds5jVluojU9INDMm
	9gt2COZ3fAG12vOVBDOmFqqMjt72dddxnslQ7YoYrpZzJ0fY4oJ1IMOUISU0r8R/gWU4rX
	aaKdC8QK0vlhp9nM1pUSm+Db+HXJSRQpKCmsF4fRAFUivV41ABz+ZtprPgDn4jvZmVk5gf
	TEZTTpAw+4F4rB+i0KG8wJbjO2ibWrafS5e19ufsoAmQ4AM86XabLzCshg+5CQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1663791789; a=rsa-sha256;
	cv=none;
	b=CfgmIY1ZDcGNQ7xF7Ye32Yu6j/qzaYuMd3KPFBNHTSLkO1HBolKqBGKLglI0Cn8z8hQyI9
	+5gsYotShcG4LCM+BWXLhUD2PuIQ/LM5sjGvGVKooqCG2UIJSDLm34WOd6Y3fsGvqKGqcp
	vZID/jLeP4IEnkRscU9P3ZWICEmRLa3qpStcsmWyv5RdHNWWtTP0XZtHDDtis6VJr/WvgZ
	KtzaFMJhAQW3AE4gzaYEtfPIAtc7ouMBcmcZpUPvutf7+rw3f+E7LfxkD4unMOOeBDWZYq
	vnyKzJG19r/hFh+q1WzW/ZMjUCtKGwHHNnb8jIQisFYOLDOftK4/JST4dWzcuw==

Looks like I accidentally submitted the wrong patch. Here's the correct one:

--- a/src/thread.rs
+++ b/src/thread.rs
@@ -29,6 +29,7 @@ pub struct Builder {
      visible: bool,
      observable: bool,
      unicast: bool,
+    sched: sched::SchedAttrs,
  }

  impl Builder {
@@ -53,6 +54,7 @@ impl Builder {
              visible: false,
              observable: false,
              unicast: false,
+            sched: sched::get_zero_attrs(),
          }
      }
      /// Set the thread name. This name must conform to the [naming
@@ -106,6 +108,11 @@ impl Builder {
          self.unicast = true;
          self
      }
+    // Set scheduling policy for the thread
+    pub fn sched(mut self, policy: impl sched::PolicyParam) -> Self {
+        self.sched = policy.to_attr();
+        self
+    }
      /// Attach the calling thread to the EVL core, consuming the
      /// builder.
      ///
@@ -257,11 +264,23 @@ impl Thread {
              evl_attach_thread(c_flags, ptr::null())
              }
      };
+
      // evl_attach_thread() returns a valid file descriptor or -errno.
-    match ret {
-        0.. => return Ok(Thread(ret)),
-            _ => return Err(Error::from_raw_os_error(-ret)),
-    };
+    if ret < 0 {
+        return Err(Error::from_raw_os_error(-ret));
+    }
+
+    let thread = Thread(ret);
+
+    if builder.sched.0.sched_policy as i32 != 0 {
+        let c_attrs_ptr: *const evl_sched_attrs = &builder.sched.0;
+        let ret: c_int = unsafe { evl_set_schedattr(thread.0, 
c_attrs_ptr) };
+        if ret != 0 {
+            return Err(Error::from_raw_os_error(-ret));
+        }
+    }
+
+    Ok(thread)
      }
      /// Unblock the target thread.
      ///

On 21.9.2022 21.39, Jussi Viiri wrote:
> When spawning threads with Builder, it wasn't possible to set the scheduling policy of the spawned thread as you don't have access to the Thread object after spawning. Added that option to Builder.
>
> Signed-off-by: Jussi Viiri <ilmai@iki.fi>
>
> ---
>
>    src/thread.rs | 27 ++++++++++++++++++++++++---
>    1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/src/thread.rs b/src/thread.rs
> index d487658..b0300af 100644
> --- a/src/thread.rs
> +++ b/src/thread.rs
> @@ -11,6 +11,7 @@ use std::ptr;
>    use std::os::raw::c_int;
>    use std::io::Error;
>    use std::ffi::CString;
> +use evl_sys::SchedPolicy;
>    use evl_sys::{
>        evl_attach_thread,
>        evl_unblock_thread,
> @@ -29,6 +30,7 @@ pub struct Builder {
>        visible: bool,
>        observable: bool,
>        unicast: bool,
> +    sched: sched::SchedAttrs,
>    }
>
>    impl Builder {
> @@ -53,6 +55,7 @@ impl Builder {
>                visible: false,
>                observable: false,
>                unicast: false,
> +            sched: sched::get_zero_attrs(),
>            }
>        }
>        /// Set the thread name. This name must conform to the [naming
> @@ -106,6 +109,11 @@ impl Builder {
>            self.unicast = true;
>            self
>        }
> +    // Set scheduling policy for the thread
> +    pub fn sched(mut self, policy: impl sched::PolicyParam) -> Self {
> +        self.sched = policy.to_attr();
> +        self
> +    }
>        /// Attach the calling thread to the EVL core, consuming the
>        /// builder.
>        ///
> @@ -257,11 +265,24 @@ impl Thread {
>    	        evl_attach_thread(c_flags, ptr::null())
>                }
>    	};
> +
>    	// evl_attach_thread() returns a valid file descriptor or -errno.
> -	match ret {
> -	    0.. => return Ok(Thread(ret)),
> -            _ => return Err(Error::from_raw_os_error(-ret)),
> +    let thread = Thread(ret);
> +
> +    if builder.sched.0.sched_policy as i32 != 0 {
> +        let c_attrs_ptr: *const evl_sched_attrs = &builder.sched.0;
> +        let ret: c_int = unsafe { evl_set_schedattr(thread.0, c_attrs_ptr) };
> +        if ret != 0 {
> +            return Err(Error::from_raw_os_error(-ret));
>            }
> +    }
>
> +    Ok(thread)
>        }
>        /// Unblock the target thread.
>        ///
> --
> 2.34.1
>
>
>
