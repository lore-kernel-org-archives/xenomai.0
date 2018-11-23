Subject: Re: [PATCH][xenomai-images] start-qemu.sh: detect if DISPLAY is set
References: <20181122204348.17730-1-holzmayr@rsi-elektrotechnik.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4a809d39-ed55-cbef-f8b5-74f6d8b590c5@siemens.com>
Date: Fri, 23 Nov 2018 12:14:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181122204348.17730-1-holzmayr@rsi-elektrotechnik.de>
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
To: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>
Cc: xenomai@xenomai.org

On 22.11.18 21:43, Josef Holzmayr wrote:
> If DISPLAY is not set and therefore the SDL-based
> GUI of QEMU is most likely to fail, we resort to the
> -nographic variant.
> 
> Signed-off-by: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>
> ---
>   start-qemu.sh | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/start-qemu.sh b/start-qemu.sh
> index 3d1117e..0daf69c 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -63,6 +63,10 @@ IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
>   KERNEL_FILE=$(ls ${IMAGE_PREFIX}.vmlinuz* | tail -1)
>   INITRD_FILE=$(ls ${IMAGE_PREFIX}.initrd.img* | tail -1)
>   
> +if [ -z "${DISPLAY}" ]; then
> +	QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} -nographic"
> +fi
> +
>   shift 1
>   
>   ${QEMU_PATH}${QEMU} \
> 

Thanks, applied to https://gitlab.denx.de/Xenomai/xenomai-images

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

