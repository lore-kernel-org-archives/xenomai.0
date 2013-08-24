Message-ID: <521860C3.6030206@zultron.com>
Date: Sat, 24 Aug 2013 02:29:07 -0500
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <52147CD7.70400@siemens.com> <52147DF2.8060407@xenomai.org>
	<52147E94.6070309@siemens.com> <5214802B.9060001@siemens.com>
	<5214A55E.2070902@xenomai.org> <5214A886.30608@siemens.com>
	<5214A941.6070302@xenomai.org> <5214AA25.5070500@siemens.com>
	<5214AB5F.7050302@xenomai.org> <5214C300.40205@siemens.com>
In-Reply-To: <5214C300.40205@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] x86 port to kernel 3.10
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 08/21/2013 08:39 AM, Jan Kiszka wrote:
> Squashing or rebasing (I tried rebase --preserve-merges by now - not
> usable) means loosing track where the merges came from.

I recently used Peter Wortmann's rebase --interactive script, smartened
up for preserving merges, to get through a 1200+ commit/80+ merge rebase
of over a half year's work.  Saved a ton of tears (at least).

https://github.com/scpmw/git/commit/33c707d

Explanation in this commit:

https://github.com/scpmw/git/commit/fa11202

	John

