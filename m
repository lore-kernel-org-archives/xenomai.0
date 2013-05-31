Message-ID: <51A835DE.5020409@xenomai.org>
Date: Fri, 31 May 2013 07:32:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4cacd80b.2131b.13ef60cf09e.Coremail.ericvic@163.com>
	<51A79898.50805@xenomai.org>
	<34806652.2924.13ef838eb26.Coremail.ericvic@163.com>
	<4855a071.2a22.13ef83b0d46.Coremail.ericvic@163.com>
In-Reply-To: <4855a071.2a22.13ef83b0d46.Coremail.ericvic@163.com>
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

On 05/31/2013 03:36 AM, 嵌入式工程师 wrote:

> The I-pipe path version is adeos-ipipe-2.6.35.9-arm-1.18-01.patch ,
> the kernal version is 2.6.35.9 ,i am so sorry for he details do not speak clearly


Hi,

there is no need to send your answer three times either. GPIO irqs are
broken with this version of the I-pipe kernel. Please try updating to
the I-pipe core patch for Linux 3.4 or 3.5.

Regards.

-- 
                                                                Gilles.

