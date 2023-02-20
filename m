Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84716A5E
	for <xenomai@lists.linux.dev>; Mon, 20 Feb 2023 05:27:20 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id z28so1853255ljq.9
        for <xenomai@lists.linux.dev>; Sun, 19 Feb 2023 21:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6u79aTBd8zF6viEiKf70Aj7Osm6rnRCp3FtNQHTKRYA=;
        b=O4K1iI+VSr6cj3ZlgtzYTBwmS6g538zM6FX/4MvcrRqtC92f1leatkd5y2whlvYxju
         1UBRTUDFDIOmA8F44FxaE+zLcymXuA9d8er5LUXHPSxRV9RBuOWSlYHIAg4ffYAyroyR
         bWiDP9OcnTRWyzamlYUuXX2OEPGucaU0xEl6OV2yjmj+V9TJyyCB0p65fj0IPysu+3AB
         /ADkuYCkDvQul2H1U7pR+xiHDviPGx41M6l5O4lkK7iM2arxwNNKXPkjGD+VJ0SsS/hF
         fEZ+eyZNjLmdcJ/XHBHi+TTW4fgqS45kpqMgYrf31aSvOAOMl+/xBboHhRCL/znw+kpT
         S9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6u79aTBd8zF6viEiKf70Aj7Osm6rnRCp3FtNQHTKRYA=;
        b=TpXlJTaBYedFT3oKCDIvnyDDXqaA8QGmTutYd+cS7GrgR3K2KdPtekuXt8XKXdwQYU
         GePn+hIl+UOZi2a9SwDieh+Hnz0eG/7ueMWKh1kRqL2A3IHUJTri1ilFO7nVtfVSswZC
         JhUZ3s9iKuTd5SfveNYv/+NUhskHBt4mhg201UY5hM2i8UKaDjQKRc0RL+PzFsKfyjxU
         efgiFFgpyJTrhJBsR42mfZJWTf7OrOJyg6v5E5dMID0XFUXDmcX8HDPc3uDoRNULobg0
         3jzXY/ci4ZveiCfVGNgjcZuzDUnbl43Db4ERJ2+pwyvLq2LX5sTdGx7haoZBlf/sN+zS
         OcCQ==
X-Gm-Message-State: AO0yUKWP2ZSxNvs1PULqznvMQwxKBaDkK7GclvqMdrJ+H2ORPxVK5Bxe
	kcuJ5toAbzgnioWMxH9cJ3mQ3NHNOAoPFyHNN0MIBA==
X-Google-Smtp-Source: AK7set96SLjIAqbj4sWIDUMrtg+Fxb8379rseOQY7u7OTxlWw/lIt8KkSAQbYZb0g5PZAmXa9kaSPiPBnH8V213WIuY=
X-Received: by 2002:a2e:a99b:0:b0:293:5140:7548 with SMTP id
 x27-20020a2ea99b000000b0029351407548mr397156ljq.3.1676870838361; Sun, 19 Feb
 2023 21:27:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CALLqZ8T=c_ngHcuU5vkpLVfzbN4Kpfh-Aqzq2vKErCYqbzyQWQ@mail.gmail.com>
 <252602b1508b13bc480f6c971e13b02ae7702071.camel@siemens.com> <CALLqZ8SiSB8e1VJcCv06H7Gc=zwiLf=6kBisB73yCT6VhRRRug@mail.gmail.com>
In-Reply-To: <CALLqZ8SiSB8e1VJcCv06H7Gc=zwiLf=6kBisB73yCT6VhRRRug@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 20 Feb 2023 00:27:07 -0500
Message-ID: <CALLqZ8Sk2OejX_aZRSiMqdDunY-5nG_Gr5Guf032HhS41ewD=Q@mail.gmail.com>
Subject: Re: arm/arm-64 ipipe release
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, Feb 18, 2023 at 12:33 AM Greg Gallagher <greg@embeddedgreg.com> wrote:
>
> On Tue, Feb 14, 2023 at 11:56 AM Florian Bezdeka
> <florian.bezdeka@siemens.com> wrote:
> >
> > Hi Greg!
> >
> > On Mon, 2023-02-13 at 23:01 -0500, Greg Gallagher wrote:
> > > Hi,
> > >    I'm almost ready to release the next arm and arm64 ipipe patch. I'm
> > > working on stable release 231 since it contains the patch that
> > > hopefully fixes the UART irq issue seen in CI.  If there's a problem
> > > with using 231 let me know.  Finishing my local test this week.
> >
> > Thanks for letting us know. If there is a chance that you publish a
> > public available -rc somewhere, it would be possible to tweak our CI a
> > bit and trigger a full test run in our lab.
> >
> > That should help us to identify any leftovers upfront.
> >
> > Best regards,
> > Florian
> >
> >
> > >
> > > Thanks
> > >
> > > Greg
> > >
> >
>
> I'll get -rc releases out this weekend.  I'll post back once they are
> done and the -rc tags are pushed up.
>
> Thanks
>
> Greg

Hi Florian,
   I have the rc releases ready to go.  I'm going to push them up to
the ipipe tree with the kernel update (5.4.231).  Does the CI system
pull the current ipipe release based on the tag?  Would pushing up the
new point release (5.4.231) break the current CI?

thanks

Greg
