Subject: Re: posix_select seems to leak a registry element
References: <6dc0aceae6cd5bc5898d898f6f3d7132497d5535.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c366b71b-4926-a60c-02c1-d49ddd30956d@siemens.com>
Date: Thu, 12 Aug 2021 14:45:50 +0200
MIME-Version: 1.0
In-Reply-To: <6dc0aceae6cd5bc5898d898f6f3d7132497d5535.camel@siemens.com>
Content-Type: text/plain; charset=utf-8
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
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12.08.21 14:39, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> Hi all,
> 
> I just noticed that the posix_select test of smokey is leaking one
> registry element:
> 
> $ cat /proc/xenomai/registry/usage
> 8/512
> 
> $ <path>/smokey --run=posix_select
> posix_select OK
> 
> $ cat /proc/xenomai/registry/usage
> 9/512
> 
> The following diff would fix that, but I assume the resource cleanup
> should happen on process/task exit anyway. For some reason it does not.
> Any ideas where to look at? Where (code location) should the cleanup
> take place?
> 
> diff --git a/testsuite/smokey/posix-select/posix-select.c
> b/testsuite/smokey/posix-select/posix-select.c
> index e9bf938b3..0a59e4968 100644
> --- a/testsuite/smokey/posix-select/posix-select.c
> +++ b/testsuite/smokey/posix-select/posix-select.c
> @@ -138,6 +138,8 @@ static int run_posix_select(struct smokey_test *t,
> int argc, char *const argv[])
>         usleep(300000);
>         smp_rmb();
>         ret = test_status;
> +
> +       mq_unlink("/select_test_mq");
>  out:
>         pthread_join(tcb, NULL);
> 

The change is likely correct. I'm now wondering if we are cleaning up a
process-shared resource here that the core may not be able to simply
destroy when the creator terminates. Needs to be checked if that is the
case or if we are truly leaking via the kernel as well.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

