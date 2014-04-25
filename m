MIME-Version: 1.0
In-Reply-To: <CAPRPZsB4+68QpNZ7sBCa6-wssNizkrBpG7vB_6q-cJXvCzkihg@mail.gmail.com>
References: <CAPRPZsBD_5ufxFAhPCFqRf9YZSm1FhqfcmL+MTbhJ=1Sb7ED_g@mail.gmail.com>
 <CAPRPZsBsOmiaWPJmPR9RK0uv_BXbw_s43rarKOvVoGfN2gWZjQ@mail.gmail.com>
 <CAPRPZsCnAJH_-070SbSMB+Q_dQwf+FYfKpmp1wzwtz=zMA2bcA@mail.gmail.com>
 <5357C92F.2060206@xenomai.org>
 <CAPRPZsAvxx9XVB5MYi65m1FPaz2p7Rgh7+M4U357exJBbo0kHQ@mail.gmail.com>
 <535828F6.6050308@xenomai.org>
 <CAPRPZsA4ZQEm1a+2TV6s2wvD2_M53RrL4zLz0sJgLKEF8ALo1w@mail.gmail.com>
 <53583DF7.3080700@xenomai.org>
 <CAPRPZsB8a=gN=U14qn_tpfksg3T8yW+M8pZGhOkT-jPDuU8L0w@mail.gmail.com>
 <CAPRPZsAyTQN936=phnT+NzvT7w_UxnY1ppQDucCjh39neOYn6g@mail.gmail.com>
 <CAPRPZsB4+68QpNZ7sBCa6-wssNizkrBpG7vB_6q-cJXvCzkihg@mail.gmail.com>
Date: Fri, 25 Apr 2014 12:44:46 +0200
Message-ID: <CAPRPZsCji_p56+CC+a6ueywq39piA=70RaTPP3Xtz62NL_nhcQ@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Reading /proc/xenomai/stat causes high latencies
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

For testing, I've removed the locks from the vfile system. Then the
high latencies reliably disappear.

To test, I made two xeno_nucleus modules: one with the xnlock_get/put_
in place and one with dummies. Subsequently, I use a program that
simply opens and reads the stat file 1,000 times.

With locks:

RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     -2.575|     -2.309|      9.286|       0|     0|     -2.575|      9.286
RTD|     -2.364|     -2.276|      1.600|       0|     0|     -2.575|      9.286
RTD|     -2.482|     -2.274|      2.165|       0|     0|     -2.575|      9.286
RTD|     -2.368|    135.261|   1478.154|   13008|     0|     -2.575|   1478.154
RTD|     -2.368|     -2.272|      2.602|   13008|     0|     -2.575|   1478.154
RTD|     -2.499|     -2.272|      6.933|   13008|     0|     -2.575|   1478.154

Without locks:

RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     -2.503|     -2.270|      3.310|       0|     0|     -2.503|      3.310
RTD|     -2.418|     -2.284|     -1.646|       0|     0|     -2.503|      3.310
RTD|     -2.496|     -2.275|      4.630|       0|     0|     -2.503|      4.630
RTD|     -2.374|     -2.285|     -1.458|       0|     0|     -2.503|      4.630
RTD|     -2.452|     -2.273|      3.559|       0|     0|     -2.503|      4.630
RTD|     -2.370|     -2.285|     -1.518|       0|     0|     -2.503|      4.630
RTD|     -2.458|     -2.274|      4.203|       0|     0|     -2.503|      4.630

I'll now have a closer look into the vfile system but if the locks are
malfunctioning, I'm clueless.


BTW I found that unloading and loading xeno_nucleus didn't work due to
a missing rthal_free_ptdkey call in xnshadow_cleanup. I used the
following patch to fix that. (The ability to swap out xenomai modules
is a real lifesaver when debugging. Thanks!)

--- /home/vdkeybus/work/xenomai/ksrc/nucleus/shadow.c   2014-04-16
22:46:19.018851844 +0200
+++ shadow.c    2014-04-25 09:43:49.838735832 +0200
@@ -3139,6 +3139,8 @@ void xnshadow_cleanup(void)
        }

        rthal_apc_free(lostage_apc);
+
+       rthal_free_ptdkey(nkmmptd);
        rthal_free_ptdkey(nkerrptd);
        rthal_free_ptdkey(nkthrptd);


Jeroen.

