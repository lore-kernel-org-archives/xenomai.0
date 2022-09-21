Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2307A7C
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 18:45:22 +0000 (UTC)
Received: from [192.168.1.112] (87-95-49-149.bb.dnainternet.fi [87.95.49.149])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ilmai)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 02C2C1B00215
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 21:39:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1663785572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HHKDkO3oeml/RWCIxIqLpECZlKtsFyWgA7LtFT9iUSk=;
	b=S6GTabD07ZyAE8K7ake/kRQvV/qJzQXaUUBdbB7M7MkgdplSh6Xptlhe/dO+PYymiXhhxm
	WWY3R9f5BZ54vldHTEv0BCIOovzSInMDD+Aqk2ylNO//BXPN5xNoz6naoocA/9xcyfb7p+
	l1PMG6B8SBGhoPK1tRsKybjcOdryZBfnyc/VSdME67ZSV2PgD+7x5suMeZAZVDK6swHjE1
	cdxQ8P+BsHbmLnU+NYtoj66dNTwMR6nSCr5vw3WF2fZbp1NvkQmvVgPh8JZa+9MvdIclpj
	AFs2lZR4Rf2Qs7L7ZQrEMNk3kR0udJbYL+meMzr8Je9hWm9BxsdRfU/FMon7sg==
Message-ID: <46bb98c5-43a3-f952-8251-13196dcdcf1f@iki.fi>
Date: Wed, 21 Sep 2022 21:39:31 +0300
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
From: Jussi Viiri <ilmai@iki.fi>
Subject: [PATCH] revl: Add sched() to thread::Builder
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=ilmai smtp.mailfrom=ilmai@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1663785572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HHKDkO3oeml/RWCIxIqLpECZlKtsFyWgA7LtFT9iUSk=;
	b=L/usHcsc/dVyalRmdAUmvdqfVFYP9/4caB2Eq3kCQps6NxASvvoSIOpjpFU0e/ynCPCZVC
	iI20OrnA4gJrztGo8f/RiqFgeimZHJH9HCM7LmLimgHMKsiq6tCrEZPdiFPKD+hq8IDhy2
	A1ZBsnD3UIhjcO9Wzfhiq7+Da958wbSK8el/XQBYglKyCLsINVbTWwJWrcp++shSjLjiEj
	F87al1ETYyG/FKqsEXH90hb/BddF15xTFjHSibEsFU3LSYcZ4vdCsHooqk6dty7vs+3p2g
	u9MWCRp8pwOvvjXZwRsSBqrYdPgPKx+jWxELg7hSAV8qDfBdmjvtTCBK6E675Q==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1663785572; a=rsa-sha256;
	cv=none;
	b=Rm3Um5yT/VNaly2sQtodEkN/ETcql5uR/OnSCLwfC3dPCWGsN4JokNLQXP5EutoEbll2ct
	Dh6gV/a809620ZgyCd9XiQGSy+Z2Hm3UbmrR/XwbTBFgIraEUZ68rbCCP8uW0+EFBUlBL6
	7qi0A2xC2prODd8E3A0b2eMqYb/IISuvC78x+9v3zExZriALRLQX8OZavWdgJW5c1fauRC
	Q/idZ1s7LUzHLM+53+t76AAD56ScMTERrp5cgYpOmOmuQdw7yuBY/LfuRO04b4fKv4frSP
	x/yY3dCPRWkPsqvDKm43h/EL3xiEQdVrE07EzOcNsgqE+PzTH3SeY+rljJymLQ==

When spawning threads with Builder, it wasn't possible to set the scheduling policy of the spawned thread as you don't have access to the Thread object after spawning. Added that option to Builder.

Signed-off-by: Jussi Viiri <ilmai@iki.fi>

---

  src/thread.rs | 27 ++++++++++++++++++++++++---
  1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/src/thread.rs b/src/thread.rs
index d487658..b0300af 100644
--- a/src/thread.rs
+++ b/src/thread.rs
@@ -11,6 +11,7 @@ use std::ptr;
  use std::os::raw::c_int;
  use std::io::Error;
  use std::ffi::CString;
+use evl_sys::SchedPolicy;
  use evl_sys::{
      evl_attach_thread,
      evl_unblock_thread,
@@ -29,6 +30,7 @@ pub struct Builder {
      visible: bool,
      observable: bool,
      unicast: bool,
+    sched: sched::SchedAttrs,
  }
  
  impl Builder {
@@ -53,6 +55,7 @@ impl Builder {
              visible: false,
              observable: false,
              unicast: false,
+            sched: sched::get_zero_attrs(),
          }
      }
      /// Set the thread name. This name must conform to the [naming
@@ -106,6 +109,11 @@ impl Builder {
          self.unicast = true;
          self
      }
+    // Set scheduling policy for the thread
+    pub fn sched(mut self, policy: impl sched::PolicyParam) -> Self {
+        self.sched = policy.to_attr();
+        self
+    }
      /// Attach the calling thread to the EVL core, consuming the
      /// builder.
      ///
@@ -257,11 +265,24 @@ impl Thread {
  	        evl_attach_thread(c_flags, ptr::null())
              }
  	};
+
  	// evl_attach_thread() returns a valid file descriptor or -errno.
-	match ret {
-	    0.. => return Ok(Thread(ret)),
-            _ => return Err(Error::from_raw_os_error(-ret)),
+    let thread = Thread(ret);
+
+    if builder.sched.0.sched_policy as i32 != 0 {
+        let c_attrs_ptr: *const evl_sched_attrs = &builder.sched.0;
+        let ret: c_int = unsafe { evl_set_schedattr(thread.0, c_attrs_ptr) };
+        if ret != 0 {
+            return Err(Error::from_raw_os_error(-ret));
          }
+    }
  
+    Ok(thread)
      }
      /// Unblock the target thread.
      ///
-- 
2.34.1


