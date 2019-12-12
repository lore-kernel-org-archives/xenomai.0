Date: Thu, 12 Dec 2019 14:18:51 +0000
From: Jeff Webb <jeff.webb@protonmail.com>
Reply-To: Jeff Webb <jeff.webb@protonmail.com>
Subject: Re: [ANNOUNCE] Xenomai 3.0.10 released
Message-ID: <E4eOs70N4955OVheXsuW2lT5cFP9jpl73y4_EmdIZsP-8vXczsgtYjpe1bKZLQdy3fIfhTvxYAbzwlyuKvzg9eXa33sSMN_jER3zDdxrE88=@protonmail.com>
In-Reply-To: <19bbd92b-9d19-eff5-8b66-30e7825b9220@siemens.com>
References: <8wpv79_me5liHbd4OzRAJqQ8h4itwxhL_-mICsJBiz8eH85PjroDi8SB8aBHhfZTyNugCjhXRkO-IwZ3OCnOdUEGfFMtQNqbZNjGSbWGdpQ=@protonmail.com>
 <19bbd92b-9d19-eff5-8b66-30e7825b9220@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, December 10, 2019 10:29 AM, Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:

> On 10.12.19 17:23, Jeff Webb via Xenomai wrote:
>
> > I had an issue when trying to configure a kernel patched using 3.0.10. =
My process was similar to the process I used when testing other releases. H=
ere is what I did:
> > Download xenomai-v3.0.10.tar.bz2 from "Download" button here:
> > https://gitlab.denx.de/Xenomai/xenomai/-/tags
> > tar -xvf xenomai-v3.0.10.tar.bz2
> > cd xenomai-v3.0.10/
> > DEBEMAIL=3D"your@email" DEBFULLNAME=3D"Your Name" debchange -v 3.0.10 R=
elease 3.0.10
> > debuild -uc -us
> > cd ..
> > sudo dpkg -i libxenomai-dev_3.0.10_amd64.deb \
> > xenomai-kernel-source_3.0.10_all.deb \
> > libxenomai1_3.0.10_amd64.deb \
> > xenomai-runtime_3.0.10_amd64.deb
> > tar -xvf linux-4.19.84.tar.xz
>
> I should have left the note from the 3.0.9 release in this one:
> con
> "Note again that the 3.0.x series works up to kernel 4.14. For 4.19
> support, please switch to master, the source of upcoming 3.1."
>
> Well, there are RCs for 3.1 by now :)

Sorry, I knew this, but forgot about it.  The error message wasn't enough t=
o help me make the connection.

In any case, things seem to work fine with 4.4.199-cip39/3.0.10.  We will s=
tick with 4.19.84/3.1-rc4 for further testing, though.

Thanks,

-Jeff


