From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <d25-61a62700-27-1ed4ee4@258913418>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 30 Nov 2021 15:58:40 +0100
MIME-Version: 1.0
Message-ID: <d23-61a63c00-35-25b05b40@3897673>
Subject: =?utf-8?q?Re=3A?= IRQ not raised switching from =?utf-8?q?4=2E4=2Ex?=
 to =?utf-8?q?4=2E19=2Ex?=
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

So I guess I have the beginning of the explanation.
By checking the GIC registers more thoroughly, I found out the trigger =
type was not set properly (my device uses edge interrupts, and GIC was =
setup with level interrupts)
What's not clear is that the interrupt trigger type is set, if I unders=
tand correctly, when one calls platform=5Fget=5Firq (if IRQ flags are s=
et in the DT, they are setup at that moment).
That seems to work OK for linux interrupts, but somehow, these flags ge=
t reset for xenomai interrupts (and that did not seem to be the case ea=
rlier).
Still digging there to find out what's going on.

I found out that rtdm=5Firq=5Frequest can have RTDM=5FIRQTYPE=5FEDGE as=
 flag argument, but I'm still not sure how this flag gets handed to ipi=
pe and then to the GIC.

Still searching

Fran=C3=A7ois

Le Mardi, Novembre 30, 2021 14:28 CET, Fran=C3=A7ois Legal via Xenomai =
<xenomai@xenomai.org> a =C3=A9crit: 
 
> Hello,
> 
> I'm experiencing a weird issue while transitioning Xenomai 3.1 from l=
inux 4.4 to 4.19.
> Platform is Zynq 7000 ARM Cortex A9.
> Using the exact same hardware, porting a network device driver, the i=
nterrupts that should trigger whenever a packet is sent or received do =
not grif any more. I can see the network packets being sent & received =
by devmem'ing to the device memory and buffers, but no interrupt ever h=
appens.
> 
> I checked the various GIC registers, and everything seems to be OK.
> 
> Any idea ?
> 
> Thanks in advance
> 
> Fran=C3=A7ois
> 
>


