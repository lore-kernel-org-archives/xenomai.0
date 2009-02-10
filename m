Message-ID: <4991C5F5.7030807@domain.hid>
Date: Tue, 10 Feb 2009 18:22:45 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <729916.37479.qm@domain.hid>
	<49915E95.7010101@domain.hid>
	<951569.86092.qm@domain.hid>
	<49917AE7.5030207@domain.hid>
	<767995.6513.qm@domain.hid>
In-Reply-To: <767995.6513.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Re : Re : Problem with Xeno-test: "Something
 died a XXX or"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mathieu JOINIE-MAURIN <mjoiniem@domain.hid>, Xenomai help <xenomai@xenomai.org>

Mathieu JOINIE-MAURIN wrote:
> Thank you for your help. The thing is that I am really not familiar
> with such scripts.  I found somebody who had the same error before on
>  https://mail.gna.org/public/xenomai-help/2008-10/msg00034.html

Come on ! Debugging a script is not that hard.

> 
> I think I defined good my processor in .config file.
> 
> In the script, I found the following code:
> 
> 
> generate_loads() { jobsct=$1; #if test -z "$1"; then echo Skipping
> generate_loads; return; fi shift 1 if test 0 -eq $withBusybox ; then 
> reaper() { echo something died a $! or $* ; sleep 1;  } trap reaper
> CHLD trap cleanup_load EXIT    # under all exit conditions fi while
> test $jobsct -ge 1; do jobsct=$(($jobsct-1)); mkload 
> dd_jobs="$dd_jobs $!" ; done
> 
> What is exactly Busy box ? Is it a flag I should have turned off or
> on in the kernel .config file ? I do not really understand the test
> which is made and why I get "Something died a ..." error.

You can find what is busybox with google or wikipedia. And in any case,
you can look in the script to see how this withBusybox variable is set.

Please use the mailing list.

-- 
                                                 Gilles.

