Subject: Re: [PATCH 2/2] ipipe: drop build left-over
References: <20181205152534.28290-1-rpm@xenomai.org>
 <20181205152534.28290-2-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <72486e5a-bd13-48a3-1178-113f81d69398@siemens.com>
Date: Thu, 6 Dec 2018 08:03:20 +0100
MIME-Version: 1.0
In-Reply-To: <20181205152534.28290-2-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 05.12.18 16:25, Philippe Gerum wrote:
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   drivers/scsi/scsi_devinfo_tbl.c | 25 -------------------------
>   1 file changed, 25 deletions(-)
>   delete mode 100644 drivers/scsi/scsi_devinfo_tbl.c
> 
> diff --git a/drivers/scsi/scsi_devinfo_tbl.c b/drivers/scsi/scsi_devinfo_tbl.c
> deleted file mode 100644
> index 6a7f155b1f13..000000000000
> --- a/drivers/scsi/scsi_devinfo_tbl.c
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -BLIST_FLAG_NAME(NOLUN),
> -BLIST_FLAG_NAME(FORCELUN),
> -BLIST_FLAG_NAME(BORKEN),
> -BLIST_FLAG_NAME(KEY),
> -BLIST_FLAG_NAME(SINGLELUN),
> -BLIST_FLAG_NAME(NOTQ),
> -BLIST_FLAG_NAME(SPARSELUN),
> -BLIST_FLAG_NAME(MAX5LUN),
> -BLIST_FLAG_NAME(ISROM),
> -BLIST_FLAG_NAME(LARGELUN),
> -BLIST_FLAG_NAME(INQUIRY_36),
> -BLIST_FLAG_NAME(NOSTARTONADD),
> -BLIST_FLAG_NAME(REPORTLUN2),
> -BLIST_FLAG_NAME(NOREPORTLUN),
> -BLIST_FLAG_NAME(NOT_LOCKABLE),
> -BLIST_FLAG_NAME(NO_ULD_ATTACH),
> -BLIST_FLAG_NAME(SELECT_NO_ATN),
> -BLIST_FLAG_NAME(RETRY_HWERROR),
> -BLIST_FLAG_NAME(MAX_512),
> -BLIST_FLAG_NAME(NO_DIF),
> -BLIST_FLAG_NAME(SKIP_VPD_PAGES),
> -BLIST_FLAG_NAME(TRY_VPD_PAGES),
> -BLIST_FLAG_NAME(NO_RSOC),
> -BLIST_FLAG_NAME(MAX_1024),
> -BLIST_FLAG_NAME(UNMAP_LIMIT_WS),
> 

Thanks applied both the 4.9 and the first one to 4.4 as well.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

