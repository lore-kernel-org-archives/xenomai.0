Message-ID: <2ff1a98a0710160745h60034016s75412af9c7195d4e@domain.hid>
Date: Tue, 16 Oct 2007 16:45:07 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <470C72E4.3020705@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <470C72E4.3020705@domain.hid>
Subject: Re: [Xenomai-help] userspace/kernelspace
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

On 10/10/07, Roland Tollenaar <rwatollenaar@domain.hid> wrote:
> Hi,
>
> This may be a weird question, but how compatible is the userspace of one
> xenamoai release to the kernel space of a later xenomai release.

There are two compatibilities:
- for ABI compability between kernel and user-space, there is an ABI
revision built-in Xenomai, which forbids running too recent Xenomai
libraries with old kernel-space support;
- for interface compatibility between applications and user-space
libraries, Xenomai user-space libraries are versioned.

>
> I.e. if I have an application compiled against xenomai 2.3.1 kernel
> 2.6.16 for example and three years down the line I want to run the
> binary of that application on a machine featuring kernel 2.6.22 and say
> xenomai 2.4.7. What are the odds that it will work?
>
> And if that will not work, what are the odds that the application can
> simply be recompiled with no changes to the code against the new
> combination?

We try to make things as much compatible as possible, so recompiling
should work. Sometimes, however, the API evolve, in this case, the
file ksrc/skins/*/API.CHANGES is updated.

-- 
                                               Gilles Chanteperdrix

