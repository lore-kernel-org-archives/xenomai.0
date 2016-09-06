From: BREGARDIS Cedric <cedric.bregardis@transport.alstom.com>
Date: Tue, 6 Sep 2016 16:02:52 +0000
Message-ID: <e97e0cc68f64487182e38b4707f5622e@AM3PR48MB0130.041d.mgd.msft.net>
References: <b3a6f4c97449444a9f315329b4b7faf1@AM3PR48MB0130.041d.mgd.msft.net>
 <1d69d480-52da-5a17-2ca9-d9b5ce296501@mperpetuo.com>
 <8d544c56950547518f0e6aa5908ddf0a@AM3PR48MB0130.041d.mgd.msft.net>
 <115943e8-eaf2-66f2-800f-bee51b5f9375@mperpetuo.com>
In-Reply-To: <115943e8-eaf2-66f2-800f-bee51b5f9375@mperpetuo.com>
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] [ARM64] Context saving problem with floating point
 registers?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>



> De : Xenomai [mailto:xenomai-bounces@xenomai.org] De la part de Dmitriy
> Cherkasov
>
> > Do you know if there is a workaround? Maybe a previous version of
> > ipipe/linux (where to find it ?)?
>
> For now I think the most stable fpsimd support is in the 3.18 kernel, whi=
ch
> can be found in Jorge's hikey port here:
>
> http://git.xenomai.org/ipipe-jro.git/
>
> And here is the Xenomai side to go with it, also in the hikey branch:
>
> http://git.xenomai.org/xenomai-jro.git/
>

Thank you very much Dmitriy!

Unfortunately I only have a version 3.14 and 4.1 of the linux kernel
for my SoC. I may port it to 3.18, but I fear it may be a bit
difficult/time consuming. So before doing it, I am thinking about
other alternatives in order to achieve my goal: measure the execution
time of an existing xenomai application (written for Xenomai 2 and
Cortex A9) on this new SoC. This application do a lot of floating
point operations.

Here are other options I could imagine:
1 - Contain the bug. Will I meet the floating point context saving
problem if the xenomai application do not switch to the Linux
Domain? Maybe the floating point problem only occur in certain
conditions that I can ensure to not meet?
2 - Use the SoC in 32 bits mode (aarch32). Does the fpsimd switch
mechanism works correctly on 32 bits ARM on xenomai for 4.1.x?
3 - Wait for a correction of xenomai. Is it expected to be available
soon? It would be unfortunate to work on a complex workaround while
someone is working on this problem and will release a fix soon.

Best regards,
Cedric


________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may =
be privileged. If you are not a named recipient, please notify the sender i=
mmediately and do not disclose the contents to another person, use it for a=
ny purpose or store or copy the information in any medium.

