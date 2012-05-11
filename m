Message-ID: <4FAD2E6F.1070501@domain.hid>
Date: Fri, 11 May 2012 17:21:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CALH4WdZ3zVeXeapCjUc_usPb4AreGjecPXaLjL_SWZzJ_mo0eQ@mail.gmail.com>	<4F9D64C1.8070505@domain.hid>	<CALH4WdaTXPmzXnUHiU1jfhKUCiBhyG+X1oA6XSK5fHXds_gLTA@mail.gmail.com>
	<CALH4WdatY-9r65xU600yf4v0J3cbYqtCeZnP7jvvG0fKvrweYw@domain.hid>
In-Reply-To: <CALH4WdatY-9r65xU600yf4v0J3cbYqtCeZnP7jvvG0fKvrweYw@domain.hid>
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

On 05/11/2012 05:02 PM, Frederik Bayart wrote:
> now with mailing list in cc
> 
> Hallo Gilles,
> 
>  by adding my user to group xenomai and configuring the
>  xeno_nucleus.xenomai_gid parameter on the command line, I was able to
>  run my binary as non-root, so my problem is solved.
> 
>  However, I noticed that if I start my binary as root, and using
>  seteuid and setegid to non-root as in de example still fails. I don't
>  know whether this is normal or a bug.

It is normal. For your case to run, the fork itself must be run a root.
So, you should call again seteuid/setegid before vfork, then drop again
the rights before exec (if you do not want the exec to be run as root).

-- 
					    Gilles.

