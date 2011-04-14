Message-ID: <4DA6A36D.6070908@domain.hid>
Date: Thu, 14 Apr 2011 09:34:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <DFFBF4EB468A894AB1474ED220F05AF60134C17D@srv-dc.ona-electroerosion.com>
In-Reply-To: <DFFBF4EB468A894AB1474ED220F05AF60134C17D@srv-dc.ona-electroerosion.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] FW: rtdm_iomap_to_user() I-pipe error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Asier Tamayo <asier.tamayo@domain.hid>
Cc: xenomai@xenomai.org

On 2011-04-14 08:14, Asier Tamayo wrote:
> 
> Hello,
> 
> I'm porting a PCI driver to a RTDM. Until now, I have successfully done most of the job.
> 
> I'm using Xenomai version 2.4.7 and Linux 2.6.27, from the ELinOS 5.0 distribution.
> 
> My problem appears with the rtdm_iomap_to_user() function. I want to allow a RT task to access the PCI memory directly, via mmap. As the RTDM has no mmap() function, I'm trying to use rtdm_iomap_to_user, but it always gives me the following error:
> 
> 	I-pipe: Detected illicit call from domain 'Xenomai'
> 	        into a service reserved for domain 'Linux' and below.

This is also documented: rtdm_iomap_to_user is not supposed to be called
from RT task context. This means your driver should only call it from
handlers registered for *_nrt entry points.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

