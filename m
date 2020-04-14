MIME-Version: 1.0
References: <20200407154117.5D7D71C2@centrum.cz>
 <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>
 <20200407171816.E0B3979D@centrum.cz>
 <CAFLxGvx2EhOgUnB1VkW+7TendLUcsZ0XGGcwYhiPw7PcxwFkTw@mail.gmail.com>
 <20200408114406.6119E0D9@centrum.cz>
 <CAFLxGvx9-awne2He+ULqOzwf0cGae1s_k+-b8tdiM+uT67+cYg@mail.gmail.com>
 <20200409170009.5B0DAA77@centrum.cz>
 <CAFLxGvy8SP+4mr3PYYRHuxww=22w28RjaDPUgDSVFVHx-_cQ_g@mail.gmail.com>
 <20200409201057.74CB5ED0@centrum.cz>
 <CAFLxGvxuZw57FvaAQEAxseamoPhHdKX7wfZoaZxKskgeXa4V9g@mail.gmail.com>
 <20200414101600.F9AA555D@centrum.cz>
In-Reply-To: <20200414101600.F9AA555D@centrum.cz>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 14 Apr 2020 10:30:17 +0200
Message-ID: <CAFLxGvz7ewnVv57QiEfCG76tjGcJ5v9KSg0QNHwtMa0Hihp_dQ@mail.gmail.com>
Subject: Re: rt_task_unblock() POSIX alternative
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Petr_=C4=8Cervenka?= <grugh@centrum.cz>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Tue, Apr 14, 2020 at 10:16 AM Petr =C4=8Cervenka <grugh@centrum.cz> wrot=
e:
>
> Hello Richard.
> Sorry for late answer because of the Easter.
>
>  > I gave your program a try.
> > With this changes it works (at least how I understand your test case).
>  >
> > Task started
> > Set period: 5s
> > Task livind: 9.9e-05s
> > Waiting for join
> > Signal handler: 41
> > Signal handler end
> > Task livind: 0.999s
> > Task ended
>  >
> > ...
>
> There has to be something with my version of Xenomai, IPIPE or configurat=
ion. Not even your example is working for me. Morover in your example outpu=
t is clearly visible, that the first waiting is interrupted 9.9e-05s after =
first attempt to wait by some unknown signal. Such thing has never happened=
 to me in POSIX, only in Alchemy.

I fear there seems to be a confusion between POSIX tasks and POSIX skin.
Is your goal programming Xenomai realtime threads using POSIX alike APIs?
Or are you looking for a pedant of rt_task_unblock() to unblock a
POSIX task, without Xenomai realtime threads?

The solution I provided is for the latter case.

--=20
Thanks,
//richard

