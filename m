Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B332D1FDA
	for <xenomai@lists.linux.dev>; Sat,  6 May 2023 10:40:20 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id C74AAC7F39
	for <xenomai@lists.linux.dev>; Sat,  6 May 2023 10:27:29 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id C4F4CE0004;
	Sat,  6 May 2023 10:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1683368842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XGWh3xP7nmxkqgIybRRlNcttCLSZpI8mIzOggFVBk7E=;
	b=VeUw9Bm+htRvOLvEqTesRf35ovmUd4icje3cruwoAbfKpIFp+3CadqqMruA/ykHMtgwGNk
	eJTX5qz2JYQlqXF/poL8gNosaKamS03nJXN5EYxN5pw9UmZmd97bBTpsHEyXZBdW/scGbW
	tNBhFuvEs94ARfbH0h+je1WinU0Lj9QFdkqS9JQMMqDtkEB88cLv+0v7xU2ZIkxFpHrjeA
	ZXDQq5C6p47BjOwlB+P1xlkjn80pbvw+rtwL5fL/7K30MfAUEvIp9tkgsopVpYji4L1OuC
	mqYYX1wDq4wXdW/+TWZ7GHsGCq8RGSAIrtKU091NDYsrdqIWooHwClqZvc9Nqg==
References: <PH1P110MB1050A5AEEBFDC5D7CA6F31A3E26E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Nickolas Heisler
 <Nickolas.Heisler@kratosdefense.com>
Subject: Re: evl_wait_event returning EIDRM
Date: Sat, 06 May 2023 12:08:26 +0200
In-reply-to: <PH1P110MB1050A5AEEBFDC5D7CA6F31A3E26E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87sfc9pxfb.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Hello,
>
> We are noticing on occasion evl_wait_event will return an EIDRM error, and
> the program will freeze up. I have created a test hosted in github
> https://github.com/nickolasheisler/evl_wait_event_error that consistently
> reproduces this error. Please take a look at this and let us know if you can
> figure out what is going on. Please let me know if you do not have access to
> the link, and I will add you. For now, I added rpm@xenomai.org because that
> is the only I have seen associated with your correspondence. 
>
> Thanks,
>
> Russell
>
> [[End of S/MIME Signed Part]]

In this particular case, the test code is at fault, not EVL. The patch
below illustrates how to addresses them.

The basic issue of receiving EINTR is caused by assigning both
semaphores to the same global smart pointer (m_dataSemaphore). The
second assignment causes the object dtor to run, which in turn deletes
the underlying EVL event, yielding EIDRM while Thread1 waits on it, as
expected.

Next, there are two causes for the apparent lockup, also in the test
code. The first one is about properly detecting errors in wait loops,
such as semaphore::take(). Failing to do so causes the thread to enter a
runaway loop, since EVL would repeatedly deny the wait syscall after the
event is deleted. Enabling CONFIG_EVL_WATCHDOG would detect such
situations, it consistently triggered when running the test app here.

The other issue is about releasing Thread1 from waiting on the event
before main() leaves, otherwise the app would block in the crt exit
code, waiting for all joinable threads to terminate. I chose to signal
the event in order to force a release, detaching Thread1 when creating
it would be another way.

diff --git a/condition_variable.cpp b/condition_variable.cpp
index 2af9edc..65ec770 100644
--- a/condition_variable.cpp
+++ b/condition_variable.cpp
@@ -20,16 +20,17 @@ condition_variable::~condition_variable()
 }
 
 ///////////////////////////////////////////////////////////////////////////////
-void condition_variable::wait(std::unique_lock<evl::mutex>& lock)
+int condition_variable::wait(std::unique_lock<evl::mutex>& lock)
 {
     int rv = evl_wait_event(&m_cv, lock.mutex()->get_raw_mutex());
 
     // If EIDRM is returned, then the event is no longer valid
     if (rv == -EIDRM)
     {
-        create();
-        evl_printf("evl_wait_event returned EIDRM and a new event was created\n");
+        evl_printf("evl_wait_event returned EIDRM\n");
     }
+
+    return rv;
 }
 
 ///////////////////////////////////////////////////////////////////////////////
