Subject: Re: [PATCH] testsuite/xeno-test: add --vm option
References: <20190925110329.28708-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7177c8bc-e20f-71de-655c-ff4ca9f3fa81@siemens.com>
Date: Mon, 30 Sep 2019 11:01:45 +0200
MIME-Version: 1.0
In-Reply-To: <20190925110329.28708-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org

On 25.09.19 13:03, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If the xeno-test are excuted in a virtual environment the tests fail
> due missed timing thresholds. To allow a successful test in a virtual
> environment pass the --vm option to smokey.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   testsuite/xeno-test/xeno-test.in | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/testsuite/xeno-test/xeno-test.in b/testsuite/xeno-test/xeno-test.in
> index bee0bccc7..505adfd75 100644
> --- a/testsuite/xeno-test/xeno-test.in
> +++ b/testsuite/xeno-test/xeno-test.in
> @@ -24,6 +24,9 @@ If the script is passed the -r option, real-time stress is added to the test,
>   with the help of the "switchtest" test. But beware: the latency test figures are
>   then no longer meaningful.
>   
> +For running test in a virtual machine use the --vm option. This option relaxes
> +some of the timing thresholds.
> +
>   Any other option passed on the command line is passed to the latency test.
>   
>   Example:
> @@ -37,6 +40,7 @@ EOF
>   }
>   
>   keep_going=
> +run_on_vm=
>   rt_load=false
>   
>   while :; do
> @@ -51,6 +55,11 @@ while :; do
>   	    shift
>   	    ;;
>   
> +	--vm)
> +	    run_on_vm=--vm
> +	    shift
> +	    ;;
> +
>   	-r)
>   	    rt_load=true
>   	    shift
> @@ -73,7 +82,7 @@ echo 0 > /proc/xenomai/latency || :
>   
>   testdir=@testdir@
>   
> -$testdir/smokey --run $keep_going random_alloc_rounds=64 pattern_check_rounds=64
> +$testdir/smokey --run $run_on_vm $keep_going random_alloc_rounds=64 pattern_check_rounds=64
>   $testdir/clocktest -D -T 30 -C CLOCK_HOST_REALTIME || $testdir/clocktest -T 30
>   $testdir/switchtest -T 30
>   
> 

Thanks, applied. Will push to stable as well.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

