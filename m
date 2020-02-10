Subject: Re: Migrate project from Debian 8 Xenomai 2.x to Debain 9 Xenomai 3.x
References: <23edaf750b0b41ef9a129bbaf2758d9f@RCDC-MAIL09.corp.diehl.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0281e4a5-a2b2-bac5-1e30-ea2bb85f3d8d@siemens.com>
Date: Mon, 10 Feb 2020 14:22:41 +0100
MIME-Version: 1.0
In-Reply-To: <23edaf750b0b41ef9a129bbaf2758d9f@RCDC-MAIL09.corp.diehl.com>
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
To: Carsten EHRMANN <Carsten.Ehrmann@diehl.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10.02.20 13:03, Carsten EHRMANN via Xenomai wrote:
> Hello,
> 
> 
> Because of new PC hardware I have to use debain 9 and Xenomai 3. Xenomai is running on the system, I run the testsuite scripts. I found a migration document on xenomai.org and changed the includepaths and so on in my sourcecode. But now when I want to compile the code I got this error
> In file included from ./CSRTPosixQue.h:20:0,
>               from ./CSRTTask.h:20,
>               from main.cpp:26:
> /usr/xenomai/include/trank/native/task.h: In function 'int rt_task_notify(RT_TASK*, rt_sigset_t)':
> /usr/xenomai/include/trank/native/task.h:41:64: error: 'trank_warning' was not declared in this scope
> trank_warning("in-kernel native API is gone, rebase over RTDM");
> 
> But this "trank_warning" is defined in trank.h which is included
> 

Where you using xeno-config to obtain paths and other compiler switches? 
If not, please compare your settings. If yes, a simple test case would 
be nice. But it can't be very simple because

#include <native/task.h>
int main() {}

compiles via "gcc $(xeno-config --skin native --cflags) ..."

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

