Subject: Re: Preview: 4.19-x86 support
References: <4a035faa-d1f8-d2ed-9351-192cea2d79eb@siemens.com>
 <20190621180432.483ea4a0@md1za8fc.ad001.siemens.net>
 <7b7ff8c9-0faa-2a9b-5347-ee5361a978d0@siemens.com>
 <20190624131858.41860152@md1za8fc.ad001.siemens.net>
 <ced098bf-d5fc-6dc0-cc82-05a5eec1c45b@siemens.com>
 <20190627155612.32bfc242@md1za8fc.ad001.siemens.net>
 <018eeba9-c186-89d6-b152-ba12959c3a9f@siemens.com>
 <20190628144849.1a811ffb@md1za8fc.ad001.siemens.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e6a51d68-e544-c5bf-ae8a-b0f98b083ee9@siemens.com>
Date: Fri, 28 Jun 2019 15:06:39 +0200
MIME-Version: 1.0
In-Reply-To: <20190628144849.1a811ffb@md1za8fc.ad001.siemens.net>
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
To: Henning Schild <henning.schild@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 28.06.19 14:48, Henning Schild wrote:
>> BTW, regarding the failing smokey gdb test: Check if gdb is available
>> on the target. That is now a precondition.
> 
> Yes it is. The $ N does not make any sense. It came from running a
> local copy without "make install". That is currently not supported by
> the gdb test, which should be fixed. People might want to test before
> installing, if just working on one machine.

This works fine here:

$ xenomai/build/testsuite/smokey/smokey --run=gdb
gdb OK

> 
> After that i run into
>>> FAILURE run_gdb:290: checking expression "primary_mode", expected
>>> "1", found "0
> 

Can't reproduce. And given that line 290 in master does not contain any code, I 
strongly suspect your build is inconsistent.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

