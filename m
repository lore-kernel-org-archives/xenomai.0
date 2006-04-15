Message-ID: <4441699E.6080200@domain.hid>
Date: Sat, 15 Apr 2006 23:46:06 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] linux-2.6.14 with adeos kernel built error for ppc
References: <2cf1ee820604130545r5bd06b4by579fa74321ac269f@domain.hid>
In-Reply-To: <2cf1ee820604130545r5bd06b4by579fa74321ac269f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: emin ak <eminak71@domain.hid>
Cc: xenomai@xenomai.org

emin ak wrote:
> Dear All;
> I have tried to build xenomai (latest snapshot from svn) for a pcc
> target (mpc85xx). while preemptive enable on kernel configuration
> (CONFIG_PREEMPT=y) , build fails with below error messages, but
> disabling preemptition solves the problem. Any comment?
> I have attached working and buggy configuration files.

This patch includes a fix for the issue.

http://download.gna.org/adeos/patches/v2.6/ppc/adeos-ipipe-2.6.14-ppc-1.2-02.patch

-- 

Philippe.

