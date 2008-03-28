Message-ID: <d6c8ef150803280646y4fd12734v862b4f399727a5b5@domain.hid>
Date: Fri, 28 Mar 2008 14:46:54 +0100
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <2ff1a98a0803280605j43811112y1c29e61edd0bc53c@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150803280435s2fb6a459kcfe68a0dde86b34c@domain.hid>
	<2ff1a98a0803280605j43811112y1c29e61edd0bc53c@domain.hid>
Subject: Re: [Xenomai-help] Using shared memory, Xenomai 2.4.2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai-help <xenomai@xenomai.org>

Ok. But, actually I dont need native-to-posix mode. I just need to
share memory betweend kernel thread and user space application.

On 3/28/08, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On Fri, Mar 28, 2008 at 12:35 PM, Bosko Radivojevic
> <bosko.radivojevic@domain.hid> wrote:
> >  Also, I've enable during kernel compilation in posix skin option
> >  'shared memory'. Also, I tried with posix skin in user space:
> >  [..]
> >  fd = shm_open ("MainSHM", O_RDWR, 0);
> >  [..]
> >
> >  When I start it, on the console I can see:
> >  shm_open: No such file or directory
> >  Xenomai: POSIX: destroyed thread c4802400
>
> Native and POSIX shared heap namespaces are separated. To create a
> shared heap for communications between kernel-space and user-space
> using posix interface, you have to pass O_CREAT to shm_open on either
> side.
>
> --
>  Gilles
>

-- 
Sent from Gmail for mobile | mobile.google.com

