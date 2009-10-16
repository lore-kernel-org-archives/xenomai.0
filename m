MIME-Version: 1.0
Sender: alexis.berlemont@domain.hid
In-Reply-To: <96eea0c80910161016j1a1c1b8et4b2783b8cd5fa712@domain.hid>
References: <96eea0c80910151813v635d518dr6abd72986e2f07bd@domain.hid>
	<72cf3fb0910160345i494f81dr2c2d7ca4a1f5e66@domain.hid>
	<96eea0c80910161016j1a1c1b8et4b2783b8cd5fa712@domain.hid>
Date: Fri, 16 Oct 2009 23:06:57 +0200
Message-ID: <72cf3fb0910161406g313db0ffm61c6bd09a65e025c@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] national instruments card and comedi-rtdm-dev
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

Hi,

On Fri, Oct 16, 2009 at 7:16 PM, Peter Pastor <peter.pastor@domain.hid> wrot=
e:
> Hey Alexis,
>
> Thanks a lot for your quick response.
>
>>> Is rt_comedi_test an application you developed ?
> Yes, it is my little test application, which is kept simple (open, read,
> close).
>
>>> I think you should follow the common comedi way:
>>> 1) Check you have the suitable driver loaded:
> xenomai:/proc/xenomai/rtdm> cat /proc/comedi/drivers
> --=A0 Comedi drivers --
>
> | idx | driver name
> |=A0 00 | ni_pcimio
>
>>> 2) Check the comedi RTDM devices available:
> xenomai:/proc/xenomai/rtdm> cat /proc/xenomai/rtdm/named_devices
> Hash=A0=A0=A0 Name=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Driver=A0=A0=A0=
 =A0=A0=A0 /proc
> A1=A0=A0=A0 comedi0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi0
> A2=A0=A0=A0 comedi1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi1
> A3=A0=A0=A0 comedi2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi2
> A4=A0=A0=A0 comedi3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi3
> A5=A0=A0=A0 comedi4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi4
> A6=A0=A0=A0 comedi5=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi5
> A7=A0=A0=A0 comedi6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi6
> A8=A0=A0=A0 comedi7=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi7
> A9=A0=A0=A0 comedi8=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi8
> AA=A0=A0=A0 comedi9=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi9
>
>>> 3) =A0You have to attach the driver to the rtdm device you want to use
>>> with comedi_config (a tool available in Xenomai).
>>> #comedi_config comedi0 comedi_pcimio
>>>=A0 =A0 That command will assign comedi_pcimio driver to comedi0
> root@domain.hid# ./comedi_config comedi0 comedi_pcimio
> comedi_config: comedi_snd_attach failed ret=3D-22
> root@domain.hid# ./comedi_config comedi0 ni_pcimio
> comedi_config: comedi_snd_attach failed ret=3D-5
>
>>> 4) Eventually, you can test the acquistion is working with some test to=
ol
>>> of ours :cmd_read
>>> # /usr/local/bin/cmd_read -v
> I don't find this test tool. How do I install it ?
>
>
>>> SVN is not our version control system anymore. You should use our git
>>> repository.
>>> If you want the last fix I made, take my comedi branch.
>>> Have a look at:
>>> http://git.xenomai.org/?p=3Dxenomai-abe.git;a=3Dshortlog;h=3Drefs/heads=
/comedi
>
> I actually started to download using git, but it was unbelievable slow :(
> (11Kbit/s). Is there a difference between HEAD and ABE that does matter t=
o
> me ?

Yes take the abe repository, please. I will make a pull request soon.

Concerning the bitrate, I did not manage to reproduce your low bandwidth:
Receiving objects:   6% (3661/57181), 780.00 KiB | 94 KiB/s

> Apparently, I don't have comedi_pcimio. How do I build it and where can I
> find it ? It seems not to be in xenomai 2.5-rc3.

You are right, the driver was not available in 2.5-rc3.

I will downlaod
> xenomai-abe.git and see what I get.
>
>>> the driver name is comedi_pcimio instead of ni_pcimio. So you should ty=
pe
>>> comedi_config comedi0 comedi_pcimio.
> So, the comedi_pcimio is the driver I'll need ?

If, with the original Comedi framework, you used ni_pcimio, then
comedi_pcimio is what you need  with Comedi/RTDM.

 Is the no National
> Instrument specific driver ?? (ni_pcimio) ??

Sorry I don't understand the question. "no National Instrument" ?

The "pcimio" driver supports a host of NI PCI boards:
 * Devices: [National Instruments] PCI-MIO-16XE-50 (ni_pcimio),
 * PCI-MIO-16XE-10, PXI-6030E, PCI-MIO-16E-1, PCI-MIO-16E-4, PCI-6014,
 * PCI-6040E,PXI-6040E, PCI-6030E, PCI-6031E, PCI-6032E, PCI-6033E,
 * PCI-6071E, PCI-6023E, PCI-6024E, PCI-6025E, PXI-6025E, PCI-6034E,
 * PCI-6035E, PCI-6052E, PCI-6110, PCI-6111, PCI-6220, PCI-6221,
 * PCI-6224, PCI-6225, PCI-6229, PCI-6250, PCI-6251, PCIe-6251,
 * PCI-6254, PCI-6259, PCIe-6259, PCI-6280, PCI-6281, PXI-6281,
 * PCI-6284, PCI-6289, PCI-6711, PXI-6711, PCI-6713, PXI-6713,
 * PXI-6071E, PCI-6070E, PXI-6070E, PXI-6052E, PCI-6036E, PCI-6731,
 * PCI-6733, PXI-6733, PCI-6143, PXI-6143

Alexis.

