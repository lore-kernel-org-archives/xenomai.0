Message-ID: <53679A45.2060309@xenomai.org>
Date: Mon, 05 May 2014 16:03:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53676902.5050405@xenomai.org>
In-Reply-To: <53676902.5050405@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FreeRTOS skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/05/2014 12:33 PM, Philippe Gerum wrote:
> - vTaskSuspendAll()/vTaskResumeAll() maintain useless status flags.
> Copperplate provides __THREAD_S_SUSPENDED in the core status of threads
> for the very same purpose.

I believe in FreeRTOS vTaskSuspendAll/vTaskResumeAll is more like a task 
lock mechanism than a service suspending/resuming all tasks for real. Of 
course this only provides mutual exclusion on UP.


-- 
					    Gilles.

