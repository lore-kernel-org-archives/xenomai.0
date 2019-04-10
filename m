MIME-Version: 1.0
References: <d53140e58f60459694e2e66a94d0a518@systemceramics.com>
 <CAPR3TAitTeY0rNVZ6v0moFzh0d_hA6zyS-R3fm+DK+HX4yj3PQ@mail.gmail.com>
 <04ffd701-4df7-5a2b-8000-cf5bec9d06d7@siemens.com>
 <CAPR3TAg=5on1=gJHSChHHwAb3AafZNx3jizMerdZvYKnN5YObA@mail.gmail.com>
 <9d5a6b6e-d7ba-00cd-3851-b26961ebbee7@siemens.com>
 <a7f863b1-9389-4a04-152d-8bc1ec0d723c@siemens.com>
 <CAPR3TAitwUBW8AzOX6cWyBgnp+bKhiNHWE3PBfs-OdAcQSCANw@mail.gmail.com>
 <48849a99-34f6-a84f-22cc-664028431ae7@siemens.com>
 <CAPR3TAg8-QsV+yENSF=Vy7GTfbes2Smtbjo-u2b=MNQ3EnSqLg@mail.gmail.com>
 <6ffa5a27-de0f-5372-8954-6791b52dcd84@siemens.com>
 <ac901e68-599f-3832-8272-aac089ff943f@siemens.com>
 <e682fe6b-b0ce-9f5c-b236-556064024b61@siemens.com>
 <CAPR3TAi4AMMaNx8e-NBQ=Ukfn-h3FKEAyQL4B=1AybD6_E=bMg@mail.gmail.com>
 <CAPR3TAjGWOsuuXr=e1RdZ_db6q_EKzQkLnK4Wipv6cyYe_YtUA@mail.gmail.com>
 <4f8724ee-d2ae-9a56-6597-9c4131574354@siemens.com>
 <CAPR3TAj3NiCVxezSJEW0LTxvVcOuNr9GMmrebABmCWcVrMXSEw@mail.gmail.com>
 <1318594e-d38b-8fa0-9b58-12affc833826@web.de>
In-Reply-To: <1318594e-d38b-8fa0-9b58-12affc833826@web.de>
From: cagnulein <cagnulein@gmail.com>
Date: Wed, 10 Apr 2019 21:45:28 +0200
Message-ID: <CAPR3TAh4uEFCsGFjQWv29E+HTuxj8L=LuAbq8X=r+QSvrYEOMg@mail.gmail.com>
Subject: Re: kvm fpu warning on 4.14.89
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai@xenomai.org

It's a dual core 8th Gen Intel atom.
In the future I will use a quad core atom and probably I will isolate a
core.
I will investigate on ipipe traces. I will let you know, but for me it's OK
anyway.

Il mer 10 apr 2019, 21:36 Jan Kiszka <jan.kiszka@web.de> ha scritto:

> On 10.04.19 21:26, cagnulein via Xenomai wrote:
> > After 3 days of test (latency + windows 10 with cpu-z and stress test) I
> > reached rare peaks of 130 us.
> > For me it's OK but I think there is a small "regression" against the 4.9
> > Do you need any other test?
>
> What is the CPU / SoC here? Are we talking about some Atom or rather some
> Xeon?
>
> If you want us to understand that peak, and if it was just less likely on
> 4.9,
> we would need an ipipe trace from that event. The latency test can trigger
> a
> freeze. We likely needs around 1000 back_trace_points for that.
>
> BTW, as mixing virtualization workload with RT won't make both faster and
> may
> have bad side effects, also on both, isolating them on separate cores
> should be
> preferred whenever possible.
>
> Jan
>
