Subject: Re: undefined symbol in tests
References: <CAPnNZ0UJEFhQXnmkH=RyBWVuXWiymw-S3jCcH+U5B_1VESALJA@mail.gmail.com>
 <cd4f3b32-d2bf-a96d-527a-5f7f3403e4d2@siemens.com>
 <CAPnNZ0Vt=mVk-JQoZM3TSGBBFOwqc+7KtnhtHVR89iLBo+cRqg@mail.gmail.com>
 <b6aa1c1a-7f68-c678-01ca-7cbb0fddffde@siemens.com>
 <CAPnNZ0Xv3gB5xnXaGN8wBfbgZgBB5XfDv9zBmyO9wD4T4WOBbA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c0ac33c8-51a8-d2c9-e8cf-088bc17f033a@siemens.com>
Date: Mon, 17 Feb 2020 17:51:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAPnNZ0Xv3gB5xnXaGN8wBfbgZgBB5XfDv9zBmyO9wD4T4WOBbA@mail.gmail.com>
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
To: Antoine Hoarau <antoine@flr.io>
Cc: Xenomai <xenomai@xenomai.org>

On 14.02.20 15:15, Antoine Hoarau wrote:
> I just built the debians:
> debchange -v 3.1 Release 3.1
> debuild -uc -us
> 

I've done that (well, minus debchange) on a Debian 10, installed a 
Xenomai kernel, and ran xeno-test - no problem. I would need this info:

ldd /usr/lib/xenomai/testsuite/libalchemy-test.so

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

