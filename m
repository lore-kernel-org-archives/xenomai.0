Message-ID: <4F9D64AF.20906@domain.hid>
Date: Sun, 29 Apr 2012 17:56:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CALH4WdZ3zVeXeapCjUc_usPb4AreGjecPXaLjL_SWZzJ_mo0eQ@mail.gmail.com>	<4F97E4AA.8090502@domain.hid>
	<CALH4WdbEZL9f=ikyEezZwUwpgKaFPaf=YqbCXzNe97dt0J643w@domain.hid>
In-Reply-To: <CALH4WdbEZL9f=ikyEezZwUwpgKaFPaf=YqbCXzNe97dt0J643w@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai: binding failed: Operation not permitted.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Frederik Bayart <frederik.bayart@domain.hid>
Cc: xenomai@xenomai.org

On 04/25/2012 04:00 PM, Frederik Bayart wrote:
> Migration to squeeze is the next step planned.
> In attachment a small test program to reproduce the problem and a makefile.
> The program is running as root but we want e.g. the command executed
> by the popen command running as user 'triphase'
> 
> if you run the program and press CTRL-C, you get Xenomai: binding
> failed on 2.6.0 and output (of part of the output) from 'ls' on
> 2.4.10.

I am afraid you will have to add the triphase user to the xenomai group
and pass the xeno_nucleus.xenomai_gid option to the kernel. Or else
rewrite the vfork + exec yourself dropping root privileges after the fork.

The reason is that the native api assumes that if you fork in a xenomai
program, chances are you will want to use the native api in the child
program.
-- 
					    Gilles.

