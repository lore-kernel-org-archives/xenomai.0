Message-ID: <50F19C76.8000001@xenomai.org>
Date: Sat, 12 Jan 2013 18:25:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1TtJG5-0003u8-9L@xenomai.org>
In-Reply-To: <E1TtJG5-0003u8-9L@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : configure: Report defaults
 for	smp/x86-sep/ x86-tsc in help output
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 01/10/2013 03:37 PM, GIT version control wrote:

> Module: xenomai-jki
> Branch: for-upstream
> Commit: 45aca4239b6e5c772a12962bcdbe75435f4ffec2
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=45aca4239b6e5c772a12962bcdbe75435f4ffec2
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Thu Jan 10 14:29:14 2013 +0100
> 
> configure: Report defaults for smp/x86-sep/x86-tsc in help output


why only the x86 options? The option defaults have never been documented
in configure help string, but in README.INSTALL (I just fixed the
defaults there instead). If we start documenting them in configure.in,
then all defaults options should be documented.

-- 
                                                                Gilles.

