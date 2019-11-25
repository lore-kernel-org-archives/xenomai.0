Subject: Re: [xenomai-images PATCH] scripts/run-lava-tests: kill open ssh
 connection
References: <20191125112252.14461-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f8a2a4ef-f516-611a-6738-3240a3f6aac0@siemens.com>
Date: Mon, 25 Nov 2019 17:28:17 +0100
MIME-Version: 1.0
In-Reply-To: <20191125112252.14461-1-Quirin.Gylstorff@siemens.com>
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

On 25.11.19 12:22, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> To avoid a hanging gitlabci runner kill the open ssh connection after
> the last lavacli command.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   scripts/run-lava-tests.sh | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
> index f714b78..03119f1 100755
> --- a/scripts/run-lava-tests.sh
> +++ b/scripts/run-lava-tests.sh
> @@ -19,6 +19,7 @@ fi
>   LAVA_SSH_DESTINATION="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"
>   # open connection for ssh port forwarding
>   ssh -N ${LAVA_SSH_PORT} -o 'LocalForward localhost:'${LAVA_MASTER_PORT}' localhost:80' ${LAVA_SSH_DESTINATION} &
> +SSH_PID=$!
>   # wait for connection
>   INTERVAL=1
>   TIMEOUT=60
> @@ -51,6 +52,7 @@ lavacli jobs logs ${test_id}
>   lavacli results ${test_id}
>   # change return code to generate a error in gitlab-ci if a test is failed
>   number_of_fails=$(lavacli results ${test_id} | grep fail | wc -l)
> +kill ${SSH_PID}
>   if [ "${number_of_fails}" -gt "0" ]; then
>       exit 1
>   fi
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

