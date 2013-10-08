MIME-Version: 1.0
In-Reply-To: <CAKc2Hpbkaj3j1sPCWy-k6JD8ACz=85VnbqPFbfmk3sP1MsNwcA@mail.gmail.com>
References: <CAKc2Hpbkaj3j1sPCWy-k6JD8ACz=85VnbqPFbfmk3sP1MsNwcA@mail.gmail.com>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Tue, 8 Oct 2013 10:54:07 +0200
Message-ID: <CAMJ=MEcadCsTrsjfHNtW0Wr17T0CBrjtvf2j0O4L+zKtwFDi4g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Fuse version in Xenomai-forge with
	"--enabled-registry"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "K. De Mey" <kim.demey@gmail.com>
Cc: xenomai@xenomai.org

On Tue, Oct 1, 2013 at 12:13 PM, K. De Mey <kim.demey@gmail.com> wrote:

> Hello everybody,
>
> We use xenomai-forge for a project. I however came across a problem when
> adding the "--enabled-registry" option.
> It seems that the FUSE functions (for example fuse_main()) that are being
> used are the compat functions of version 2.2 (fuse_main_real_compat22()).
> I found this strange as I have FUSE_USE_VERSION defined at 26.
>
> I suspect it has something to do with the symbol versioning in FUSE.
> I believe so as when I change the version 22 ".symver" mapping in FUSE to
> use the newer compat functions then that works. (or removing all the symver
> completely works also)
> This is obviously not the way to make it work, however I don't know how to
> do it properly.
> I know this might be a FUSE issue and not necessary a Xenomai issue but I
> can't seem to get it working.
> I must say I know little to nothing of symbol versioning.
>
> As test I also created a stand alone FUSE application (no Xenomai involved)
> and then it does use the functions of the latest version.
> So to be sure, I would like to know if there is something more in Xenomai
> that sets the "compat" version of FUSE to 2.2? Am I missing something ...?
>
> By the way, the actual version of FUSE that we use is 2.9.2 and the version
> of Xenomai-forge is also quite recent.
>
> I hope my question is a clear enough, else I can of course add more
> information.
>
> Thanks!
>
> Regards,
> Kim
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>

Hello guys,

any feedback on the questions above?

Kim is working on the introduction of the full registry support for the
pSOS skin in forge.
I think this is a major step to improve the debugability of applications
using this skin.

Thanks,
Ronny
