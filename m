Message-ID: <20081128182944.qp8yhwpk6cw8cwss@domain.hid>
Date: Fri, 28 Nov 2008 18:29:44 +0200
From: Mehmet Alphan Ulusoy <alphan@domain.hid>
References: <20081127175234.163sujmgcgcgs4gk@domain.hid>
	<492EF786.4040303@domain.hid>
	<20081128181906.mnv2mvjgo44wgoc0@domain.hid>
	<49301B0B.9010208@domain.hid>
In-Reply-To: <49301B0B.9010208@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Zombie user tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

ps aux says Task's state is "Zl+" and it's there for over 6 hours now, =20
is init's mentioned behavior standard or somewhat optional?

If it's standard, then does this mean that there's something else going on?

On Fri 28 Nov 2008 18:23:39 EET, Gilles Chanteperdrix wrote:

> Mehmet Alphan Ulusoy wrote:
>> Thanks for the prompt and informative reply. After reading about
>> signals and processes I have to admit that I didn't have a clear idea
>> on the concept when I was posting my initial question. Nevertheless
>> I've modified the code of the user space task as follows:
>>
>> - signal handler sets flag when it's called.
>>
>> - At the end of the initialization routine (main()):
>>
>> ...
>> while(!termFlag)
>>      pause();
>>
>> clean();
>>
>> return;
>>
>> }
>>
>>
>> ensures that clean() is called only if SIGTERM is received and
>> termFlag is raised by the signal handler. (termFlag is an int).
>>
>> Is this safe?
>
> Yes, this should be Ok.
>
>>
>> By the way, in my trials I've found out that ppid of the zombie task
>> is 1 (init). So does this mean that the parent of the task did not
>> call wait() properly and init is the new parent of the task? Even so,
>> shouldn't it be cleaned automatically by init?
>
> It means that the zombie task's parent died before the zombie, so the
> zombie got re-parented to init. it will be cleaned automatically by init
> after some time.
>
> --
>                                                  Gilles.
>
>



