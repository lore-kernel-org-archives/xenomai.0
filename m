Message-ID: <52F4E8E1.4080008@xenomai.org>
Date: Fri, 07 Feb 2014 15:08:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52F3B77F.3020405@marel.com> <52F3C5DD.8010208@xenomai.org>
 <52F3DBDB.4060805@xenomai.org> <52F49F07.9040801@xenomai.org>
 <52F4E084.3020809@marel.com>
In-Reply-To: <52F4E084.3020809@marel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] High CPU load using q_send under pSOS skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marcel van Mierlo <marcel.vanmierlo@marel.com>
Cc: xenomai@xenomai.org

On 02/07/2014 02:32 PM, Marcel van Mierlo wrote:
> - I cant see how to set T_WARNSW using the pSOS skin.
>      - I get warning that "T_FPU" redefined when including native/task.h
> and psos+/psos.h
>      - If I hack the mask by using "0x00040000" explicitly I get
> SIGXCPU: CPU time limit exceeded when calling rt_task_set_mode at runtime.

The SIGXCPU is the indication that the problem occurs. You can:
- catch it with gdbserver/gdb and show us the result of the "backtrace" 
command;
- use glibc backtrace functionality to show the point where the problem 
happens as is demonstrated in examples/native/sigdebug.c

-- 
					    Gilles.