@@ -45,9 +46,6 @@ void condition_variable::notify_all()
 ///////////////////////////////////////////////////////////////////////////////
 void condition_variable::create()
 {
-    // Just in case... try to close (ignore errors)
-    evl_close_event(&m_cv);
-
     // Create
     std::string name = "event_" + std::to_string(s_currentCVNum++) + '.' + std::to_string(getpid());
     int rv = evl_create_event(&m_cv, EVL_CLOCK_MONOTONIC, EVL_CLONE_PUBLIC, name.c_str());
diff --git a/condition_variable.h b/condition_variable.h
index f62e422..ca2ab19 100644
--- a/condition_variable.h
+++ b/condition_variable.h
@@ -14,7 +14,7 @@ public:
     condition_variable operator=(const condition_variable&) = delete;
     condition_variable& operator=(condition_variable&&) = default;
     ~condition_variable();
-    void wait(std::unique_lock<evl::mutex>& lock);
+    int wait(std::unique_lock<evl::mutex>& lock);
     void notify_all();
 
 private:
diff --git a/evl_cv_test.cpp b/evl_cv_test.cpp
index 501d045..fbd1e9a 100644
--- a/evl_cv_test.cpp
+++ b/evl_cv_test.cpp
@@ -8,7 +8,8 @@
 static char heap_storage[EVL_HEAP_RAW_SIZE(1024 * 1024)]; /* 1Mb heap */
 static struct evl_heap runtime_heap;
 
-std::unique_ptr<evl::semaphore> m_dataSemaphore;
+std::unique_ptr<evl::semaphore> m_dataSemaphore1;
+std::unique_ptr<evl::semaphore> m_dataSemaphore2;
 
 void* Thread1(void*)
 {
@@ -20,8 +21,8 @@ void* Thread1(void*)
 
     evl_printf("Thread 1 woken up\n");
 
-    m_dataSemaphore = std::unique_ptr<evl::semaphore>(new evl::semaphore());
-    m_dataSemaphore->take();
+    m_dataSemaphore1 = std::unique_ptr<evl::semaphore>(new evl::semaphore());
+    m_dataSemaphore1->take();
 
     evl_printf("Thread 1 Finished\n");
 
@@ -38,8 +39,8 @@ void* Thread2(void*)
 
     evl_printf("Thread 2 woken up\n");
 
-    m_dataSemaphore = std::unique_ptr<evl::semaphore>(new evl::semaphore());
-    m_dataSemaphore->give();
+    m_dataSemaphore2 = std::unique_ptr<evl::semaphore>(new evl::semaphore());
+    m_dataSemaphore2->give();
 
     evl_printf("Thread 2 Finished");
 
@@ -48,9 +49,9 @@ void* Thread2(void*)
 
 int main()
 {
-    // Init EVL
-    int ret = evl_init();
-    if (ret)
+    // Init EVL and attach main() to the core
+    int ret = evl_attach_self("main");
+    if (ret < 0)
     {
         printf("EVL Init failed with error: %d\n", ret);
         return -1;
@@ -86,8 +87,6 @@ int main()
     pthread_attr_setinheritsched(&tattr, PTHREAD_EXPLICIT_SCHED);
     pthread_create(&tid, &tattr, Thread1, NULL);
 
-    sleep(2);
-
     // Thread 2
     pthread_attr_t tattr2;
     sched_param param2;
@@ -107,6 +106,7 @@ int main()
 
     sleep(2);
 
+    m_dataSemaphore1->give();
     pthread_join(tid, NULL);
     pthread_join(tid2, NULL);
 
diff --git a/semaphore.cpp b/semaphore.cpp
index a9204d7..88423e1 100644
--- a/semaphore.cpp
+++ b/semaphore.cpp
@@ -33,12 +33,12 @@ void semaphore::give(unsigned int rcount)
 }
 
 ///////////////////////////////////////////////////////////////////////////////
-void semaphore::take(unsigned int rcount)
+int semaphore::take(unsigned int rcount)
 {
     // Short-circuit on rcount == 0;
     if (!rcount)
     {
-        return;
+        return 0;
     }
 
     // Ensure user isn't over-asking
@@ -51,10 +51,14 @@ void semaphore::take(unsigned int rcount)
 
     while (m_rcount < rcount)
     {
-        m_cv.wait(ulock);
+        int ret = m_cv.wait(ulock);
+	if (ret)
+		return ret;
     }
 
     m_rcount -= rcount;
+
+    return 0;
 }
 
 }
diff --git a/semaphore.h b/semaphore.h
index cbc13b2..54f5123 100644
--- a/semaphore.h
+++ b/semaphore.h
@@ -9,7 +9,7 @@ public:
     semaphore(const semaphore&) = delete;
     semaphore& operator=(const semaphore&) = delete;
     void give(uint32_t rcount = 1);
-    void take(uint32_t rcount = 1);
+    int take(uint32_t rcount = 1);
     
 private:
     evl::mutex m_mutex;

-- 
Philippe.
