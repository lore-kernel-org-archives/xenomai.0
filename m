Subject: Re: [xenomai-images][PATCH 1/1] kas.yml: switch isar url to a working
 clone url
References: <20190904082656.12601-1-henning.schild@siemens.com>
 <20190904082656.12601-2-henning.schild@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <55ff7165-1d61-6fe0-fc60-73b95bca9125@siemens.com>
Date: Wed, 4 Sep 2019 13:12:32 +0200
MIME-Version: 1.0
In-Reply-To: <20190904082656.12601-2-henning.schild@siemens.com>
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
To: Henning Schild <henning.schild@siemens.com>, xenomai@xenomai.org

On 04.09.19 10:26, Henning Schild via Xenomai wrote:
> From: Henning Schild <henning.schild@siemens.com>
> 
> The url was actually missing the .git extension which seems to break
> cloning it. Maybe a github change or who knows, but that new one works.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>   kas.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas.yml b/kas.yml
> index 260eb36..a4d12c2 100644
> --- a/kas.yml
> +++ b/kas.yml
> @@ -19,7 +19,7 @@ repos:
>     xenomai:
>   
>     isar:
> -    url: https://github.com/ilbers/isar
> +    url: https://github.com/ilbers/isar.git
>       refspec: 59c7dd2b8b3172d53de1c7a39fbd49751193559a
>       layers:
>         meta:
> 

Huh? Never saw this issue before:

$ git clone https://github.com/ilbers/isar
Cloning into 'isar'...
remote: Enumerating objects: 41, done.
remote: Counting objects: 100% (41/41), done.
remote: Compressing objects: 100% (36/36), done.
remote: Total 6625 (delta 13), reused 23 (delta 5), pack-reused 6584
Receiving objects: 100% (6625/6625), 3.56 MiB | 6.03 MiB/s, done.
Resolving deltas: 100% (3786/3786), done.
$ git --version
git version 2.16.4

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

