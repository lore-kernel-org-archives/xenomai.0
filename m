From: BREGARDIS Cedric <cedric.bregardis@transport.alstom.com>
Date: Thu, 1 Sep 2016 08:58:51 +0000
Message-ID: <8d544c56950547518f0e6aa5908ddf0a@AM3PR48MB0130.041d.mgd.msft.net>
References: <b3a6f4c97449444a9f315329b4b7faf1@AM3PR48MB0130.041d.mgd.msft.net>
 <1d69d480-52da-5a17-2ca9-d9b5ce296501@mperpetuo.com>
In-Reply-To: <1d69d480-52da-5a17-2ca9-d9b5ce296501@mperpetuo.com>
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
> > Do you see any problem in my configuration, or is it a bug? Please, do
> > not hesitate to ask me more information if needed. I am trying to
> > understand the problem, but with no success for now.
>
> I can confirm that this is a bug. The fpsimd switch mechanism on the
> Xenomai side does not work correctly with newer kernels. Further, disabli=
ng
> lazy switching won't help either, as ipipe is not aware of the optimized
> switching algorithm used by this kernel.

Do you know if there is a workaround? Maybe a previous version of
ipipe/linux (where to find it ?)?

I suppose that using soft-float could also be a solution (but I will
definitely need hard float for my application)?

Best regards,
Cedric

________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may =
be privileged. If you are not a named recipient, please notify the sender i=
mmediately and do not disclose the contents to another person, use it for a=
ny purpose or store or copy the information in any medium.

