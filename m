Message-ID: <4F9D64C1.8070505@domain.hid>
Date: Sun, 29 Apr 2012 17:56:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CALH4WdZ3zVeXeapCjUc_usPb4AreGjecPXaLjL_SWZzJ_mo0eQ@mail.gmail.com>
In-Reply-To: <CALH4WdZ3zVeXeapCjUc_usPb4AreGjecPXaLjL_SWZzJ_mo0eQ@mail.gmail.com>
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
To: xenomai@xenomai.org

On 04/25/2012 12:28 PM, Frederik Bayart wrote:
> Hallo,
> 
> We are switching from linux 2.6.30.8 with xenomai 2.4.10  to linux 2.6.38.8
> with xenomai 2.6.0 (stable release) on debian lenny.

If you are concerned with security (which seems to be the case since you
want to avoid running real-time programs as root):
- you should note that debian lenny is no longer maintained for security
update (since february actually), so, an upgrade to squeeze is
recommended. Chances are that it is possible to become root when running
as an ordinary user on a lenny system without too much trouble.
- it is entirely possible that it is possible to become root abusing
xenomai interfaces, xenomai interfaces are not implemented with security
in mind.

> 
> In our daemon (with real pid root), we are setting effective pid and gid to
> 1000 and are calling popen to execute a shell command.
> The popen succeeds, but when I try to read the output with fgets, I get the
> error :
> 
> Xenomai: binding failed: Operation not permitted.
> 
> I verified that the effective user for both commands is the same.
> 
> This was working on xenomai 2.4.10
> I added the user with pid 1000 already to the xenomai group but this
> doesn't work.

That is not enough, you should also do what is said here:
http://www.xenomai.org/index.php/Non-root_RT

-- 
                                                                Gilles.

