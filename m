From: Roberto Bucher <roberto.bucher@domain.hid>
Date: Thu, 11 Dec 2008 09:47:49 +0100
References: <200812090832.43063.roberto.bucher@domain.hid>
	<842971F5-4763-4765-835F-2E72AF407455@domain.hid>
	<4940CFB7.5060701@domain.hid>
In-Reply-To: <4940CFB7.5060701@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812110947.49774.roberto.bucher@domain.hid>
Subject: Re: [Adeos-main] Problems with last adeos patches
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Ok! I'll try the following steps:

a) login from a network terminal with my system in graphical mode
b) login from a network terminal with my system in non graphical mode
c) modify the X11.org file to have for example vesa driver

Some additional info:

- kernel 2.6.25.X seems to be ok (it doesn't have the same problem with 
scilab)
- kernel 2.6.27.8 with patch seems to be ok on a UP machine with Intel 
graphics card

Best regards

Roberto

On Thursday 11 December 2008 09:30:47 Jan Kiszka wrote:
> Parashkev Penev wrote:
> > Hi,
> >
> > I also have this issue. I am using the 2.6.26 kernel + adeos. The
> > .config file is the default from the CentOS 5.2/Redhat 5.2 with ACPI,
> > CPU frequency scaling, and APM turned off. The video card is an Nvidia,
> > using the nv module on one of the machines. the other one has an ATI
> > using the ati-glfrx. I haven't tried with vesa yet.
>
> Cross-checking with an open source driver would be good, though seeing
> the issue with two likely quite different binary blobs suggest that they
> are likely not to blame here.
>
> > Let me know if you ned something else. (Those are laptops, thus no
> > serial console).
>
> netconsole? Also here: Getting hold of an oops is very important,
> specifically if the problem turns out to be not easily reproducible for us.
>
> Jan
>
> PS: Please keep the list in CC.

-- 
University of Applied Sciences of Southern Switzerland
Dept. Innovative Technologies
CH-6928 Lugano-Manno
http://web.dti.supsi.ch/~bucher

