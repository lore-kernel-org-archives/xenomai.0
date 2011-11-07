Message-ID: <4EB7E8E8.2030201@domain.hid>
Date: Mon, 07 Nov 2011 15:19:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAAXf6LWx0TdgzmdhZMMxKFWTxzZUP3FXgigmBh-iE78SrMC0eg@domain.hid>
In-Reply-To: <CAAXf6LWx0TdgzmdhZMMxKFWTxzZUP3FXgigmBh-iE78SrMC0eg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai-forge git woes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Cc: Xenomai-help@domain.hid

On 11/07/2011 02:38 PM, Thomas De Schampheleire wrote:
> Hi,
>
> It seems something was up with the Xenomai-forge git repository. On
> the web interface, I see many old commits being recommitted today.
>
> Can you give some background information as to why this happened?
> And more importantly, not being an experienced git user, how to
> recover from it? 'git status' shows:
>
> # On branch master
> # Your branch and 'origin/master' have diverged,
> # and have 177 and 360 different commit(s) each, respectively.
>
> and a 'git pull' shows tons of conflicts on files I did not touch.
>

This is a rebase, which breaks the commit history. I have to rebase the 
-forge over the 2.6.x branch until the latter leaves the development 
phase at least. Cherry picking lots of changes manually from 2.6.x while 
it is under active development would be too error prone.

Now that 2.6.0 is out, the number of rebases should decrease 
significantly, until 2.6.1 is released, at which point they should stop.

You should force-pull your master branch, assuming you did not add any 
of your changes there, then rebase your own -forge update branch if any, 
onto the new master.

> Thanks,
> Thomas
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>


-- 
Philippe.

