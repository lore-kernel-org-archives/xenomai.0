Subject: Re: Alchemy API queue size issue
References: <AM0PR07MB54107060F24921876BC65F77E6F60@AM0PR07MB5410.eurprd07.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3c7280ad-32bb-4da1-0eda-17ee1a57e028@siemens.com>
Date: Tue, 17 Mar 2020 18:29:25 +0100
MIME-Version: 1.0
In-Reply-To: <AM0PR07MB54107060F24921876BC65F77E6F60@AM0PR07MB5410.eurprd07.prod.outlook.com>
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
To: "Merckx, Sebastiaan (Nokia - BE/Antwerp)" <sebastiaan.merckx@nokia.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 17.03.20 11:26, Merckx, Sebastiaan (Nokia - BE/Antwerp) via Xenomai 
wrote:
> Hello,
> 
> We noticed a bug in the alchemy API of xenomai library. The allocated memory for queues seemed too big.
> I assume that below is the fix (and we are using the patch internally).
> Let me know if you need more info or if this would not be correct.
> 
> Best Regards,
> Sebastiaan Merckx
> 
> diff --git a/lib/alchemy/queue.c b/lib/alchemy/queue.c
> --- a/lib/alchemy/queue.c
> +++ b/lib/alchemy/queue.c
> @@ -261,7 +261,7 @@ int rt_queue_create(RT_QUEUE *queue, con
>                                     poolsize + (poolsize * 5 / 100));
>          else
>                  ret = heapobj_init_array(&qcb->hobj, qcb->name,
> -                                        (poolsize / qlimit) *
> +                                        (poolsize / qlimit) +
>                                           sizeof(struct alchemy_queue_msg),
>                                           qlimit);
>          if (ret)
> 

That was fixed in 5e54f18b640e, available since v3.0.4. I suppose you 
are sitting on a seriously outdated branch. ;)

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

