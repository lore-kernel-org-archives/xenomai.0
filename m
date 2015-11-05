Date: Thu, 5 Nov 2015 19:30:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151105183035.GH16314@hermes.click-hack.org>
References: <20151105105550.GB16314@hermes.click-hack.org>
 <1446747752-8396-1-git-send-email-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1446747752-8396-1-git-send-email-henning.schild@siemens.com>
Subject: Re: [Xenomai] [PATCH] scripts: increase number of Xs in mktemp
 template
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: xenomai@xenomai.org

On Thu, Nov 05, 2015 at 07:22:32PM +0100, Henning Schild wrote:
> In a5cfe9c9a8dbcc094b0c5043b21fa6cde7fc42e5 the use of mktemp was
> introduces. Some versions of mktemp seem to require a template of at
> least 6 Xs.

not at least. Exactly 6 Xs. And this requirement is actually part of
the POSIX standard:
http://pubs.opengroup.org/onlinepubs/9699919799/functions/mkstemp.html

-- 
					    Gilles.
https://click-hack.org

