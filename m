MIME-Version: 1.0
In-Reply-To: <4B992463.8050202@domain.hid>
References: <4B992463.8050202@domain.hid>
From: Simon Boulay <simon.boulay@domain.hid>
Date: Thu, 11 Mar 2010 18:43:58 +0100
Message-ID: <8809f7c51003110943m286addf8ud0d7714485d35ec3@domain.hid>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai-core] Analogy a4l_fill_desc() bug
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

On Thu, Mar 11, 2010 at 6:12 PM, Daniele Nicolodi <daniele@domain.hid> wrote:
> Hello.
Hello.

> I found a bug in a4l_fill_desc(). If I call it on a descriptor obtained
> for an unattached device, the memory allocated for the sbdata descriptor
> field is corrupted in a bad way. When, after the failing a4l_fill_desc()
> call, I free() it, glibc complains about an "invalid next size" for the
> memory chunk.

> I'm on x86 architecture using kernel 2.6.30.10 with xenomai 2.5.1.
I can't talk for Alex (the analogy developer) and I'm pretty sure he
will help you by the end of the week...
This bug reminds me an old one which have been fixed. I think that you
should work with the analogy branch of Alex (abe) repository here:
http://git.xenomai.org/?p=xenomai-abe.git;a=shortlog;h=refs/heads/analogy
There is a lot of fixes there; especially for NI driver.


Simon.

>
> Thanks. Cheers,
> --
> Daniele
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>

