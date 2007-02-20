Message-ID: <cbe23c50702200511t7fd6bfd6nbf131df680fcd80a@domain.hid>
Date: Tue, 20 Feb 2007 14:11:21 +0100
From: "Eric Noulard" <eric.noulard@domain.hid>
Subject: Re: [Xenomai-help] patching continues
In-Reply-To: <45DACA75.8030001@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45D9F759.7020006@domain.hid>
	<cbe23c50702192323h370cd65fg3490d82fea34cd33@domain.hid>
	<45DACA75.8030001@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Xenomai-help@domain.hid

2007/2/20, Wolfgang Grandegger <wg@domain.hid>:
> Eric Noulard wrote:

> >
> > Note that you still to update your lilo.conf / grub.conf file for
> > adding your freshly
> > compiled kernel.
>
> On my FC5 distro I simply do:
>
>    $ make bzImage
>    $ make modules
>    # make modules_install
>    # make install
>
> Then I reboot and select the new entry in the grub boot loader. I guess
> this works for other distros as well.

You are right

make install step usually calls a script
as shown by "make help" you may call in a configured linux kernel [build] tree
>>>
  install       - Install kernel using
                   (your) ~/bin/installkernel or
                   (distribution) /sbin/installkernel or
                   install to $(INSTALL_PATH) and run lilo
>>>



-- 
Erk

