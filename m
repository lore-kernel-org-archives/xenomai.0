Message-ID: <51AF83F8.2040703@xenomai.org>
Date: Wed, 05 Jun 2013 20:31:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4cacd80b.2131b.13ef60cf09e.Coremail.ericvic@163.com>
	<51A79898.50805@xenomai.org>
	<34806652.2924.13ef838eb26.Coremail.ericvic@163.com>
	<4855a071.2a22.13ef83b0d46.Coremail.ericvic@163.com>
	<51A835DE.5020409@xenomai.org>
	<700980f4.7d37.13ef927183f.Coremail.ericvic@163.com>
	<27b32d48.5247.13efee65625.Coremail.ericvic@163.com>
	<51A9C9EF.2040702@xenomai.org>
	<37d33293.2abd.13f07ada45c.Coremail.ericvic@163.com>
	<51AC31A2.5010907@xenomai.org>
	<7b78f3e.c5e4.13f092364eb.Coremail.ericvic@163.com>
	<51AC8209.4060507@xenomai.org>
	<2bb4890b.c7e9.13f14c2da98.Coremail.ericvic@163.com>
In-Reply-To: <2bb4890b.c7e9.13f14c2da98.Coremail.ericvic@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] freescale(imx53)  with xenomai patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
Cc: xenomai@xenomai.org

On 06/05/2013 04:34 PM, 嵌入式工程师 wrote:

> Now ，I suddenly noticed,P and V operation must not be interrupted operation.


They can not be, they grab the nucleus spinlock.

> Before I did not know my colleague spent rt_sem_p () and rt_sem_v ().
> Today, I suddenly saw it.
> I also would like to ask, rt_alarm_inquire is available in rt_sem_v () operation, timing counts?
> Because they are in the case with a timer but also a very accurate timekeeping pv operation.


I am sorry, but I do not understand what you ask. The unit of the
timings used and returned by the native skin services is documented in
the API documentation.

Besides, using the native API to handle interrupts is deprecated.

-- 
                                                                Gilles.

