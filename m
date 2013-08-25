Message-ID: <521A3D55.7030704@xenomai.org>
Date: Sun, 25 Aug 2013 19:22:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52162B30.6030602@siemens.com>
In-Reply-To: <52162B30.6030602@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] debian: cleanup configure invocation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gernot Hillier <gernot.hillier@siemens.com>
Cc: xenomai@xenomai.org

On 08/22/2013 05:16 PM, Gernot Hillier wrote:
> Remove duplicated testdir setting. This re-adds a useful part of
> c6264554 reverted in 9445b03a. We shall not override/extend CONFIG_OPTS
> as it's also used for the package description of libxenomai1 (see
> binary-arch target).

Merged, thanks.

-- 
                                                                Gilles.

