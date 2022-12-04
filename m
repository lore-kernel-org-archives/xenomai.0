Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1067C
	for <xenomai@lists.linux.dev>; Sun,  4 Dec 2022 07:34:48 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id v8so11793356edi.3
        for <xenomai@lists.linux.dev>; Sat, 03 Dec 2022 23:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jWZ5UvZydwOE8Zc0xDO3u63n9hPqMkeCsQmd2Rx93kc=;
        b=ggIyyqf5Iim4BCsvYtzoe5fm41uCQl2jPtWEUuav6kHilSYRJeZlZdRlP2d2S4po9J
         LytnDw3sYn3W0hwUcs4h7TMZtIhu0m7BJGOnVmzVJC3zCt8nT5xXu4p88nTjW2ggIwRx
         T5o7ka71xw8Em8JKZU0CrgNXnEJEUwovaoXosb1rx0GidTMQOZs0EHJhGLouX1L4cedh
         o36d3PPvCXdQ+m+jePFu1t0JXasRMZmrARdcqXjnl+qM0Tr4sLYYtLf5eNwN7d8hRIK/
         afmMvP7iH/7sEibBOTzQBmvmd4D54pKqGukfKrNePgOnkg5fKSRymUZ7B95n3aZ7qWSy
         FJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jWZ5UvZydwOE8Zc0xDO3u63n9hPqMkeCsQmd2Rx93kc=;
        b=ZUqCTw0Zhnac/cCz9l4s5ZXPjwLxJJwBzN6L0waxPM3miCNgZOrwJpcN5TISjFQYFj
         aH8su1oh7EoD1SMrTTuuB80w7N8CNobkwjV+NtZR2lFpT/sapOZs2vIaNTPGMy/Igt9G
         sHJavTNveVdsosvJc7+XQlaRGCDoa/hUpyy2I7tbrfrSDQP26sw20wCAqJwf2Y9YqS2Y
         eez2OyCiMYVBPeHVDXTAN1xORv5O8ATJrqZDgW24XLz9t9gexnaNSubOu850mDqgAuhP
         itX3HlZEcS1dhbf3K1mfc+ChwNzK32tas0UgCQ43k1Ycf+kjLeJ4326kTXwhFZxoPpPi
         V8Tg==
X-Gm-Message-State: ANoB5pmWcW3TMn2UXu1HJuwKVAjx56cncJAtpcsiGvtnJ9H6nZV7uBCY
	Jt67QwFLo7KVjgZtGGNguc4USK4CRhZx+i+QPuMmRcEh+GY=
X-Google-Smtp-Source: AA0mqf4cJWgIKLvOXLMeT2Fu8wlx6YKEnp1vCMe8iP5NXQ0JGs1lSfJDUeHY4dy27Di0otw5gIN7gIvFcZFM8fAKgpg=
X-Received: by 2002:a05:6402:181:b0:461:ea0c:e151 with SMTP id
 r1-20020a056402018100b00461ea0ce151mr55175418edv.376.1670139286116; Sat, 03
 Dec 2022 23:34:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Steve Rosenbluth <stever8@gmail.com>
Date: Sat, 3 Dec 2022 23:34:33 -0800
Message-ID: <CAExw09DoupMN0cZDTYA0ouYT6MRe0KPzYSunOifMNG78EO4doQ@mail.gmail.com>
Subject: Calibrating TSC with HPET timer
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On the last community call I promised to report back the results of my
RTDM module TSC calibration vs the kernel's TSC calibration.

The original problem was that of varying TSC frequency on boot of x86
i5/i7/Atom processors. This is not runtime TSC drift, this is the TSC
starting up at a significantly different frequency at boot time and
then staying at that frequency. The TSC rate variation manifests
itself as over 1.0usec discrepancy in the period of a Xenomai periodic
task - such that a Xenomai RT periodic task doesn't run at the same
rate across cold boots.

