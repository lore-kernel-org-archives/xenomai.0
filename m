Message-ID: <2ff1a98a0805260456i44e3805eu5348067aff755c3f@domain.hid>
Date: Mon, 26 May 2008 13:56:52 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <8c12bab70805260214q785116eai976fe67d399b7040@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8c12bab70805260214q785116eai976fe67d399b7040@domain.hid>
Subject: Re: [Xenomai-help] Running xeno-test leaves behind "dd if /dev/zero
	of /dev/null"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: a.iqbal@domain.hid
Cc: xenomai@xenomai.org

On Mon, May 26, 2008 at 11:14 AM, Asif Iqbal <a.iqbal@domain.hid> wrote:
> Hello there
>
> Four days before, I checked out the svn head and compiled with 2.6.25.4
> kernel. VxWorks skin failed to compile (Really sorry but it didn't come to
> my mind to record the error). Removed VxWorks and everything worked fine.
>
> Now whenever I run xeno-test and exit using Ctrl-C, it leaves "dd if
> /dev/zero of /dev/null" task consuming 100% of the cpu until you manually
> kill the task. Is it a bug?

You have to tell us a bit more about your setup. What shell do you
use, do you have all the applications needed by xeno-test installed ?

-- 
 Gilles

