Message-ID: <50F1B37E.3030502@xenomai.org>
Date: Sat, 12 Jan 2013 20:03:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50F19CE1.5080106@zultron.com>
In-Reply-To: <50F19CE1.5080106@zultron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel OOPS during regression tests
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: Xenomai <xenomai@xenomai.org>

On 01/12/2013 06:26 PM, John Morris wrote:>

> The kernel is built from the elrepo.org kernel, and this config file
> overrides the upstream config; makes it easy to see the Xenomai-specific
> changes:
> https://github.com/zultron/kernel-ml/blob/branch3.5.3-xeno/config-3.5.3-xenomai-x86_64


It seems a really bad idea to enable the SMI workaround by default.

-- 
                                                                Gilles.

