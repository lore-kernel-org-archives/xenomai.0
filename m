Message-ID: <bc4264770705130013r379b9324qc6c7fc7d201f31f8@domain.hid>
Date: Sun, 13 May 2007 07:13:33 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] xenomai/rtnet/EML
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Hi,

I want to install EML  over xenomai/rtnet but the only version of EML
I can find on the web seems to be the eCos version. There seem to be
on instructions in it as to how to install on xenomai.  Although the
berilios site talks about a version that should be xenomai ported I
cannot find where to download it.

For ecos it seems to be a patch but I understand that in the xenmai
context it is simply a library that can be compiled and linked in to
the project?

There seems to be a dedicated mailing list for EML but I am still
figuring out how to get on to it.......

Kind regards,

Roland










>
> > [being in a hurry]
> > Check the links on www.rtnet.org to the related project at FMTC. They
> > even have mailing lists for detail questions.
> >
> > The setup will be: Xenomai (basis) + RTnet (RT-NIC driver, core network
> > stack) + EML (userspace lib with Ethercat master code) + Your App
> > (linked against Xenomai and EML).
>
> <http://www.mail-archive.com/rtnet-users@domain.hid>
>
> Klaas
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

