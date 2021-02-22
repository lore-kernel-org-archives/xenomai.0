MIME-Version: 1.0
References: <SN6PR08MB56613FE5201E248CC7901EB093819@SN6PR08MB5661.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB56613FE5201E248CC7901EB093819@SN6PR08MB5661.namprd08.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 22 Feb 2021 09:12:32 -0500
Message-ID: <CALLqZ8QsOrU62afZpPck=rJWCpnjtVVRs94Zkzg3SW8YwBqWrA@mail.gmail.com>
Subject: Re: Incompatible pointer type error when compiling kernel
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gabriel Dinse <gabriel_dinse@hotmail.com>
Cc: xenomai@xenomai.org

On Mon, Feb 22, 2021 at 5:15 AM Gabriel Dinse via Xenomai <
xenomai@xenomai.org> wrote:

>  > This is a 32-bit build running on the rpi3?
> Yes, it is
>
>  > I have some ipipe fixes coming, but I don't think these are ipipe
> related.
>  > Can you show how you patched and built your kernel? I'll try to
> reproduce
>  > on my end.  What compiler are you using?
>
> For patching the kernel, I did:
> xenomai-3.1 on =EE=82=A0 main =E2=9E=9C ./scripts/prepare-kernel.sh
> --linux=3D~/Projects/linux-kernels/linux-5.4.93-ipipe --arch=3Darm
> --ipipe=3D~/Projects/linux-kernels/ipipe-core-5.4.93-arm-0.patch
>
> The config I'm using is multi_v7_defconfig modified a little bit. The
> same configuration was fine for Vanilla kernel using the same version
> (5.4.93), as I was pretending to compare both.
>
> Toolchain I'm using, selected directly on buildroot-2020.02.11 long
> term is: Linaro ARM 2018.05


Okay, I used that defconfig during the port so there shouldn=E2=80=99t be a
problem. Let me try with my repos and I=E2=80=99ll let you know shortly.

-Greg

>
>
>
