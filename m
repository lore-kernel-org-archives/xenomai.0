Subject: Re: [PATCH] smokey/gdb: search gdb in PATH
References: <20191011090525.6392-1-norbert.lange@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0fbcdc19-8807-669f-8678-52d1dc4176ff@siemens.com>
Date: Fri, 11 Oct 2019 11:11:41 +0200
MIME-Version: 1.0
In-Reply-To: <20191011090525.6392-1-norbert.lange@andritz.com>
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
To: Norbert Lange <nolange79@gmail.com>, xenomai@xenomai.org

On 11.10.19 11:05, Norbert Lange via Xenomai wrote:
> Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
> ---
>   testsuite/smokey/gdb/gdb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
> index 33c16fe87..4f39f3f6c 100644
> --- a/testsuite/smokey/gdb/gdb.c
> +++ b/testsuite/smokey/gdb/gdb.c
> @@ -280,8 +280,8 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
>   
>   			snprintf(run_param, sizeof(run_param), "--run=%d",
>   				 t->__reserved.id);
> -			execl("/usr/bin/gdb", "gdb", "--args",
> -			      argv[0], run_param, "run_target", NULL);
> +			execlp("gdb", "gdb", "--args",
> +			      argv[0], run_param, "run_target", (char *)NULL);
>   			_exit(ESRCH);
>   
>   		default:
> 

Thanks, applied.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

