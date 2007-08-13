Message-ID: <2ff1a98a0708130059h29c8d5f1xc4f27133f5b06c6c@domain.hid>
Date: Mon, 13 Aug 2007 09:59:22 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <41f748550708122250yd388c4ehe9992464579d5924@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <41f748550708122250yd388c4ehe9992464579d5924@domain.hid>
Subject: Re: [Xenomai-help] Kernel Space support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Iwan Budi Kusnanto <iwanbk@domain.hid>
Cc: xenomai@xenomai.org

On 8/13/07, Iwan Budi Kusnanto <iwanbk@domain.hid> wrote:
> Hello all,
> i'm new to xenomai. In the website xenomai.org , one of xenomai goal
> is "hard real-time support to user-space applications". What about
> hard realtime support to kernel space ?
> In paper "Life with adeos', the author wrote "Support for realtime
> threads exclusively running in kernel space is a reminiscence of the
> mere cokernel era, before the advent of true realtime support in
> userspace, when real-time applications would only run embodied into
> kernel modules; this feature has been kept in Xenomai mainly for the
> purpose of supporting legacy applications".
>
> I browse xenomai API and found many API support to kernel space. But,
> RTAI have more.

Could you point us to an example ?

 I consider using xenomai because of xenomai's cleannes
> design.
>
> What about hard realtime support to kernel space ?

Xenomai supports hard real-time in kernel space but... Are you sure
you really want to develop an application in the discomfort of
kernel-space ? It makes little sense on high-end platforms. Did you
consider the legal issues? The linux kernel is licensed under GPL, so
Xenomai kernel-space support is also licensed under GPL, and your
application has to be licensed under GPL, which means that you should
distribute the sources to anyone to which you distribute your
application.

-- 
                                               Gilles Chanteperdrix

