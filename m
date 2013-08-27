Message-ID: <521CAA48.9070707@siemens.com>
Date: Tue, 27 Aug 2013 15:31:52 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <52147CD7.70400@siemens.com> <52147DF2.8060407@xenomai.org>
	<52147E94.6070309@siemens.com> <5214802B.9060001@siemens.com>
	<5214A55E.2070902@xenomai.org> <5214A886.30608@siemens.com>
	<5214A941.6070302@xenomai.org> <5214AA25.5070500@siemens.com>
	<5214AB5F.7050302@xenomai.org> <5214C300.40205@siemens.com>
	<5215059B.7020309@xenomai.org> <5215C1D1.1020707@siemens.com>
	<f45934df5baec3a570da12209565f49f.squirrel@127.0.0.1>
	<52164117.5080801@siemens.com>
In-Reply-To: <52164117.5080801@siemens.com>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>
Cc: John Morris <john@zultron.com>, Xenomai <xenomai@xenomai.org>

On 2013-08-22 18:49, Jan Kiszka wrote:
> OK, then I will redo the merge of 3.10 in a single commit, but
> preserving the work of Philippe for 3.9.

Done, result can be found again at

git://git.xenomai.org/ipipe-jki.git next-x86

Gilles, Philippe, you may want to try John's suggestion and install that
patched git version. It allows to amend also merge commits (or reorder
them), thus could enable a workflow where the arch maintainers fixes up
the merges. The downside: it is awfully slow. I had to wait 15 min. or
so for git rebase -ip to give me the todo file and several minutes more
to see the changes applied (I fixed up my own merge with a forgotten hunk).

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

