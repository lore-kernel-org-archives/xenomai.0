Subject: Re: [PATCH] testsuite/smokey: Do not load .gdbinit in gdb test
References: <20200423064535.6261-1-vt@altlinux.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <944369d8-86f0-d79c-1fb2-06108781200d@siemens.com>
Date: Fri, 24 Apr 2020 19:23:08 +0200
MIME-Version: 1.0
In-Reply-To: <20200423064535.6261-1-vt@altlinux.org>
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
To: Vitaly Chikunov <vt@altlinux.org>, Xenomai <xenomai@xenomai.org>

On 23.04.20 08:45, Vitaly Chikunov wrote:
> Avoid possible prompt being redefined in `.gdbinit' which could break
> gdb test.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>   testsuite/smokey/gdb/gdb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git testsuite/smokey/gdb/gdb.c testsuite/smokey/gdb/gdb.c
> index cc11d2352..eabf75e6a 100644
> --- testsuite/smokey/gdb/gdb.c
> +++ testsuite/smokey/gdb/gdb.c
> @@ -273,7 +273,7 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
>   
>   			snprintf(run_param, sizeof(run_param), "--run=%d",
>   				 t->__reserved.id);
> -			execlp("gdb", "gdb", "--args",
> +			execlp("gdb", "gdb", "--nx", "--args",
>   			      argv[0], run_param, "run_target", (char *)NULL);
>   			_exit(ESRCH);
>   
> 

Thanks, applied.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

