From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <18118.705.31563.238806@domain.hid>
References: <18118.705.31563.238806@domain.hid>
Content-Type: text/plain
Date: Fri, 17 Aug 2007 23:11:02 +0200
Message-Id: <1187385062.5977.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [patch] pass xeno-test -p option to switchbench
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, 2007-08-17 at 22:19 +0200, Gilles Chanteperdrix wrote:
> Hi,
> 
> when running xeno-test on ARM, I got a lock-up because xeno-test -p
> option, passed to latency, is not passed to the switchbench test. The
> attached patch solves this.

Merged, thanks.

> 
> Regards.
> 
> plain text document attachment
> (xeno-test-pass-p-option-to-switchbench.diff)
> Index: scripts/xeno-test.in
> ===================================================================
> --- scripts/xeno-test.in	(revision 2930)
> +++ scripts/xeno-test.in	(working copy)
> @@ -191,23 +191,37 @@
>  
> 
>  run_w_load() {
> -    local opts="$*";
> -    [ "$opts"  = '' ] && opts='-sh -T 120'
> +    local latpass
> +    local sbpass
>  
> +    while :; do 
> +	case $1 in
> +	*=*)
> +	    eval $1
> +	    shift;;
> +	*)
> +	    break;;
> +	esac
> +    done
> +
> +    latpass="$*";
> +    [ "$latpass" = '' ] && latpass='-sh -T 120'
> +    [ "$sbpass" = '' ] && sbpass='-h'
> +
>      boxinfo
>      loudly generate_loads $workload
>      boxstatus
>      (
>          cd $pkgdatadir/testsuite/latency
> -	loudly ./run -- $XENOT_LATENCY $opts -t0 '# latency'
> -	loudly ./run -- $XENOT_LATENCY $opts -t1 '# latency'
> -	loudly ./run -- $XENOT_LATENCY $opts -t2 '# latency'
> +	loudly ./run -- $XENOT_LATENCY $latpass -t0 '# latency'
> +	loudly ./run -- $XENOT_LATENCY $latpass -t1 '# latency'
> +	loudly ./run -- $XENOT_LATENCY $latpass -t2 '# latency'
>      )
>      (	cd $pkgdatadir/testsuite/switchtest
>  	loudly ./run -- -T 120 $XENOT_SWITCHTEST '# switchtest'
>      )
>      (	cd $pkgdatadir/testsuite/switchbench
> -	loudly ./run -- -h $XENOT_SWITCHBENCH '# switchbench'
> +	loudly ./run -- $XENOT_SWITCHBENCH $sbpass '# switchbench'
>      )
>      (	cd $pkgdatadir/testsuite/cyclic
>  	loudly ./run -- -p 10 -n -l 1000 $XENOT_CYCLIC '# cyclictest'
> @@ -243,7 +257,8 @@
>  workload=1	# default = 1 job
>  
>  # *pass get all legit options, except -N, -L
> -pass=		# pass thru to latency
> +latpass=	# pass thru to latency
> +sbpass=         # pass thru to switchbench
>  loadpass=	# pass thru to subshell, not to actual tests
>  
>  logging=	# no logging by default
> @@ -280,11 +295,18 @@
>  handle_options() {	# called for XENOTEST_OPTS, ARGV
>      case $FOO in
>  
> -	# latency passthrus
> -	s|h|q)
> -	    pass="$pass -$FOO" ;;
> -	T|l|H|B|p)
> -	    pass="$pass -$FOO $OPTARG" ;;
> +	# latency & switchbench passthrus
> +	h)
> +	    latpass="$pass -$FOO"
> +	    sbpass="$sbpass -$FOO" ;;
> +	p)
> +	    latpass="$pass -$FOO $OPTARG"
> +	    sbpass="$sbpass -$FOO $OPTARG" ;;
> +	# latency only passthrus
> +	s|q)
> +	    latpass="$latpass -$FOO" ;;
> +	T|l|H|B)
> +	    latpass="$latpass -$FOO $OPTARG" ;;
>  
>  	# workload related
>  	d) 
> @@ -354,7 +376,7 @@
>  wfile=$logprefix$logfile-`date $dateargs`
>  if test "$logging" != "" ; then
>      # restart inside a script invocation, passing appropriate args
> -    script -c "`dirname $0`/xeno-test $loadpass $pass $*" $wfile
> +    script -c "`dirname $0`/xeno-test $loadpass $latpass $*" $wfile
>      res="$?"
>      if test "$res" == "0" ; then
>  	sendit $wfile
> @@ -363,7 +385,7 @@
>      if test "$altwork" != "" ; then
>  	mkload() { exec $altwork; }
>      fi
> -    run_w_load $pass $* 2>&1 | tee $wfile
> +    run_w_load sbpass="$sbpass" $latpass $* 2>&1 | tee $wfile
>      res="$?"
>      if test "$sendit" != '' && test $res -eq 0  ; then
>         sendit $wfile
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



