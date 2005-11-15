In-Reply-To: <4379AC7B.8040500@domain.hid>
Message-ID: <OF53595BAB.2AA49C4A-ONC12570BA.0035EF11-C12570BA.0036F2D4@domain.hid>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Tue, 15 Nov 2005 11:00:11 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA29DFA669818f9e8a93df938690918c4EBBFA29DFA66981"
Content-Disposition: inline
Subject: [Xenomai-core] Re: [Xenomai-help] printk
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

--0__=4EBBFA29DFA669818f9e8a93df938690918c4EBBFA29DFA66981
Content-type: text/plain; charset=US-ASCII


please see comments below...

>
> Another approach is about dropping the non-atomic update sequence
> that hurts, tolerating
> null runs of the virq when the seldom preemption case is seen, but
> without requiring hw
> interrupt masking to protect the shared stuff. Livelocking Linux
> inside the virq handler
> would still be possible whenever the RT side spams the kernel log,
> but this would not be
> an issue for us, since there is no such thing as a fair real-time
> system anyway.
>
> --- kernel/printk.c   2 Nov 2005 16:29:34 -0000   1.2
> +++ kernel/printk.c   15 Nov 2005 09:11:33 -0000
> @@ -511,24 +511,23 @@
>
>   static ipipe_spinlock_t __ipipe_printk_lock = IPIPE_SPIN_LOCK_UNLOCKED;
>
> -static int __ipipe_printk_fill;
> +static atomic_t __ipipe_printk_fill;
>
>   static char __ipipe_printk_buf[__LOG_BUF_LEN];
>
>   void __ipipe_flush_printk (unsigned virq)
>   {
>      char *p = __ipipe_printk_buf;
> -   int out = 0, len;
> +   int len;
>
> -   clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags);
> -
> -   while (out < __ipipe_printk_fill) {
> -      len = strlen(p) + 1;
> -      printk("%s",p);
> -      p += len;
> -      out += len;
> +   while
(test_and_clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags)) {
> +      while (atomic_read(&__ipipe_printk_fill) > 0) {
> +         len = strlen(p) + 1;
> +         printk("%s",p);
> +         p += len;

> +         atomic_sub(len,&__ipipe_printk_fill);

But that's wrong. __ipipe_printk_fill is used as an index in printk() and
here you use it as a number of bytes still need to be printed.

let's suppose:

p = __ipipe_printk_buf = [ 5 bytes \0] [10 bytes \0]
__ipipe_printk_fill == 17;

1) first iteration of __ipipe_flush_printk

5-byte string is printed out

p = __ipipe_printk_buf + 6 ---> [10 bytes \0]
__ipipe_printk_fill == 11;

...

In the mean time, on another CPU:

2) printk() does

> +      r = vscnprintf(__ipipe_printk_buf +
atomic_read(&__ipipe_printk_fill),
>                   fbytes, fmt, args) + 1; /* account for the null byte */

__ipipe_printk_buf + atomic_read(&__ipipe_printk_fill) ==
__ipipe_printk_buf + 11

and that points right in the middle of the still non-printed 10-bytes long
string [5 bytes \0] [10 bytes (*** this will be broken ***) \0]

So we are loosing data again.

is something wrong? anyway, there must be a small correction somewhere
around :)

