Message-ID: <51B42B8C.9030202@xenomai.org>
Date: Sun, 09 Jun 2013 09:15:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <44b485fd.1ee68.13f24728cbf.Coremail.ericvic@163.com>
	<51B368EF.3060301@xenomai.org>
	<1920c252.310b.13f26c3cd2d.Coremail.ericvic@163.com>
In-Reply-To: <1920c252.310b.13f26c3cd2d.Coremail.ericvic@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Set gpio irq priority with tzic_set_irq_prio(int irq, int hi)
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

On 06/09/2013 04:28 AM, 嵌入式工程师 wrote:

> Then what should change the priority please？


Again, you can not change the priority, all gpio irqs have the same
priority.

-- 
                                                                Gilles.

