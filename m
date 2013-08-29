Message-ID: <521F3F1F.4020505@aaton.com>
Date: Thu, 29 Aug 2013 14:31:27 +0200
From: Nicolas Pinault <nicolasp@aaton.com>
MIME-Version: 1.0
References: <CAMZj-5M0tr1Mqc7w10gTnfBwkHnY7xq87NOxNtc4TiPuX2_cvA@mail.gmail.com>
In-Reply-To: <CAMZj-5M0tr1Mqc7w10gTnfBwkHnY7xq87NOxNtc4TiPuX2_cvA@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Virtualization with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

Le 29/08/2013 13:06, Asier Tamayo Arbide a =E9crit :
> Hello all,
>
> My embedded system has two boards running Linux: one runs the user
> interface and the other one the critical real-time tasks. Both boards are
> running Xenomai on an Atom N270 chipset.
>
>
>
> Now, I am planning to compact my system in just one board and have two
> options. The first one is to execute everything using Xenomai and the
> second one is to port my user interface to Windows and to run both Windows
> and Xenomai on top of a hypervisor. My e-mail regards this second option.
>
>
>
> I would like to know if anyone has any experience with this. Is the
> real-time response affected in any way when using a hypervisor? My current
> kernel has been compiled using the ELinOS Embedded Linux distribution. Do=
 I
> have to patch it?
>
>
>
> I am studying Xen, VmWare, KVM and Enea. Do you recommend any of them? The
> board I=92ll use in the new (compact) system will support virtualization
> extensions (Intel VT).
>
In Windows world, use RTX :=20
http://www.intervalzero.com/products/rtx-rtx64/overview/

>
> Thank you for your help. Best regards,
>
>
>
> Ata
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


