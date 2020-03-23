Subject: Re: [xenomai-images PATCH 0/2] Add support for x86(32bit)
References: <20200214083819.31451-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <44e9c257-f95b-9d39-8b0c-b81a6e91bae2@siemens.com>
Date: Mon, 23 Mar 2020 16:45:38 +0100
MIME-Version: 1.0
In-Reply-To: <20200214083819.31451-1-Quirin.Gylstorff@siemens.com>
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

On 14.02.20 09:38, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add missing entry for x86 32 build. Allow overwrite of derived
> isar layers. Patch is send upstream to isar.
> 
> Quirin Gylstorff (2):
>    recipes-kernel/linux-xenomai: Add support for DISTRO_ARCH i386
>    recipes-kernel/linux: Allow overwrite of KERNEL_DEFCONFIG
> 
>   kas.yml                                       |  4 +++
>   ...inux-Weak-KERNEL_DEFCONFIG-to-allow-.patch | 29 +++++++++++++++++++
>   recipes-kernel/linux/linux-xenomai.inc        |  4 +--
>   3 files changed, 35 insertions(+), 2 deletions(-)
>   create mode 100644 patches/0001-recipes-kernel-linux-Weak-KERNEL_DEFCONFIG-to-allow-.patch
> 

Thanks, finally applied to next.

I've also pinged upstream Isar on the patch we carry in the second commit.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

