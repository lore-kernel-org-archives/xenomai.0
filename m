Subject: Re: Preview: 4.19-x86 support
References: <4a035faa-d1f8-d2ed-9351-192cea2d79eb@siemens.com>
 <20190621180432.483ea4a0@md1za8fc.ad001.siemens.net>
 <7b7ff8c9-0faa-2a9b-5347-ee5361a978d0@siemens.com>
 <20190624131858.41860152@md1za8fc.ad001.siemens.net>
 <ced098bf-d5fc-6dc0-cc82-05a5eec1c45b@siemens.com>
 <20190627155612.32bfc242@md1za8fc.ad001.siemens.net>
 <018eeba9-c186-89d6-b152-ba12959c3a9f@siemens.com>
 <20190628144849.1a811ffb@md1za8fc.ad001.siemens.net>
 <e6a51d68-e544-c5bf-ae8a-b0f98b083ee9@siemens.com>
 <20190628154817.3824469d@md1za8fc.ad001.siemens.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <dfc5b82e-3665-fce2-d677-dfc4ae377256@siemens.com>
Date: Fri, 28 Jun 2019 16:00:17 +0200
MIME-Version: 1.0
In-Reply-To: <20190628154817.3824469d@md1za8fc.ad001.siemens.net>
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
To: Henning Schild <henning.schild@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 28.06.19 15:48, Henning Schild wrote:
> Am Fri, 28 Jun 2019 15:06:39 +0200
> schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> 
>> On 28.06.19 14:48, Henning Schild wrote:
>>>> BTW, regarding the failing smokey gdb test: Check if gdb is
>>>> available on the target. That is now a precondition.
>>>
>>> Yes it is. The $ N does not make any sense. It came from running a
>>> local copy without "make install". That is currently not supported
>>> by the gdb test, which should be fixed. People might want to test
>>> before installing, if just working on one machine.
>>
>> This works fine here:
>>
>> $ xenomai/build/testsuite/smokey/smokey --run=gdb
>> gdb OK
> 
> Running local, in a rootfs not containing an old version? The problem
> is launching smokey again from gdb. In my case the old smokey did not
> even know about "gdb".
> 

OK, I think I got it now. This should fix both issues:

diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
index 2fad3da19a..a6909d595b 100644
--- a/testsuite/smokey/gdb/gdb.c
+++ b/testsuite/smokey/gdb/gdb.c
@@ -274,8 +274,7 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 			snprintf(run_param, sizeof(run_param), "--run=%d",
 				 t->__reserved.id);
 			execl("/usr/bin/gdb", "gdb", "--args",
-			      CONFIG_XENO_PREFIX "/bin/smokey", run_param,
-			      "run_target", NULL);
+			      argv[0], run_param, "run_target", NULL);
 			_exit(ESRCH);
 
 		default:

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