Recently Hongzhan created an ipipe patch to re-read the kernels
ongoing calibration, which is available as of Xenomai 3 kernels
4.19.246 and above.
https://source.denx.de/Xenomai/ipipe-x86/-/commit/24c2fbb40b03aef678fe9cc062badc2e8cfd985c
The patch adds to tsc.c : __ipipe_report_clockfreq_update()

My manual calibration consisted of busy-looping in a RTDM module for 5
seconds, and comparing TSC clock ticks to HPET clock ticks. Applying
the resultant calibration factor I could get my RT-userspace periodic
task to run at a consistent rate across cold boots of the PC, with a
period deviation of only about +/-2nsec as measured on a calibrated
external frequency counter.

So the answer to the big question is that Hongzhan's patch for using
the kernel calibration achieves exactly the same thing, the RT task
period variation is equally as accurate (+/-2nsec). As a matter of
fact it appears the kernel is using the HPET for its calibration too,
because I see on the frequency counter the same constant error in the
kernel's calibration versus my RTDM calibration (HPET is always off by
about 40nsec, but with a static scaling factor the RT task period is
made perfect). I tested with Xeno 3.1.2 and the latest ipipe patch
ipipe-core-4.19.264-cip84-x86-24.patch.

An example of printed output from dmesg is as follows:
[ 7235.365194] * Xeno TSC monotonic clock delta was 4999510139 ns
[ 7235.365196] * hpet actual clock delta was 5000000139 ns
 * calib adjustment factor == 0.999902000

The way I did the calibration in an RTDM module on Xenomai 3 is in the
code below. We are using this approach now in our legacy Xenomai 2.6.5
systems and it works well. Note that you can't do floating point in an
RTDM module on Xeno 2.6 but you can pass the TSC/HPET clock ticks via
shared memory from the RTDM module to your RT periodic task where you
can calculate the calibration scaling factor.

hpet_freq_p = (int *) kallsyms_lookup_name("hpet_freq");  // HPET frequency
if (hpet_freq_p)            // if kernel has exported the needed symbol
{
   rtdm_printk("* hpet clock freq, according to kernel, is: %d\n",
*hpet_freq_p);
   hpet_period = 1.0/(double)*hpet_freq_p;        // hpet_freq has
been determined by the kernel
   calib_period_ns =  5000000000;                  // calibrate for
this many nsec
   read_hpet_p = (void *) kallsyms_lookup_name("read_hpet");    // get
access to kernel's read function
   if (read_hpet_p > 0)
   {
      rtdm_printk("* Starting TSC calibration, calib duration will be
%lld sec.\n",calib_period_ns);
      tod1 = (*read_hpet_p)(NULL);      // get (hpet) wall clock
      xeno_start_time_ns = rtdm_clock_read_monotonic();  // Xeno
monotonic clock, based on TSE
      do
      {
          tod2 = (*read_hpet_p)(NULL);      // Xeno reads wall clock
      }
      while ( (tod2*hpet_period*1000000000.0) <
((tod1*hpet_period*1000000000.0) + calib_period_ns) );
      xeno_stop_time_ns = rtdm_clock_read_monotonic();
      delta_monotonic_ns = xeno_stop_time_ns - xeno_start_time_ns;
      delta_hpet_ns = (long long)((tod2-tod1)*hpet_period*1000000000.0);
      shmem_p->calib_clock_adjust =
(double)delta_monotonic_ns/(double)delta_hpet_ns;  // will use this to
adjust period
      rtdm_printk("* Xeno TSC monotonic clock delta was %lld ns\n",
delta_monotonic_ns );
      rtdm_printk("* hpet actual clock delta was %lld ns\n", delta_hpet_ns);
   }
   else
   {
      rtdm_printk("* Problem getting read_hpet() handle!\n");
      shmem_p->calib_clock_adjust = 1.0;         // don't use this
clock for calibration
   }
}
else
   rtdm_printk("* Problem getting 'hpet_freq' handle! Will skip
calibration.\n");

-Steve Rosenbluth
