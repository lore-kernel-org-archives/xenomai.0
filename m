Subject: Re: Migrate project from Debian 8 Xenomai 2.x to Debain 9 Xenomai 3.x
References: <23edaf750b0b41ef9a129bbaf2758d9f@RCDC-MAIL09.corp.diehl.com>
 <0281e4a5-a2b2-bac5-1e30-ea2bb85f3d8d@siemens.com>
 <373cc865d6c34dda997ac6745bae99cd@RCDC-MAIL09.corp.diehl.com>
 <9cc5a0de-1db9-e46f-7aa8-30e41b1ac926@siemens.com>
 <f92ca27d1ba34380b47c0c451da4f61b@RCDC-MAIL09.corp.diehl.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <925e50f4-8395-2a15-3654-73ea1f241f1c@siemens.com>
Date: Mon, 10 Feb 2020 17:17:51 +0100
MIME-Version: 1.0
In-Reply-To: <f92ca27d1ba34380b47c0c451da4f61b@RCDC-MAIL09.corp.diehl.com>
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
To: Carsten EHRMANN <Carsten.Ehrmann@diehl.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10.02.20 16:27, Carsten EHRMANN wrote:
> Hi Jan,
> 
> I made a simple reproduction example (see attached 4 files).
> I got this error again:
> 
> In file included from main.cpp:28:0:
> /usr/xenomai/include/trank/native/task.h: In function ‘int rt_task_notify(RT_TASK*, rt_sigset_t)’:
> /usr/xenomai/include/trank/native/task.h:41:64: error: ‘trank_warning’ was not declared in this scope
>    trank_warning("in-kernel native API is gone, rebase over RTDM");
> 

Your makefile is incomplete, but this works fine here with Xenomai 3.1 
(I'm sure it does equally well with 3.0.x):

g++ -o main main.cpp $(xeno-config --skin=native --cflags --ldflags)

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

