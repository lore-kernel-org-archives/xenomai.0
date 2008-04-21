Message-ID: <2ff1a98a0804210722s39b8df2dm4f7dcbc49fcc56f8@domain.hid>
Date: Mon, 21 Apr 2008 16:22:40 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d6c8ef150804210307h5d6dc3fax3a1bb4047981b29e@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150804180733k3e2b2bc0p1255b84e16062f05@domain.hid>
	<2ff1a98a0804180748o4dc88c91of90e8e26c36d32ed@domain.hid>
	<d6c8ef150804210307h5d6dc3fax3a1bb4047981b29e@domain.hid>
Subject: Re: [Xenomai-help] Handling interrupt - jitter
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Mon, Apr 21, 2008 at 12:07 PM, Bosko Radivojevic
<bosko.radivojevic@domain.hid> wrote:
> On Fri, Apr 18, 2008 at 4:48 PM, Gilles Chanteperdrix
>  <gilles.chanteperdrix@xenomai.org> wrote:
>
>
> >  It's funny to notice how much you asked for the 2.6.24 patch for
>  >  actually not using it.
>
>  BTW, 2.6.25 is out... :)

I have just tried to apply the 2.6.24 patch to a 2.6.25 kernel there
does not seem to be much rejects, and they all seem easy to solve.
Anyway, I wait for Philippe to issue the x86 patch (and update the
I-pipe git noarch branch), and maybe for the AT91 people to issue
their patch (the I-pipe patch for ARM is such that you can apply it
with or without the AT91 patch, this requires some work).

-- 
 Gilles

