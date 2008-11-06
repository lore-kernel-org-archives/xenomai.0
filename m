Message-ID: <4912B693.3080104@domain.hid>
Date: Thu, 06 Nov 2008 10:19:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1225962826.4912b54a14c23@domain.hid>
In-Reply-To: <1225962826.4912b54a14c23@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai installation issue.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: garryt <garryt@domain.hid>
Cc: xenomai@xenomai.org

garryt wrote:
> Hello,
> 
> I am facing issue with the installation of xenomai on x86_64 system. Obviously i
> should have configured something not as required, but i cannot figure what.
> This is a widespread optiplex DELL PC.(I hope someone successfully installed
> xenomai on this and might help :)
> 
> Compilation works fine, then after few minutes system hangs (for example when
> using xeno-test..).
> 
> I have search around the net, look at the TROUBLESHOOTING guide, modify kernel
> compilation options to reflect as close as possible to the hw ( Core2 Duo
> processor) and try different configuration (2.6.24 / 2.6.25 ) and IPIPE patches,
> but still have issues.
> 
> Here is attached an archive with latest traces and configuration options.

The most important thing is missing from this archive: the kernel logs.
If your processor has no serial port, please use netconsole (see
Documentation/networking/netconsole.txt in the kernel sources).

-- 
                                                 Gilles.

