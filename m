Message-ID: <49F961B4.60506@domain.hid>
Date: Thu, 30 Apr 2009 10:30:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <37f89760904300028q6406a795h6aeaa14de971f8b8@domain.hid>
In-Reply-To: <37f89760904300028q6406a795h6aeaa14de971f8b8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] incompatible compact flash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marcel Soulot <msoulot@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Marcel Soulot wrote:
> Hi,
> 
> My system uses a compact flash as mass memory.
> I try to use a compact flash from "silicon drive II, SSD-C04G-4000, 4GB" and
> the kernel patched with xenomai 2.4.6 doesn't want to start. I stay block in
> "kernel booting" ...
> As anyone have already encounter this kind of problem and find the reason ?
> The thing is with the same software, I succeed to launch the kernel but with
> a another CF "transcend, 4GB"

Xenomai 2.4.6 is a version which you should not use. And it is not the
latest version either. So, do you have the same issue with Xenomai 2.4.7  ?

Are you sure the EXACT SAME kernel configuration with only Xenomai and
Adeos I-pipe disabled does not have the same issue ?

-- 
                                                 Gilles.

