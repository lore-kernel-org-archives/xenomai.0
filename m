From: Jan Kiszka <jan.kiszka@siemens.com>
References: <9e7eb4ea-6e66-473b-c29d-171085b165b0@siemens.com>
Message-ID: <6a3e52ad-14d9-3991-eb8e-6f72880d3acc@siemens.com>
Date: Tue, 2 Oct 2018 18:37:00 +0200
MIME-Version: 1.0
In-Reply-To: <9e7eb4ea-6e66-473b-c29d-171085b165b0@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] drivers/analogy: Fix improper memset in Intel
 8255
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On 27.09.18 08:40, Jan Kiszka wrote:
> This overwrote the pointer itself - and more. Long pending bugs.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   kernel/drivers/analogy/intel/8255.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/drivers/analogy/intel/8255.c b/kernel/drivers/analogy/intel/8255.c
> index ad8039b288..1abe250e0c 100644
> --- a/kernel/drivers/analogy/intel/8255.c
> +++ b/kernel/drivers/analogy/intel/8255.c
> @@ -201,7 +201,7 @@ void a4l_subdev_8255_init(struct a4l_subdevice *subd)
>   {
>   	subd_8255_t *subd_8255 = (subd_8255_t *)subd->priv;
>   	/* Initializes the subdevice structure */
> -	memset(&subd, 0, sizeof(struct a4l_subdevice));
> +	memset(subd, 0, sizeof(struct a4l_subdevice));
>   
>   	/* Subdevice filling part */
>   
> @@ -263,7 +263,7 @@ static int dev_8255_attach(struct a4l_device *dev, a4l_lnkdesc_t *arg)
>   			goto out_attach;
>   		}
>   
> -		memset(&subd, 0, sizeof(struct a4l_subdevice));
> +		memset(subd, 0, sizeof(struct a4l_subdevice));
>   		memset(subd->priv, 0, sizeof(subd_8255_t));
>   
>   		subd_8255 = (subd_8255_t *)subd->priv;
> 

Applied to master and stable.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

