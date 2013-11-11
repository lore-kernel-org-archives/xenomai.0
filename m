Message-ID: <5280AAD0.4070403@siemens.com>
Date: Mon, 11 Nov 2013 11:00:48 +0100
From: Gernot Hillier <gernot.hillier@siemens.com>
MIME-Version: 1.0
References: <527B5BBF.2040301@siemens.com> <527BD591.9060504@xenomai.org>
 <527C7CE6.6090603@siemens.com> <527D1E27.3030708@xenomai.org>
 <527D2AF3.5050904@siemens.com>
 <208C6975C932E94F86239FEA59CCA6323259C39F@AUSMXMBX02.mrws.biz>
In-Reply-To: <208C6975C932E94F86239FEA59CCA6323259C39F@AUSMXMBX02.mrws.biz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-forge] [PATCH] Silence unused_result warning
 from write()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi!

Am 11.11.2013 09:36, schrieb dietmar.schindler@manroland-web.com:
>> Von: Jan Kiszka
>> Gesendet: Freitag, 8. November 2013 19:18
>>
>> On 2013-11-08 18:23, Gilles Chanteperdrix wrote:
>>> On 11/08/2013 06:55 AM, Gernot Hillier wrote:
>>>> Am 07.11.2013 19:01, schrieb Gilles Chanteperdrix:
>>>>> On 11/07/2013 10:22 AM, Gernot Hillier wrote:
>>>>>> Some glibc versions mark write() with attribute warn_unused_result (found in
>>>>>> Ubuntu 12.04 / eglibc 2.15 / gcc 4.6.3), so we need to silence this warning,
>>>>>> especially when building with -Werror.
>>>>>
>>>>> Why not casting write result to void, it does not work?
>>>>>
>>>>
>>>> No, it doesn't. For rationale, please see
>>>> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=25509.
>>>>
>>> ...
>>>
>>> I believe you still can do:
>>>
>>> rc = write
>>> (void)rc
>>
>> Yep, that's what other projects do as well when there is really no use
>> for the return code.
>>
>>>
>>> The link you sent also indicates that the warning can be disabled with
>>> -Wno-unused-result
>>>
>>> Can you not compile with this option on distributions with this behaviour?
>>
>> Let's fix this in our source code, not in the ./configure command line.
>> I expect the warning to become more frequent with recent compilers
>> and/or distros.
> 
> Since this has been recognized as a bug
> http://sourceware.org/bugzilla/show_bug.cgi?id=11959 in glibc and
> fixed, it should become less frequent with recent distros. I think,
> source code shouldn't be cluttered with silly workarounds.

The glibc bug is about fwrite(), not write(). And one argument for removing
__wur in fwrite() was that errors can be checked explicitely with ferror() -
which is not true for write(). _wur is still here:

https://sourceware.org/git/?p=glibc.git;a=blob;f=posix/unistd.h;h=178223d7555702d133a51eaf8deaff7bfc5327aa;hb=HEAD

And even if we would file another bug for removing __wur from write(), I
seriously suspect that this will be accepted quickly and we'll see this
behaviour go away in recent distros anytime soon.

What do you think about this? Looks a bit more concise to me:

diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index 101a2bd..11c2a3a 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
@@ -53,7 +53,8 @@ int __rtdm_fd_start = INT_MAX;
 static void sigill_handler(int sig)
 {
 	const char m[] = "no Xenomai support in kernel?\n";
-	write(2, m, sizeof(m) - 1);
+	ssize_t rc __attribute__ ((unused));
+	rc = write(2, m, sizeof(m) - 1);
 	exit(EXIT_FAILURE);
 }
 
diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
index 7c5099b..32e59b5 100644
--- a/testsuite/latency/latency.c
+++ b/testsuite/latency/latency.c
@@ -507,7 +507,7 @@ static void sigdebug(int sig, siginfo_t *si, void *context)
 	case SIGDEBUG_WATCHDOG:
 		n = snprintf(buffer, sizeof(buffer), "%s\n",
 			     reason_str[reason]);
-		write(STDERR_FILENO, buffer, n);
+		n = write(STDERR_FILENO, buffer, n);
 		exit(EXIT_FAILURE);
 	}
 
-- 
Gernot

Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux


