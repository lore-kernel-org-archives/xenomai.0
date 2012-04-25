Message-ID: <4F97D550.7080800@domain.hid>
Date: Wed, 25 Apr 2012 12:43:28 +0200
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
To: Frederik Bayart <frederik.bayart@domain.hid>
Cc: xenomai@xenomai.org

On 04/25/2012 12:28 PM, Frederik Bayart wrote:
> Hallo,
> 
> We are switching from linux 2.6.30.8 with xenomai 2.4.10  to linux 2.6.38.8
> with xenomai 2.6.0 (stable release) on debian lenny.
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
> 
> Does anyone know what the problem could be ?

Quite frankly, the description is a bit vague. For instance, the
"binding failed: operation not permitted" message should happens as a
result of starting a program, or as a result of popen, not when calling
fgets. Anyway, please try and reduce the bug to a simple and minimal
test case which still causes the bug, and post the code here. A piece of
code is worth a thousand words, and this exercise may help you identify
which piece of the puzzle causes the bug.

-- 
                                                                Gilles.

