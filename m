References: <1481114381-17548-1-git-send-email-leupold@rsi-elektrotechnik.de>
From: Jorge Ramirez <jro@xenomai.org>
Message-ID: <965cb08c-9a13-da03-4cf5-060ce94cae6e@xenomai.org>
Date: Mon, 12 Dec 2016 16:55:27 +0100
MIME-Version: 1.0
In-Reply-To: <1481114381-17548-1-git-send-email-leupold@rsi-elektrotechnik.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] analogy: fix __a4l_get_sbsize() if device has
 only one subdevice
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Leupold <leupold@rsi-elektrotechnik.de>, xenomai@xenomai.org

On 12/07/2016 01:39 PM, Jan Leupold wrote:
> All a4l_sbinfo_t are handled in __a4l_fill_desc() as a contiguous array
> and is stored as data in a4l_root_t. The old code allocated enough
> memory when the device had at least two subdevices, but missed 8 bytes
> (on ARM32), which is the difference between sizeof(a4l_root_t) and
> sizeof(a4l_leaf_t).

sorry I dont understand this patch. could you expand on the scenario you 
are testing?
a4l_root_setup already takes into consideration the size of the 
a4l_root_t (check the offset initialization)



> ---
>   lib/analogy/descriptor.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/analogy/descriptor.c b/lib/analogy/descriptor.c
> index bc4d7bd..fa8cf93 100644
> --- a/lib/analogy/descriptor.c
> +++ b/lib/analogy/descriptor.c
> @@ -100,8 +100,9 @@ static inline a4l_leaf_t *a4l_leaf_get(a4l_leaf_t * lf,
>   static int __a4l_get_sbsize(int fd, a4l_desc_t * dsc)
>   {
>   	unsigned int i, j, nb_chan, nb_rng;
> +	/* all subdevice a4l_sbinfo_t are within one special leaf: the root */
>   	int ret, res =
> -		dsc->nb_subd * (sizeof(a4l_sbinfo_t) + sizeof(a4l_leaf_t));
> +		sizeof(a4l_root_t) + dsc->nb_subd * (sizeof(a4l_sbinfo_t));
>   
>   	for (i = 0; i < dsc->nb_subd; i++) {
>   
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

