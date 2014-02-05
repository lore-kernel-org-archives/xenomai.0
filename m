Message-ID: <52F27A1D.1000407@xenomai.org>
Date: Wed, 05 Feb 2014 18:51:25 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <52F275D8.6070303@siemens.com>
In-Reply-To: <52F275D8.6070303@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] forge: API header cobalt/arith.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 02/05/2014 06:33 PM, Jan Kiszka wrote:
> Hi,
>
> while testing stand-alone builds of all installed headers, I also
> stumbled over cobalt/arith.h. It seems this one is not part of the
> external API, is it? It tries to pull in headers from asm/xenomai/ which
> is not available for ordinary applications. Should I simply skip it from
> being tested, or can we drop it from the set of installed headers?
>

This one is not part of the API and should move to noinst_HEADERS.

-- 
Philippe.

