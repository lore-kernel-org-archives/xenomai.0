MIME-Version: 1.0
Sender: mfornero@gmail.com
In-Reply-To: <1124806E0C09F04A992E69AE2EC7FA3C80A996@swexchange01.itk.local>
References: <1124806E0C09F04A992E69AE2EC7FA3C80A6B1@swexchange01.itk.local>
	<CADVgf9koTnR2AnnF3sOdpzFBN3j0TWbd8go_5c-=2MWs01cu4g@mail.gmail.com>
	<1124806E0C09F04A992E69AE2EC7FA3C80A996@swexchange01.itk.local>
Date: Fri, 9 Aug 2013 08:46:24 -0400
Message-ID: <CADVgf9=MQhbxBhCd_YBRBX4B-bine6ZjVo8s8EUe-FOAdE=a2g@mail.gmail.com>
From: Matthew Fornero <mfornero.lists@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Problems with running Xenomai on Core i5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tobias Luksch <Tobias.Luksch@itk-engineering.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Aug 9, 2013 at 8:41 AM, Tobias Luksch
<Tobias.Luksch@itk-engineering.de> wrote:
> Hello Matt,
>
> thank you very much for your suggestion. Clearing the second bit of the M=
SR_IA32_POWER_CTL register did in fact do the trick. The Xenomai latency te=
st program as well as my little test app now behave much better. No more ch=
ange in computation time, no more jitter when adding CPU load. Perfect!

Glad to hear it helped.

CC'ing the list in case anyone else encounters a similar issue.

-Matt

