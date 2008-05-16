Message-ID: <2ff1a98a0805160227n4748e1adi7cff5497cfe8a9e0@domain.hid>
Date: Fri, 16 May 2008 11:27:37 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1165631693@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1165631693@domain.hid>
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

On Fri, May 16, 2008 at 11:24 AM,  <Paradoxxa2001@domain.hid> wrote:
>
> -rwxr-xr-x 1 paradoxxa paradoxxa 35M 16. Mai 11:20 vmlinux

You have a problem, my vmlinux is 4MB large. Could you run
readelf --sections vmlinux
?

-- 
 Gilles

