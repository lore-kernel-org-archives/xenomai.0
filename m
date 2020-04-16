Subject: Re: [I-PIPE] ipipe-core-4.19.114-cip24-x86-12 released
References: <E1jP0Hl-00023d-8g@xenomai.org>
 <CAPnNZ0WM_0usCLzZaspWuJcbHVx3w6vG9QxDsBJxH68j+-QHjg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <16aa3b41-ea73-1da6-713d-ce088944e8ed@siemens.com>
Date: Thu, 16 Apr 2020 13:49:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAPnNZ0WM_0usCLzZaspWuJcbHVx3w6vG9QxDsBJxH68j+-QHjg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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
To: Antoine Hoarau <antoine@flr.io>, Xenomai <xenomai@xenomai.org>

On 16.04.20 13:18, Antoine Hoarau via Xenomai wrote:
> This is great ! Could you elaborate on the -cip meaning ?
> It is still not clear to me. Thanks !

Sure: It's a super-long-term stable kernel, based on standard LTS (as 
long as that is available), augmented with some BSP backports from newer 
kernel versions. For x86, the primary aspect is the maintenance period. 
4.19-cip has an projected EOL in early 2029.

See also 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmaintenance 
for more background.

Jan

> 
> Le jeu. 16 avr. 2020 à 10:54, xenomai--- via Xenomai <xenomai@xenomai.org>
> a écrit :
> 
>> Download URL:
>> https://xenomai.org/downloads/ipipe/v4.x/x86/ipipe-core-4.19.114-cip24-x86-12.patch
>>
>> Repository: https://git.xenomai.org/ipipe-x86
>> Release tag: ipipe-core-4.19.114-cip24-x86-12
>>
>>

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

