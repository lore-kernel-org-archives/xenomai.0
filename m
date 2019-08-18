Subject: Re: [PATCH] trank/rtdm: Add rt_dev_recvfrom() compat wrapper
References: <1566138373-14980-1-git-send-email-lists.tormod@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a5889bf8-ecc3-ae1d-7523-466d4702329b@xenomai.org>
Date: Sun, 18 Aug 2019 16:32:35 +0200
MIME-Version: 1.0
In-Reply-To: <1566138373-14980-1-git-send-email-lists.tormod@gmail.com>
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
To: Tormod Volden <lists.tormod@gmail.com>, xenomai@xenomai.org

On 8/18/19 4:26 PM, Tormod Volden via Xenomai wrote:
> From: Tormod Volden <debian.tormod@gmail.com>
> 
> Signed-off-by: Tormod Volden <debian.tormod@gmail.com>
> ---
> 
> I assume this one just fell through the cracks during a reorganization.
> 
> Should be safe for 3.0.x too.
> 
> Regards,
> Tormod
> 
> 
>  include/trank/rtdm/rtdm.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/trank/rtdm/rtdm.h b/include/trank/rtdm/rtdm.h
> index 9a0c965..80d874a 100644
> --- a/include/trank/rtdm/rtdm.h
> +++ b/include/trank/rtdm/rtdm.h
> @@ -35,6 +35,7 @@ extern "C" {
>  
>  #define rt_dev_open(__args...)		rt_dev_call(open, __args)
>  #define rt_dev_ioctl(__args...)		rt_dev_call(ioctl, __args)
> +#define rt_dev_recvfrom(__args...)	rt_dev_call(recvfrom, __args)
>  
>  static inline int rt_dev_socket(int domain, int type, int protocol)
>  {
> 

Ack.

-- 
Philippe.

