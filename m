Message-ID: <2ff1a98a0805160144r5a8ce911p875b456c74f0520c@domain.hid>
Date: Fri, 16 May 2008 10:44:40 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1165546489@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1165546489@domain.hid>
Subject: Re: [Xenomai-help] at91sam9263 and user-space support compile fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paradoxxa2001@domain.hid
Cc: xenomai@xenomai.org

On Fri, May 16, 2008 at 10:15 AM,  <Paradoxxa2001@domain.hid> wrote:
> Hi,
>
> actual i working with the CodeSourcery 2008q1 toolchain. When im building the
> user-space support it seem to work fine. Then im also compiled the kernel with this
> toolchain. The Image file which i get is about 4,7MB big. My System provide just
> less then 4MB space for the Kernel Image. With my first compiler i got kernel images
> with the size of 1,6MB. I also checked the Optimization Level, but that isn't the cause.
> What do you think about that?

This is a known issue. Use a more recent kernel, or patch the arch
Makefile as indicated here:
http://lists.arm.linux.org.uk/lurker/message/20080508.101225.d54f8f71.en.html

-- 
 Gilles

