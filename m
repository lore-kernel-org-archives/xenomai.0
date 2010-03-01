Message-ID: <4B8BE901.8050009@domain.hid>
Date: Mon, 01 Mar 2010 17:19:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1Nl4tX-0001N9-Hb@domain.hid>
	<4B881E9D.1050101@domain.hid>	<4B88203F.2020907@domain.hid>
	<4B8903E1.3020805@domain.hid> <4B8B7540.609@domain.hid>
	<4B8B84BC.90300@domain.hid> <4B8B971D.5080807@domain.hid>
	<4B8B98F5.10602@domain.hid> <4B8BA361.1040807@domain.hid>
	<4B8BC277.4010108@domain.hid> <4B8BC62F.6090403@domain.hid>
	<4B8BCC09.8030100@domain.hid> <4B8BCDB5.2010103@domain.hid>
	<4B8BCF48.70603@domain.hid> <4B8BD4D4.2060109@domain.hid>
In-Reply-To: <4B8BD4D4.2060109@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : RTDM+POSIX: Avoid
 leaking binding objects on errors
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> Right, the trick is likely to properly maintain the output fds of
> bind_all in that not only pending fds are set, but others are cleared -
> avoids the third bitmap. Still playing with such an approach.

What we are trying to do, in a nutshell, is to create a notion of
stateless binding between a file descriptor and an xnselector. If we
really want to do this, we will have to extend the xnselect interface.
But this looks really wrong to me.

It seems possible to keep the bindings around as long as the file
descriptor exists. The binding is here for this reason, to express the
link between the file descriptor and the thread which runs select, and
its lifecycle should be the same as the file descriptor. And if you want
to signal that such a file descriptor is ready for reading/writing, even
if it is closed, you should be using xnselect_signal. The interface is
there, it is meant for that.

So, the more I think about it, the more I think that we are going in the
wrong direction.

-- 
					    Gilles.

