Subject: Re: Re: [Xenomai-help] Howto catch SEGV signals in Xenomai
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <22180008.1173860253238.JavaMail.ngmail@domain.hid>
References: <1173825460.16997.107.camel@domain.hid>
	<11906791.1173797505269.JavaMail.ngmail@domain.hid>
	<45F6C278.4040709@domain.hid> <1173801179.16997.56.camel@domain.hid>
	<17910.63947.624116.867944@domain.hid>
	<1173825266.16997.105.camel@domain.hid>
	<22180008.1173860253238.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Wed, 14 Mar 2007 12:02:17 +0100
Message-Id: <1173870137.32259.30.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-03-14 at 09:17 +0100, M. Koehrer wrote:
> Hi all,
> 
> thanks for all the feedback on that issue.
> Since yesterday I did a couple of tests on kernel 2.6.19.2
> 1. I used the adeos patch provided with xenomai-2.3.0 
> SMP mode => freeze with my program. I have enclosed the kernel config for this one
> UP mode => freeze with my program
> 
> 2. I added the patch from Philippe (the second one):
> 
> --- ksrc/nucleus/pod.c		 (revision 2293)
> +++ ksrc/nucleus/pod.c		 (working copy)
> @@ -1420,6 +1420,11 @@
>  		 		    the KICKED bit set, so that xnshadow_relax() is never
>  		 		    prevented from blocking the current thread. */
>  		 		 if (xnthread_test_info(thread, XNKICKED)) {
> +		 		 		 XENO_ASSERT(NUCLEUS, (mask & XNRELAX) == 0,
> +		 		 		 		     xnpod_fatal("Relaxing a kicked thread"
> +		 		 		 		 		 		 "(thread=%s, mask=%lx)?!",
> +		 		 		 		 		 		 thread->name, mask);
> +		 		 		 		 );
>  		 		 		 xnthread_clear_info(thread, XNRMID | XNTIMEO);
>  		 		 		 xnthread_set_info(thread, XNBREAK);
>  		 		 		 goto unlock_and_exit;
> 
> I used this patch on the UP kernel 2.6.19.2. Same adeos version as before.
> The result  was the same => PC freeze
> 

Make sure to switch on the nucleus debug option, so that this code
triggers if appropriate.

-- 
Philippe.



