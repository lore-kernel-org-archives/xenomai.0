Message-ID: <4EE714F2.4010600@domain.hid>
Date: Tue, 13 Dec 2011 10:03:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAO0Fu5Bh-PUZuyzL+hZWJJQ9wCJs8pmnZ6=+rkuVs0Xuc=1TxQ@mail.gmail.com>
In-Reply-To: <CAO0Fu5Bh-PUZuyzL+hZWJJQ9wCJs8pmnZ6=+rkuVs0Xuc=1TxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] When startup the preemptive priority-base
 scheduling, at the start pont, I observed the output with wrong order.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Lifeng Wang <lfwangcn@domain.hid>
Cc: xenomai@xenomai.org

On 12/13/2011 03:48 AM, Lifeng Wang wrote:
> Why is it not?
> Can someone tell me why and tell me how to write the correct code for the
> preemptive priority-base scheduling.

rt_printf does not preserve the order of prints between tasks. Besides
with rt_print_auto_init, the first rt_printf may cause a call to malloc,
which may cause a switch to secondary mode.

So you should not rely on what the test prints.

-- 
                                                                Gilles.

