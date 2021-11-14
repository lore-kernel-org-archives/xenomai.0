Subject: Re: native message queue API in rtdm
References: <CA+K1mPFKAZUUwv_rA1msEThhBQa8oVrPLMkc2fYkorW=zcQ+3w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <83795136-096b-6618-599b-9e5ce7af6284@siemens.com>
Date: Sun, 14 Nov 2021 20:59:50 +0100
MIME-Version: 1.0
In-Reply-To: <CA+K1mPFKAZUUwv_rA1msEThhBQa8oVrPLMkc2fYkorW=zcQ+3w@mail.gmail.com>
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
To: C Smith <csmithquestions@gmail.com>, Xenomai List <xenomai@xenomai.org>

On 13.11.21 08:49, C Smith via Xenomai wrote:
> Can I call rt_queue_create() and rt_queue_read() from an rtdm kernel module ?
> This used to work OK in Xenomai 2 but now in Xeno3.1 when I attempt to
> #include <native/queue.h> in my rtdm code I get this error:
> In file included from /usr/xenomai/include/alchemy/queue.h:21,
>                  from /usr/xenomai/include/trank/native/queue.h:21,
>                  from /home/csmith/src/my_app.c:16:
> /usr/lib/gcc/x86_64-redhat-linux/8/include/stdint.h:9:26: error: no
> include path in which to search for stdint.h
>  # include_next <stdint.h>
> 

The in-kernel skin APIs (except for RTDM, obviously) where deprecated
with Xenomai 3.0. Drivers should use RTDM services and interfaces in
order to provide services to applications.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

