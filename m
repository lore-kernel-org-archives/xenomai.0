MIME-Version: 1.0
References: <CA+WNq=WXhcDcibmNQeO1WCkOmHVKFB32Fu5DVWWKPTyq2EtFzw@mail.gmail.com>
 <20190301133206.0b723b80@md1za8fc.ad001.siemens.net>
In-Reply-To: <20190301133206.0b723b80@md1za8fc.ad001.siemens.net>
From: Sumitabh Ghosh <sumitabhg12@gmail.com>
Date: Sat, 2 Mar 2019 11:27:04 +0530
Message-ID: <CA+WNq=Vo0p6CAWp_V5JzWK47JGJZVDvj0j1Os8AdF9FStvBncw@mail.gmail.com>
Subject: Re: Qt application on Xenomai
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: henning.schild@siemens.com
Cc: Sumitabh Ghosh via Xenomai <xenomai@xenomai.org>

Hi Henning,

Thanks for your confirmation. Just to understand your set up further, does
the POSIX layer used by QT is of the Xenomai skin ? Is This the way Qt is
leveraging the rt features ?

I guess the rendering of graphics is handled through non rt Linux
framebuffer /opengl apis.

Let me know if my above understanding is correct.

Thanks,
Sumit




On Fri, Mar 1, 2019, 18:02 Henning Schild <henning.schild@siemens.com>
wrote:

> Hi,
>
> i am not sure i fully understand the question. In case you are worried
> about combining Xenomai and Qt, i can assure you that it is possible.
> We do have big c++/Qt applications running both rt and non-rt on
> xenomai.
>
> regards,
> Henning
>
> Am Fri, 1 Mar 2019 14:10:42 +0530
> schrieb Sumitabh Ghosh via Xenomai <xenomai@xenomai.org>:
>
> > Hi,
> >
> > I have a generic question not specific to any platform. If I want to
> > run a small graphics application on Xenomai 3.x what would be the
> > correct approach. e.g. Qt application framework which needs POSIX
> > apis and a linux frame buffer to be able to render 2D applications.
> >
> > Kindly provide me some pointers.
> >
> > Thanks in advance.
> >
> > Cheers!
> > Sumit
>
>
