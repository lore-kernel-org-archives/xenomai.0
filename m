Subject: Re: [xenomai-images][PATCH v2] scripts/run-lava-tests: Wait until ssh
 connection is open
References: <20190924115416.26379-1-Quirin.Gylstorff@siemens.com>
 <20190924131617.3011-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <901ed017-ab67-f975-b471-8753adbb4e97@siemens.com>
Date: Wed, 25 Sep 2019 07:41:05 +0200
MIME-Version: 1.0
In-Reply-To: <20190924131617.3011-1-Quirin.Gylstorff@siemens.com>
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

On 24.09.19 15:16, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> To connect with lava master use a ssh connection with port forwarding.
> It can take some time till the port is available. Therefore
> wait until the port is available.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes:
> V2:
> - Add Timeout
>   scripts/run-lava-tests.sh | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
> index b288edf..8f49917 100755
> --- a/scripts/run-lava-tests.sh
> +++ b/scripts/run-lava-tests.sh
> @@ -13,12 +13,23 @@ set -e
>   TARGET=$1
>   
>   LAVA_MASTER="${LAVA_USER}@${LAVA_HOST}"
> -
> +LAVA_MASTER_PORT=28080
>   # open connection for ssh port forwarding
> -ssh -N  -p ${LAVA_PORT} -o 'LocalForward localhost:28080 localhost:80' ${LAVA_MASTER} &
> -
> +ssh -N  -p ${LAVA_PORT} -o 'LocalForward localhost:'${LAVA_MASTER_PORT}' localhost:80' ${LAVA_MASTER} &
> +# wait for connection
> +INTERVAL=1
> +TIMEOUT=60
> +until ss -tulw | grep -q "${LAVA_MASTER_PORT}"
> +do
> +    if [ ${TIMEOUT} -le 0 ]; then
> +        echo "could not open connection to LAVA Master"
> +        exit 1
> +    fi
> +    sleep ${INTERVAL}
> +    TIMEOUT=$(expr ${TIMEOUT} - ${INTERVAL})
> +done
>   # connect to lava master
> -lavacli identities add --token ${LAVA_TOKEN} --uri http://localhost:28080 --username siemens default
> +lavacli identities add --token ${LAVA_TOKEN} --uri http://localhost:${LAVA_MASTER_PORT} --username ${LAVA_ACCOUNT} default
>   
>   test_id=$(lavacli jobs submit tests/jobs/xenomai-${TARGET}.yml)
>   lavacli jobs logs ${test_id}
> 

Where is LAVA_ACCOUNT now supposed to come from? CI variables? As there is some 
risk of confusion with LAVA_USER, better naming would be good. And some words in 
tests/README.md on all these variables.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

