Subject: Re: An error occures when installing Xenomai libraries and tools
References: <tencent_50AA14110C851A8B665FF603EA5F8400F009@qq.com>
 <7a7726f326ca90ea2f1935d125bbc2ea6b33e456.camel@siemens.com>
 <f743f17c-77f5-6d41-85cb-c176669bc757@siemens.com>
 <18eb20162268e8303cdad7614a6ac704adb703e7.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <eda91c3b-81c2-94d2-f3fa-c8ad970a3bd0@siemens.com>
Date: Thu, 9 Sep 2021 17:02:58 +0200
MIME-Version: 1.0
In-Reply-To: <18eb20162268e8303cdad7614a6ac704adb703e7.camel@siemens.com>
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
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "rany97@qq.com" <rany97@qq.com>

On 09.09.21 16:47, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> On Thu, 2021-09-09 at 09:00 +0200, Jan Kiszka wrote:
>> On 09.09.21 08:55, Bezdeka, Florian via Xenomai wrote:
>>> On Thu, 2021-09-09 at 11:43 +0800, rany97 via Xenomai wrote:
>>>> Hi,
>>>>
>>>>
>>>> When I run "sudo make install" to install Xenomai libraries and tools, gcc reports an error posted below:
>>>> --------------------------------------------------------------------
>>>> /home/rany/build_rtos/xenomai/src/xenomai-3.1/lib/boilerplate/iniparser/iniparser.c: In function ‘iniparser_load’:
>>>> /home/rany/build_rtos/xenomai/src/xenomai-3.1/lib/boilerplate/iniparser/iniparser.c:616:13: error: ‘sprintf’ arguments 3, 4 may overlap destination object ‘buf’ [-Werror=restrict]
>>>> &nbsp; 616 |&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;sprintf(tmp, "%s:%s", section, key);
>>>> &nbsp; &nbsp; &nbsp; |&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> cc1: all warnings being treated as errors
>>>>
>>>> -------------------------------------------------------------------
>>>> Shall I ignore it?
>>>>
>>>> -------------------------------------------------------------------
>>>> Some info lost in last mail:
>>>> gcc 10.2.1
>>>> Linux debian 5.10.0-8-amd64 #1 SMP Debian 5.10.46-4 (2021-08-03) x86_64 GNU/Linux
>>>> Xenomai 3.1
>>>> -------------------------------------------------------------------
>>>
>>> I have the same setup here, and there is no such warning. There is no
>>> sprintf in iniparser.c:616. Are you sure it's Xenomai 3.1 you're
>>> looking at?
>>>
>>> Some time ago I had to update the iniparser (from its upstream source)
>>> to get rid of such compiler warnings.
>>>
>>
>> That fix was merged into master and stable/v3.1.x long ago. You just
>> need to use the latest stable release.
> 
> Just noticed that the stable/3.0 branch still has this issue. So maybe
> it was about 3.0 and not 3.1?
> 
> @Jan
> I noticed that 3.0 is broken when trying to update xenomai images to
> Debian 11. IOW: 3.0 is not buildable with Debian 11. Should we apply
> 
> 8acdbd718b78 ("lib/boilerplate/iniparser: Allow building with GCC 10.2 2020101")
> 
> to stable/3.0 as well? It applies cleanly.

Done, thanks.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

