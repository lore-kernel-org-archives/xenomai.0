References: <CADwKwfCSLMHEwJfQdiDnhuFC_fbgZYZkLKe5okG8BGcC82TguA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a9d7efb9-6f64-e038-07ed-181f7a816e20@xenomai.org>
Date: Sun, 25 Mar 2018 13:03:36 +0200
MIME-Version: 1.0
In-Reply-To: <CADwKwfCSLMHEwJfQdiDnhuFC_fbgZYZkLKe5okG8BGcC82TguA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_event_wait_timed() returns EFAULT error?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gabriel Aguirre-Ollinger <elgao68@gmail.com>, xenomai@xenomai.org

On 03/24/2018 02:55 PM, Gabriel Aguirre-Ollinger wrote:
> Hi,
> I'm running Xenomai/cobalt v3.0.5 on an Intel(R) Celeron(R) CPU. Currently
> I'm writing a real-time task loop that requires execution to stop until a
> signal with a certain integer value is received. Thus I've included a call
> to rt_event_wait_timed() to wait for the appropriate value to be written to
> the mask; I'm specifying a NULL timeout value. The problem I have is that
> rt_event_wait_timed() consistently returns EFAULT ('bad address') and
> returns without blocking. I don't know what this error means since it is
> not even considered in the Xenomai manual documentation as one of the
> possible returns for rt_event_wait_timed().

Assuming that EFAULT means the same thing here than anywhere else should
be a safe bet.

 I have also tried
> rt_event_wait() with the exact same result. Any help will be appreciated.
> 

You may be looking at the wrong place: NULL timeout is fine, NULL mask_r
(for collecting the result mask) is not.

-- 
Philippe.

