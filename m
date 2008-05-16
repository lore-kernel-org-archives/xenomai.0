Message-ID: <2ff1a98a0805160245k32bc1174q5bd53d5f8dd4c4a8@domain.hid>
Date: Fri, 16 May 2008 11:45:12 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1165644528@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1165644528@domain.hid>
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

On Fri, May 16, 2008 at 11:34 AM,  <Paradoxxa2001@domain.hid> wrote:
> Sure,
> the Output of "readelf --sections vmlinux" is:

vmlinux is large because of debug infos, your .text section is 3MB
large, which looks normal. Follow the various steps in making the
zImage to find what is wrong.

-- 
 Gilles

