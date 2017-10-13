MIME-Version: 1.0
In-Reply-To: <20171013113118.6e6f0fcd@md1em3qc>
References: <CADYdroNR6zjbKrPKPm3d_7+55Rg2SDbmpxiNR-xu78QNHSrr9g@mail.gmail.com>
 <20170810114956.04f62bc6@md1em3qc>
 <CADYdroM8E7jhuyRoW4JkSzZfGg27VvpjLmHGmMmX79wgEqPJog@mail.gmail.com>
 <20171012103345.04d854c2@md1em3qc>
 <CADYdroOAVb0wPAvuynvuOUtSnp85FT2Ett80amzDpDCFHPHHzA@mail.gmail.com>
 <CADYdroNeQOY2MN-b=r6bNh=69oeGP2oWry2CXHYH9RJtTt1MFA@mail.gmail.com>
 <CADYdroN-yNG+nLrhfiH8MgMVr7D82-wNnjvyVXcX6hNU2mikcg@mail.gmail.com>
 <20171013113118.6e6f0fcd@md1em3qc>
From: Norbert Lange <nolange79@gmail.com>
Date: Fri, 13 Oct 2017 11:37:30 +0200
Message-ID: <CADYdroPP8ZQ91eqfJjJP9UFufpJOWm7+zsDePz-0a_TaDV_9_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Won`t build on new Debian Stable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: norbert.lange@andritz.com, Xenomai <xenomai@xenomai.org>

Actually your idea of just adding -r would work aswell, and looks
cleaner and more robust to me.

I started with the wrong ideas because of the usual POSIX argument
parsing like "tar -xzf file.tar.gz" being interpreted as  "tar -x -z
-f file.tar.gz".

2017-10-13 11:31 GMT+02:00 Henning Schild <henning.schild@siemens.com>:
> That looks good to me.
>
> Henning
>
> Am Fri, 13 Oct 2017 10:38:26 +0200
> schrieb Norbert Lange <nolange79@gmail.com>:
>
>> Second attempt at fixing it, you could surely make this more complex
>> using autohell but I am not going there.
>>
>> If I understood correctly this script is only necessary if the
>> application is linked -static?
>> Means I would try to avoid using it, aslong I dont explicitly want to
>> do that.
>>
>> Kind regards,
>> Norbert
>>
>> 2017-10-13 9:40 GMT+02:00 Norbert Lange <nolange79@gmail.com>:
>> > Ok I just realized there is a "-Ur" option, aside from "-U -r".
>> >
>> > You get alot otherwise undocumented flags with "gcc --help -v" BTW
>> >
>> > 2017-10-13 9:13 GMT+02:00 Norbert Lange <nolange79@gmail.com>:
>> >> Hello,
>> >>
>> >> I tracked down the source of information to this:
>> >> https://wiki.ubuntu.com/SecurityTeam/PIE
>> >>
>> >> I changed the flags from "-Wl,-Ur" to "-Wl,-U -r", so you wont get
>> >> an explanation from me, why -U has to be passed for the linker.
>> >> And by the way, gcc accepts -U aswell, so this might be preferable
>> >> to be used directly too.
>> >>
>> >> I don`t know why those flags aren' t documented, bug in gcc
>> >> documentation? As far as I understand is that gcc is smart enough
>> >> to correctly deal with the flags gcc directly received, but the
>> >> linker lacks that information.
>> >>
>> >> I don' t know what the issue is with the C++ Constructors, in the
>> >> context of this change?
>> >> (I heard about the issues if those reside in a shared library, use
>> >> function from libcobald and don't depend on libcobald. Which is
>> >> more of a broken build to me if you don't add the depended libs,
>> >> and will bite you the same way if you use GCCs constructor
>> >> attribute)
>> >>
>> >> Kind regards,
>> >> Norbert.
>> >>
>> >> 2017-10-12 10:33 GMT+02:00 Henning Schild
>> >> <henning.schild@siemens.com>:
>> >>> Hey Norbert,
>> >>>
>> >>> thanks for looking into that again! Could you please explain how
>> >>> and why that works, or point out what to look at in flint?
>> >>> Mailing list thread, commit, something like that.
>> >>>
>> >>> As far as i can see gcc now gets a "-r" which i do not find in the
>> >>> manpage. And ld gets a "-U" which i do not find in its manpage.
>> >>> And there is something about c++ constructors which might change
>> >>> the behaviour of xenomai.
>> >>>
>> >>> Henning
>> >>>
>> >>> Am Tue, 10 Oct 2017 16:38:50 +0200
>> >>> schrieb Norbert Lange <nolange79@gmail.com>:
>> >>>
>> >>>> Some highly trivial fix attached!
>> >>>> Its strange that this flag is not documented in the manual (I
>> >>>> found out abaout this fix from
>> >>>> https://launchpad.net/ubuntu/+source/flint)
>> >>>>
>> >>>> Norbert Lange
>> >>>>
>> >>>> 2017-08-10 11:49 GMT+02:00 Henning Schild
>> >>>> <henning.schild@siemens.com>:
>> >>>> > Hi Norbert,
>> >>>> >
>> >>>> > Thanks! In fact that issue has come up before and a similar
>> >>>> > workaround was described. It should be fixed, patches welcome!
>> >>>> >
>> >>>> > Henning
>> >>>> >
>> >>>> > Am Wed, 9 Aug 2017 16:21:02 +0200
>> >>>> > schrieb Norbert Lange <nolange79@gmail.com>:
>> >>>> >
>> >>>> >> Hello,
>> >>>> >>
>> >>>> >> Building the xenomai package won`t work because debian now
>> >>>> >> defaults to using pie, and the linker will complain with "ld:
>> >>>> >> -r and -pie may not be used together"
>> >>>> >>
>> >>>> >> A workaround for now is to add the flags manually:
>> >>>> >> ../xenomai-3.0.5/configure LDFLAGS=-no-pie CFLAGS="-fno-PIE
>> >>>> >> -fno-pie -no-pie"
>> >>>> >>
>> >>>> >> A real fix would be similar to
>> >>>> >> http://lists.gnu.org/archive/html/bug-grub/2016-11/msg00011.html
>> >>>> >> (no-pie is not supported on old and other compilers)
>> >>>> >>
>> >>>> >> Kind regards,
>> >>>> >> Norbert
>> >>>> >>
>> >>>> >> _______________________________________________
>> >>>> >> Xenomai mailing list
>> >>>> >> Xenomai@xenomai.org
>> >>>> >> https://xenomai.org/mailman/listinfo/xenomai
>> >>>> >
>> >>>
>

