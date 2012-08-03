Message-ID: <501BC31A.6090702@xenomai.org>
Date: Fri, 03 Aug 2012 14:24:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAGVaUoE6O+Hi1DwCjfHZne0BD5R0z1ErobrP-CVtz2XgjtQKDg@mail.gmail.com>	<501B9009.2040406@xenomai.org>
	<CAGVaUoHQk2y2WaEk-+zzuTawGF8JkMkHPgUVMqLoHOMo8n8q9Q@mail.gmail.com>
In-Reply-To: <CAGVaUoHQk2y2WaEk-+zzuTawGF8JkMkHPgUVMqLoHOMo8n8q9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Link error for the Xenomai 2.6.1 example
	"trivial-periodic.c"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bao Rui <rbaocug@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 08/03/2012 01:39 PM, Bao Rui wrote:
> Hi Gilles,
> 
> Thanks for your reply! I think it is not the same issue. I installed
> xenomai already, and them I want to compile the example\native. Here is my
> compile command:
> gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__   -lnative
> -L/usr/xenomai/lib -lxenomai -lpthread -lrt  -Xlinker -rpath -Xlinker
> /usr/xenomai/lib  trivial-periodic.c   -o trivial-periodic

When link-editing, the link order is important, so, -lnative should come
after trivial-periodic.c

Please no private mails.

-- 
					    Gilles.