> +      }
>      }
> -   __ipipe_printk_fill = 0;
>   }
>
>   asmlinkage int printk(const char *fmt, ...)
> @@ -548,12 +547,12 @@
>
>      spin_lock_irqsave_hw(&__ipipe_printk_lock,flags);
>
> -   fbytes = __LOG_BUF_LEN - __ipipe_printk_fill;
> +   fbytes = __LOG_BUF_LEN - atomic_read(&__ipipe_printk_fill);
>
>      if (fbytes > 1)   {
> -      r = vscnprintf(__ipipe_printk_buf + __ipipe_printk_fill,
> +      r = vscnprintf(__ipipe_printk_buf +
atomic_read(&__ipipe_printk_fill),
>                   fbytes, fmt, args) + 1; /* account for the null byte */
> -      __ipipe_printk_fill += r;
> +      atomic_add(r,&__ipipe_printk_fill);
>      } else
>         r = 0;
>

> --
>
> Philippe.

---

Dmitry
--0__=4EBBFA29DFA669818f9e8a93df938690918c4EBBFA29DFA66981
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>please see comments below...</tt><br>
<br>
<tt>&gt; <br>
&gt; Another approach is about dropping the non-atomic update sequence <br>
&gt; that hurts, tolerating <br>
&gt; null runs of the virq when the seldom preemption case is seen, but <br>
&gt; without requiring hw <br>
&gt; interrupt masking to protect the shared stuff. Livelocking Linux <br>
&gt; inside the virq handler <br>
&gt; would still be possible whenever the RT side spams the kernel log, <br>
&gt; but this would not be <br>
&gt; an issue for us, since there is no such thing as a fair real-time <br>
&gt; system anyway.<br>
&gt; <br>
&gt; --- kernel/printk.c &nbsp; 2 Nov 2005 16:29:34 -0000 &nbsp; 1.2<br>
&gt; +++ kernel/printk.c &nbsp; 15 Nov 2005 09:11:33 -0000<br>
&gt; @@ -511,24 +511,23 @@<br>
&gt; <br>
&gt; &nbsp; static ipipe_spinlock_t __ipipe_printk_lock = IPIPE_SPIN_LOCK_UNLOCKED;<br>
&gt; <br>
&gt; -static int __ipipe_printk_fill;<br>
&gt; +static atomic_t __ipipe_printk_fill;<br>
&gt; <br>
&gt; &nbsp; static char __ipipe_printk_buf[__LOG_BUF_LEN];<br>
&gt; <br>
&gt; &nbsp; void __ipipe_flush_printk (unsigned virq)<br>
&gt; &nbsp; {<br>
&gt; &nbsp; &nbsp; &nbsp;char *p = __ipipe_printk_buf;<br>
&gt; - &nbsp; int out = 0, len;<br>
&gt; + &nbsp; int len;<br>
&gt; <br>
&gt; - &nbsp; clear_bit(IPIPE_PPRINTK_FLAG,&amp;ipipe_root_domain-&gt;flags);<br>
&gt; -<br>
&gt; - &nbsp; while (out &lt; __ipipe_printk_fill) {<br>
&gt; - &nbsp; &nbsp; &nbsp;len = strlen(p) + 1;<br>
&gt; - &nbsp; &nbsp; &nbsp;printk(&quot;%s&quot;,p);<br>
&gt; - &nbsp; &nbsp; &nbsp;p += len;<br>
&gt; - &nbsp; &nbsp; &nbsp;out += len;<br>
&gt; + &nbsp; while (test_and_clear_bit(IPIPE_PPRINTK_FLAG,&amp;ipipe_root_domain-&gt;flags)) {<br>
&gt; + &nbsp; &nbsp; &nbsp;while (atomic_read(&amp;__ipipe_printk_fill) &gt; 0) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; len = strlen(p) + 1;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; printk(&quot;%s&quot;,p);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; p += len;<br>
</tt><br>
<tt>&gt; + &nbsp; &nbsp; &nbsp; &nbsp; atomic_sub(len,&amp;__ipipe_printk_fill);<br>
</tt><br>
<tt>But that's wrong. __ipipe_printk_fill is used as an index in printk() and here you use it as a number of bytes still need to be printed.</tt><br>
<br>
<tt>let's suppose:</tt><br>
<br>
<tt>p = __ipipe_printk_buf = [ 5 bytes \0] [10 bytes \0]</tt><br>
<tt>__ipipe_printk_fill == 17;</tt><br>
<br>
<tt>1) first iteration of __ipipe_flush_printk</tt><br>
<br>
<tt>5-byte string is printed out</tt><br>
<br>
<tt>p = __ipipe_printk_buf + 6 ---&gt; [10 bytes \0]</tt><br>
<tt>__ipipe_printk_fill == 11;</tt><br>
<br>
<tt>...</tt><br>
<br>
<tt>In the mean time, on another CPU:</tt><br>
<br>
<tt>2) printk() does</tt><br>
<br>
<tt>&gt; + &nbsp; &nbsp; &nbsp;r = vscnprintf(__ipipe_printk_buf + atomic_read(&amp;__ipipe_printk_fill),<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fbytes, fmt, args) + 1; /* account for the null byte */<br>
</tt><br>
<tt>__ipipe_printk_buf + atomic_read(&amp;__ipipe_printk_fill) == __ipipe_printk_buf + 11</tt><br>
<br>
<tt>and that points right in the middle of the still non-printed 10-bytes long string [5 bytes \0] [10 bytes (*** this will be broken ***) \0]</tt><br>
<br>
<tt>So we are loosing data again.</tt><br>
<br>
<tt>is something wrong? anyway, there must be a small correction somewhere around :)</tt><br>
<br>
<tt>&gt; + &nbsp; &nbsp; &nbsp;}<br>
&gt; &nbsp; &nbsp; &nbsp;}<br>
&gt; - &nbsp; __ipipe_printk_fill = 0;<br>
&gt; &nbsp; }<br>
&gt; <br>
&gt; &nbsp; asmlinkage int printk(const char *fmt, ...)<br>
&gt; @@ -548,12 +547,12 @@<br>
&gt; <br>
&gt; &nbsp; &nbsp; &nbsp;spin_lock_irqsave_hw(&amp;__ipipe_printk_lock,flags);<br>
&gt; <br>
&gt; - &nbsp; fbytes = __LOG_BUF_LEN - __ipipe_printk_fill;<br>
&gt; + &nbsp; fbytes = __LOG_BUF_LEN - atomic_read(&amp;__ipipe_printk_fill);<br>
&gt; <br>
&gt; &nbsp; &nbsp; &nbsp;if (fbytes &gt; 1) &nbsp; {<br>
&gt; - &nbsp; &nbsp; &nbsp;r = vscnprintf(__ipipe_printk_buf + __ipipe_printk_fill,<br>
&gt; + &nbsp; &nbsp; &nbsp;r = vscnprintf(__ipipe_printk_buf + atomic_read(&amp;__ipipe_printk_fill),<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fbytes, fmt, args) + 1; /* account for the null byte */<br>
&gt; - &nbsp; &nbsp; &nbsp;__ipipe_printk_fill += r;<br>
&gt; + &nbsp; &nbsp; &nbsp;atomic_add(r,&amp;__ipipe_printk_fill);<br>
&gt; &nbsp; &nbsp; &nbsp;} else<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; r = 0;<br>
&gt; <br>
</tt><br>
<tt>&gt; -- <br>
&gt; <br>
&gt; Philippe.<br>
</tt><br>
<tt>---</tt><br>
<br>
<tt>Dmitry</tt><br>
</body></html>
--0__=4EBBFA29DFA669818f9e8a93df938690918c4EBBFA29DFA66981--


