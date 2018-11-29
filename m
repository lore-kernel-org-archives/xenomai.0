Subject: Re: every millicsecond interrupt in xenomai domain on a am355x board
 can cause something wrong?
References: <6a75de9a.bb14.1675e7e151a.Coremail.liang_1911@163.com>
 <197e47f6-23b4-83c6-432d-f10996d4fc6f@siemens.com>
 <37a4c1e3.110ab.167600a0f56.Coremail.liang_1911@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <db92a4fc-b678-d86d-8a95-856369b87031@siemens.com>
Date: Thu, 29 Nov 2018 16:25:30 +0100
MIME-Version: 1.0
In-Reply-To: <37a4c1e3.110ab.167600a0f56.Coremail.liang_1911@163.com>
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
To: =?UTF-8?B?5qKB5p2D?= <liang_1911@163.com>
Cc: xenomai@xenomai.org

On 29.11.18 16:15, 梁权 wrote:
> The linux 4.14.67 which i used is from the latest TI Linux Processor SDK for 
> AM335x;  when i patch it with the /ipipe-core-4.14.71-arm-4.patch，/
> i did not need to do any change except that  telling where the file dmtimer.c is;
> i guess it is because that in linux 4.14.67 the location of dmtimer.c is 
> different from which in linux 4.14.71
> 

Could you try if you can reproduce the issue with vanilla 4.14.71 + I-pipe? Just 
to exclude downstream issues.

I think there is no longer a need for a downstream kernel on that board, but I 
might be wrong (which would be sad).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

