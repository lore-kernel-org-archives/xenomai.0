Date: Wed, 9 Sep 2015 14:53:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150909125349.GB24499@hermes.click-hack.org>
References: <55EFD7C1.50606@free.fr>
 <20150909072117.GA20075@hermes.click-hack.org> <55EFE37F.1@free.fr>
 <20150909074838.GA21017@hermes.click-hack.org>
 <55EFF3EE.9030707@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <55EFF3EE.9030707@free.fr>
Subject: Re: [Xenomai] i210 porting
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?iso-8859-1?Q?St=E9phane?= ANCELOT <sancelot@free.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Sep 09, 2015 at 10:55:10AM +0200, St=E9phane ANCELOT wrote:
> On 09/09/2015 09:48, Gilles Chanteperdrix wrote:
> >On Wed, Sep 09, 2015 at 09:45:03AM +0200, St=E9phane ANCELOT wrote:
> >>On 09/09/2015 09:21, Gilles Chanteperdrix wrote:
> >>>On Wed, Sep 09, 2015 at 08:54:57AM +0200, St=E9phane ANCELOT wrote:
> >>>>Hi,
> >>>>
> >>>>People interested in porting and testing i210 rtnet driver, contact me
> >>>>please.
> >>>I have a working RTnet for i210. But that is the old version, for
> >>>Xenomai 2.x. I intend to merge this work with Xenomai 3.
> >>>
> >>>Regards.
> >>>
> >>I am on the way merging i210 copper dependencies from kernel 3.16.7 , I=
 may
> >>setup a github for people wanting to work with it, before sending a pat=
ch.
> >I have used a more recent kernel, 3.16 is EOL, so, I do not think I
> >will take your patch. However, I can do an untested port to Xenomai
> >3 and let you test the port if you are interested.
> >
> >Regards.
> >
> I agree, but unfortunately, at the moment I have to stick on 3.16 since my
> debian jessie is based on it....

Since you are compiling your own kernel to patch it with Xenomai
anyway, you have no reason whatsoever to stick to the EOL version
chosen by Debian.

--=20
					    Gilles.
https://click-hack.org

