MIME-Version: 1.0
Sender: patrickdepinguin@gmail.com
In-Reply-To: <524E85CE.1090309@siemens.com>
References: <CAAXf6LUfHA9aHe2FRngFJSKVXeKPVwxGLcRPYGNBqd7U1dMzKg@mail.gmail.com>
	<524E85CE.1090309@siemens.com>
Date: Fri, 4 Oct 2013 11:39:50 +0200
Message-ID: <CAAXf6LVRmTVz04kcPsb67iAZ630zW-KOuS4HyODsjG8gS+jDFg@mail.gmail.com>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] xenomai-forge: multiple COPYING files
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Hi Jan,

Thanks for your response.

On Fri, Oct 4, 2013 at 11:09 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> Having multiple, per-subdir COPYING files is by far not that uncommon.
> So improving buildroot for such scenarios seems worthwhile.

After my mail, I learned in the buildroot community that master
already contains a patch to fix this, by reproducing the directory
structure of the package when copying license files.

>
> That said, we need consolidation and clarification, specifically to
> cover all files outside kernel/cobalt, include and lib. Will write a
> patch, and another one to append suffixes to the subdir COPYING files.

Given the above, my use case no longer requires such suffixes to the
COPYING files. It still may be useful though for others.

Best regards,
Thomas

