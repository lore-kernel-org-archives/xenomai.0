From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Mon, 29 Oct 2007 23:55:56 +0100
References: <200709201549.13035.lepalom@domain.hid>
	<200709242233.27203.berlemont.hauw@domain.hid>
	<200710291858.33645.lepalom@domain.hid>
In-Reply-To: <200710291858.33645.lepalom@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710292355.56188.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] Comedi driver for use with xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

>
> some time ago we wrote about the avalaible of the jr3_pci driver. The
> option to have someone at the end of October. So, how is it?

A pre-version is available in the svn branch "comedi-rtdm-dev". You will find 
in "comedi_drivers/misc_drivers", the driver jr3_pci.

The source code was ported from the original Comedi project (as the API has 
changed). Unfortunately, It is not tested (no hardware available). 

> It could be possible to have it for xenomai-2.4?

So far, the only way to get the driver sources  is through subversion. A great 
amount of work (development, test,...) must be achieved before considering an 
official release.

Regards.

Alexis.


