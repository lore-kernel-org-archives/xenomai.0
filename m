Subject: Re: [xenomai-images][PATCH] scripts/install_lavacli: install wheel
References: <20190923133206.15377-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8695de09-f30b-b1c0-2458-7abb5f640b27@siemens.com>
Date: Mon, 23 Sep 2019 16:16:47 +0200
MIME-Version: 1.0
In-Reply-To: <20190923133206.15377-1-Quirin.Gylstorff@siemens.com>
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

On 23.09.19 15:32, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Avoid unnecessary error messages during the installation of
> lavacli by installing wheel.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   scripts/install-lavacli.sh | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/install-lavacli.sh b/scripts/install-lavacli.sh
> index 66600f2..f31a394 100755
> --- a/scripts/install-lavacli.sh
> +++ b/scripts/install-lavacli.sh
> @@ -17,5 +17,6 @@ if [ "${os_version_id}" -ge "10" ]; then
>       sudo apt update
>       sudo apt install -y lavacli
>   else
> +    sudo pip3 install wheel
>       sudo pip3 install lavacli
>   fi
> 

Also applied to next. Now waiting for the test results...

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

