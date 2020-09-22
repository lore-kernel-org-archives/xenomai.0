Subject: Re: [RFC PATCH] Multi-library support with core suffix in soname
References: <20200920192808.13637-1-vt@altlinux.org>
 <20200921135136.ckf3cvlhzgezxxuv@altlinux.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0cd5de4f-714b-96bf-f33f-6cb0b9fa42fa@siemens.com>
Date: Tue, 22 Sep 2020 17:23:32 +0200
MIME-Version: 1.0
In-Reply-To: <20200921135136.ckf3cvlhzgezxxuv@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
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
To: Vitaly Chikunov <vt@altlinux.org>, Xenomai <xenomai@xenomai.org>

On 21.09.20 15:51, Vitaly Chikunov wrote:
> On Sun, Sep 20, 2020 at 10:28:08PM +0300, Vitaly Chikunov wrote:
>> This will allow (for users) installing both versions of libs into the
>> same system and (for distributions) having them without conflicts in
>> the same repository.
> 
> I forgot we need to install xeno_config.h somewhere somehow. Otherwise,
> it would be overwritten by other core.
> 

Will that need support from Xenomai, or will you have to handle that at 
packaging level anyway?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

