From: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <CAD0gx3h3p4X73Q+2f_39hB4SHzOVO0f0JkaUy7bh+bp4ROPB_g@mail.gmail.com>
References: <CAD0gx3gM7TwoPn-0367BH848nYow02uN3dK5wOcysXFMxmBCSw@mail.gmail.com>
	<CAFNBftfNPqty915_2hgMX+3W3S2UVt1sQgwnFsOufMVXFV3TFA@mail.gmail.com>
	<20121022185804.438E22005BB@gemini.denx.de>
	<CAD0gx3h3p4X73Q+2f_39hB4SHzOVO0f0JkaUy7bh+bp4ROPB_g@mail.gmail.com>
Date: Mon, 22 Oct 2012 23:59:00 +0200
Message-Id: <20121022215900.E754A2005BD@gemini.denx.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Best ARM-based Linux Distribution for Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bill Smith <shoozboot@gmail.com>
Cc: xenomai@xenomai.org

Dear Bill,

In message <CAD0gx3h3p4X73Q+2f_39hB4SHzOVO0f0JkaUy7bh+bp4ROPB_g@mail.gmai=
l.com> you wrote:
>
> I see the BeagleBoard-XM listed as a target, but no specific mention of=
 the
> BeagleBone.  Any idea if this next release will have specific support f=
or
> the BeagleBone?

Unlike Yocto, ELDK is _not_ focussed on specific boards, but on CPU
architectures.  Of course, any board support present in a Yocto
release is also available in the ELDK release based on that.

> Which 2.6 kernel release will this be based on?

None.  2.6 is obsolete.  Welcome to the world of 3.x kernels...

ELDK v5.3 will use likely be based on Linux v3.6.3 for regular
images, and v3.2.21 fir Xenomai support.

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
This was an  amazing  creation  using  small  squares  of  compressed
vegetable  matter on which letters were made by means of small carbon
particles from a stylus, giving an effect similar to the  traditional
word-processor  screen. It seemed amazingly portable and I never once
saw him have to change the batteries.
        - Terry Pratchett & Stephen Briggs, _The Discworld Companion_

