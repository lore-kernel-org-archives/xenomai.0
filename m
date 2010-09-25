Message-ID: <4C9E3100.4020003@domain.hid>
Date: Sat, 25 Sep 2010 19:27:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C9E15A9.8070601@domain.hid>
In-Reply-To: <4C9E15A9.8070601@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RFC: /proc/xenomai/latency change
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Hi,
> 
> I have been working on omap3 performances, and during this, I noticed 
> one flaw in /proc/xenomai/latency: it displays the whole timer subsystem
> anticipation whereas it should probably only allow setting the scheduler
> latency. The reason is that when issuing the customary:
> echo 0 > /proc/xenomai/latency
> 
> we were in fact also disabling any account of the timer programming 
> latency. This is probably almoste invisible on systems with low timer 
> programming latencies, but this turned out to account for around 5us 
> error on timer programming on omap. Now, the timer programming latency 
> is back to a more reasonable 1us on omap, but I still think we should 
> change this.
> 
> However, since it may break some users settings, I wonder if we should 
> apply it now or only in the 2.6 branch.
> 
> Here is the patch I am talking about:

Better:
diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 7db0ccf..2297b74 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -3164,7 +3164,7 @@ static int latency_read_proc(char *page,
 {
        int len;

-       len = sprintf(page, "%Lu\n", xnarch_tsc_to_ns(nklatency));
+       len = sprintf(page, "%Lu\n", xnarch_tsc_to_ns(nklatency - nktimerlat));
        len -= off;
        if (len <= off + count)
                *eof = 1;
@@ -3196,7 +3196,7 @@ static int latency_write_proc(struct file *file,
        if ((*end != '\0' && !isspace(*end)) || ns < 0)
                return -EINVAL;

-       nklatency = xnarch_ns_to_tsc(ns);
+       nklatency = xnarch_ns_to_tsc(ns) + nktimerlat;

        return count;
 }


-- 
                                                                Gilles.

