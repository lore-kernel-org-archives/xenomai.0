MIME-Version: 1.0
References: <SN6PR08MB56613FE5201E248CC7901EB093819@SN6PR08MB5661.namprd08.prod.outlook.com>
 <CALLqZ8QsOrU62afZpPck=rJWCpnjtVVRs94Zkzg3SW8YwBqWrA@mail.gmail.com>
 <SN6PR08MB5661C3C2C5B38134D7D9946493819@SN6PR08MB5661.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB5661C3C2C5B38134D7D9946493819@SN6PR08MB5661.namprd08.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 22 Feb 2021 17:26:56 -0500
Message-ID: <CALLqZ8QzpKDORmfNvXH746eq_4WvT+i-NU5SSHVuDOikhHUCwA@mail.gmail.com>
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
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Feb 22, 2021 at 3:19 PM Gabriel Dinse <gabriel_dinse@hotmail.com>
wrote:

>
>
> On Mon, Feb 22, 2021 at 9:12 am, Greg Gallagher <greg@embeddedgreg.com>
> wrote:
>
>
>
> On Mon, Feb 22, 2021 at 5:15 AM Gabriel Dinse via Xenomai <
> xenomai@xenomai.org> wrote:
>
>>  > This is a 32-bit build running on the rpi3?
>> Yes, it is
>>
>>  > I have some ipipe fixes coming, but I don't think these are ipipe
>> related.
>>  > Can you show how you patched and built your kernel? I'll try to
>> reproduce
>>  > on my end.  What compiler are you using?
>>
>> For patching the kernel, I did:
>> xenomai-3.1 on =EE=82=A0 main =E2=9E=9C ./scripts/prepare-kernel.sh
>> --linux=3D~/Projects/linux-kernels/linux-5.4.93-ipipe --arch=3Darm
>> --ipipe=3D~/Projects/linux-kernels/ipipe-core-5.4.93-arm-0.patch
>>
>> The config I'm using is multi_v7_defconfig modified a little bit. The
>> same configuration was fine for Vanilla kernel using the same version
>> (5.4.93), as I was pretending to compare both.
>>
>> Toolchain I'm using, selected directly on buildroot-2020.02.11 long
>> term is: Linaro ARM 2018.05
>
>
> Okay, I used that defconfig during the port so there shouldn=E2=80=99t be=
 a
> problem. Let me try with my repos and I=E2=80=99ll let you know shortly.
>
>
> Ok, sure
> Let me know if I need to change configuration on my side from compiling i=
t
> again.
>
> -Greg
>
>>
>>
>> I built directly from the ipipe-arm tree, using Xenomai 3.1 ang gcc 10.
Other than a few warnings that I'll silence later everything built okay.
Let me take a look at the patch and see if something went wrong there.  In
the meantime if you want to sync the ipipe-arm tree and use the ipipe/5.4.y
patch you should be able to build no problem.  In the meantime I'll look at
the patch, but I think our CI system uses the patch and hasn't seen any
build issues.  If you could run your patch command again with --verbose and
send the output maybe that may tell us something.

Thanks

Greg
