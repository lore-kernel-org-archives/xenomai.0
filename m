Subject: Re: [PATCH] Fixed long size in UDP port bitmap index
References: <CAG6b3Eos-mVCQHyHVh6Vr=4xr+ud_t+EsvW8o939i6MpJbcC6Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <53c1c8f2-4a5f-79f6-cc66-be13613563d7@siemens.com>
Date: Thu, 20 Feb 2020 08:29:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAG6b3Eos-mVCQHyHVh6Vr=4xr+ud_t+EsvW8o939i6MpJbcC6Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?TWF0w7rFoSBPbGVrxaHDoWs=?= <oleksak.matus@gmail.com>, xenomai@xenomai.org

On 19.02.20 19:59, Matúš Olekšák via Xenomai wrote:
> Hello,
> I am posting once again this patch. Now it is according CONTRIBUTING.md.
> There is issue when you are using 64bit Linux and increasing RT_UDP_SOCKETS
> above 64, because on 64 bit Linux long has 64 bits instead of hardcoded 32
> bits. This patch fixes the situation on both 32 and 64 bit OS.
> 
> Signed-off-by: Matúš Olekšák <oleksak.matus@gmail.com>
> ---
> kernel/drivers/net/stack/ipv4/udp/udp.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c
> b/kernel/drivers/net/stack/ipv4/udp/udp.c
> index 5e3679780..c26b4bd81 100644
> --- a/kernel/drivers/net/stack/ipv4/udp/udp.c
> +++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
> @@ -301,7 +301,7 @@ int rt_udp_socket(struct rtdm_fd *fd)
>                         break;
>         index = ffz(port_bitmap[i]);
>         set_bit(index, &port_bitmap[i]);
> -       index += i * 32;
> +       index += i * BITS_PER_LONG;
>         sock->prot.inet.reg_index = index;
>         sock->prot.inet.sport = index + auto_port_start;
> 
> --
> 2.25.1
> 

Massaged a bit to apply it (mail client eat all tabs, and the commit log 
(message body) needs to look like it shall be recorded in git).

Thanks!
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

