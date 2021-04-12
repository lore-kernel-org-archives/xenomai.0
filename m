Subject: Re: [xenomai-images][PATCH] linux-xenomai: x86: Enable vfat support
 for UEFI boot
References: <20210408151255.946852-1-florian.bezdeka@siemens.com>
 <1312625a-17c9-801a-719a-08068b697b25@siemens.com>
 <0aef13f824395e02ddbf66e57c64b4577a0151ba.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <07bb46d6-848d-28fe-9cdf-569497c13a04@siemens.com>
Date: Mon, 12 Apr 2021 09:46:32 +0200
MIME-Version: 1.0
In-Reply-To: <0aef13f824395e02ddbf66e57c64b4577a0151ba.camel@siemens.com>
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
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12.04.21 09:45, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> On Thu, 2021-04-08 at 19:24 +0200, Jan Kiszka wrote:
>> On 08.04.21 17:12, Florian Bezdeka wrote:
>>> Trying to boot up the example image on an x86 board with UEFI failed
>>> because vfat support was missing. The x86 defconfig has been
>>> re-synchronized with the arm64 defconfig to enable UEFI boot support.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  recipes-kernel/linux/files/amd64_defconfig | 11 +++++++----
>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/recipes-kernel/linux/files/amd64_defconfig b/recipes-kernel/linux/files/amd64_defconfig
>>> index bc5cd0b..2b7e63f 100644
>>> --- a/recipes-kernel/linux/files/amd64_defconfig
>>> +++ b/recipes-kernel/linux/files/amd64_defconfig
>>> @@ -3609,7 +3609,10 @@ CONFIG_FSCACHE_HISTOGRAM=y
>>>  # DOS/FAT/NT Filesystems
>>>  #
>>>  # CONFIG_MSDOS_FS is not set
>>> -# CONFIG_VFAT_FS is not set
>>> +CONFIG_VFAT_FS=y
>>> +CONFIG_FAT_DEFAULT_CODEPAGE=437
>>> +CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
>>> +# CONFIG_FAT_DEFAULT_UTF8 is not set
>>>  # CONFIG_NTFS_FS is not set
>>>  #
>>> @@ -3681,8 +3684,8 @@ CONFIG_9P_FSCACHE=y
>>>  CONFIG_9P_FS_POSIX_ACL=y
>>>  # CONFIG_9P_FS_SECURITY is not set
>>>  CONFIG_NLS=y
>>> -CONFIG_NLS_DEFAULT="cp437"
>>> -# CONFIG_NLS_CODEPAGE_437 is not set
>>> +CONFIG_NLS_DEFAULT="iso8859-1"
>>> +CONFIG_NLS_CODEPAGE_437=y
>>>  # CONFIG_NLS_CODEPAGE_737 is not set
>>>  # CONFIG_NLS_CODEPAGE_775 is not set
>>>  # CONFIG_NLS_CODEPAGE_850 is not set
>>> @@ -3706,7 +3709,7 @@ CONFIG_NLS_DEFAULT="cp437"
>>>  # CONFIG_NLS_CODEPAGE_1250 is not set
>>>  # CONFIG_NLS_CODEPAGE_1251 is not set
>>>  # CONFIG_NLS_ASCII is not set
>>> -# CONFIG_NLS_ISO8859_1 is not set
>>> +CONFIG_NLS_ISO8859_1=y
>>>  # CONFIG_NLS_ISO8859_2 is not set
>>>  # CONFIG_NLS_ISO8859_3 is not set
>>>  # CONFIG_NLS_ISO8859_4 is not set
>>>
>>
>> I wonder if we should rather store a savedefconfig result here. That
>> might have prevented this. Or are those options not part of the
>> x86_64-defconfig?
> 
> On the long run: Yes, sounds reasonable.
> 
> Converting that to a defconfig now will trigger a lot of reformatting,
> resulting in a big diff. Other configs (arm64, armhf) are affected as
> well. Maybe something we should postpone to 3.2, so we get the
> necessary testing?

I'm fine with doing that as a separate patch, but already because of the
broad range of kernel versions we are testing NOW (4.4 - 5.10), we
should convert ASAP.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

